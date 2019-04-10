FROM java:8u111-jre
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.jessie.list /etc/apt/sources.list

RUN echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

ENV KAFKA_VERSION=0.10.2.1 \
    SCALA_VERSION=2.10
RUN apt-get update \
    && apt-get install axel --no-install-recommends -y \
    && axel -n 20 --output=/usr/local/src/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && tar -zxf /usr/local/src/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /usr/local/ \
    && rm -rf /usr/local/src/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && sed -i "s#log.dirs=.*#log.dirs=/var/lib/kafka#g" /usr/local/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/server.properties \
    && mkdir -p /var/lib/kafka \
    && apt-get remove axel -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV KAFKA_HOME=/usr/local/kafka_${SCALA_VERSION}-${KAFKA_VERSION} \
    PATH=$KAFKA_HOME/bin:$PATH

# Curl
COPY sources.ubuntu.list /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 \
    && apt-get update \
    && apt-get install curl jq --no-install-recommends -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR /usr/local/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

EXPOSE 9092 2181

VOLUME ["/var/lib/kafka"]

CMD ["docker-entrypoint.sh"]
