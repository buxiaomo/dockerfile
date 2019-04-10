#!/bin/bash
id=false
cluster=false

function SET_ZOOKEEPER_CONFIGURE() {
    grep -w "#$1" ${ZOOKEEPER_HOME}/conf/zoo.cfg &> /dev/null && sed -i "s/#$1/$1/g" ${ZOOKEEPER_HOME}/conf/zoo.cfg
    grep -w $1 ${ZOOKEEPER_HOME}/conf/zoo.cfg &> /dev/null
    if [ $? -eq 0 ];then
        sed -i "s#$1=.*#$1=$2#g" ${ZOOKEEPER_HOME}/conf/zoo.cfg
    else
        echo "$1=$2" >> ${ZOOKEEPER_HOME}/conf/zoo.cfg
    fi
}

# 设置zookeeper参数
for C in ${ZOOKEEPER_CONFIG}
do
    K=$(echo ${C} | awk -F '=' '{print $1}')
    V=$(echo ${C} | awk -F '=' '{print $2}')
    case ${K} in
        "zookeeper.cluster" )
            i=1
            for node in $(echo ${V} | sed "s/,/\n/g")
            do
                grep -w "server.${i}=${node}" ${ZOOKEEPER_HOME}/conf/zoo.cfg &> /dev/null
                if [ $? -ne 0 ];then
                    echo "server.${i}=${node}"  >> ${ZOOKEEPER_HOME}/conf/zoo.cfg
                fi
                i=$(($i+1))
            done
            cluster=true
        ;;
        "id" )
            if [ ! -e /var/lib/zookeeper/myid ];then
                echo "${V}" > /var/lib/zookeeper/myid
            fi
            id=true
        ;;
        * )
            if [ ${K} != "dataDir" ];then
                SET_ZOOKEEPER_CONFIGURE ${K} ${V}
            fi
        ;;
    esac
done
if [[ ${cluster} == true ]];then
    if [[ ${id} == false ]];then
        echo "Please Set id"
        exit 1
    fi
fi

exec ${ZOOKEEPER_HOME}/bin/zkServer.sh start-foreground