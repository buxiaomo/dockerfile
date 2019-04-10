#!/bin/bash
function SET_KAFKA_CONFIGURE() {
    grep -w "#$1" ${KAFKA_HOME}/config/server.properties &> /dev/null && sed -i "s/#$1/$1/g" ${KAFKA_HOME}/config/server.properties
    grep -w $1 ${KAFKA_HOME}/config/server.properties &> /dev/null
    if [ $? -eq 0 ];then
        sed -i "s#$1=.*#$1=$2#g" ${KAFKA_HOME}/config/server.properties
    else
        echo "$1=$2" >> ${KAFKA_HOME}/config/server.properties
    fi
}
ZK_IS_SET=false
# 设置KafKa参数
for C in ${KAFKA_CONFIG}
do
    K=$(echo ${C} | awk -F '=' '{print $1}')
    V=$(echo ${C} | awk -F '=' '{print $2}')
    if [ ${K} != "log.dirs" ];then
        # 设置zookeeper集群配置
        if [ ${K} == "zookeeper.connect" ];then
            if [ ${C} == "localhost:2181" ];then
                ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
            else
                SET_KAFKA_CONFIGURE zookeeper.connect ${ZOOKEEPER_CLUSTER}
                ZK_IS_SET=true
            fi
        fi
        if [ ${ZK_IS_SET} == false ];then
            ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
        fi
        SET_KAFKA_CONFIGURE ${K} ${V}
    fi
done

# 本次测试，支持Docker之外的访问访问没有问题，暂未测试Docker内部调用
# 根据环境变量判定是否让kafak支持Docker之外的服务访问
# 若需要支持Docker之外的服务访问请设置KAFKA_HOST_IP,KAFKA_PORT这两个环境变量
if [ ${KAFKA_HOST_IP} != "NULL" ] && [ ${KAFKA_PORT} != "NULL" ];then
    set_kafka_configure advertised.host.name $(curl -s  --unix-socket /run/docker.sock http://unix/info  | jq -r .Swarm.NodeAddr)
    # echo "advertised.host.name=${KAFKA_HOST_IP}" >> config/server.properties
    set_kafka_configure advertised.port ${KAFKA_PORT}
    # echo "advertised.port=${KAFKA_PORT}" >> config/server.properties
else
    IP=`hostname -i`
    sed -i "s/#advertised.listeners/advertised.listeners/g" config/server.properties
    sed -i "s/your.host.name:9092/${IP}:9092/g" config/server.properties
    set_kafka_configure host.name ${IP}
    # echo "=${IP}" >>  config/server.properties
fi

exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties