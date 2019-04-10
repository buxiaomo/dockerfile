FROM daocloud.io/library/ubuntu:16.04
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

RUN useradd -m -p hadoop hadoop

# Install SSH Server
RUN apt-get update \
    && apt-get install --no-install-recommends -y openssh-server netcat sudo iputils-ping net-tools \
    && mkdir -p /var/run/sshd \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

# Install Java
RUN apt-get update \
    && apt-get install -y --no-install-recommends openjdk-8-jdk \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

# Install Hadoop
ENV HADOOP_VERSION 2.8.1
ENV HADOOP_HOME /usr/local/hadoop-${HADOOP_VERSION}
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && wget -O /usr/local/src/hadoop-${HADOOP_VERSION}.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -zxf /usr/local/src/hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local/ \
    && rm -rf /usr/local/src/hadoop-${HADOOP_VERSION}.tar.gz \
    && chown -R root.root /usr/local/hadoop-${HADOOP_VERSION} \
    && apt-get remove wget -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

ADD etc/* ${HADOOP_HOME}/etc/hadoop/
ADD key/* /key/
COPY Start /Start

ENV fs_defaultFS hdfs://master:9000

ENV dfs_namenode_secondary_http_address master:50090
ENV dfs_replication 1

ENV mapreduce_jobhistory_address master:10020
ENV mapreduce_jobhistory_webapp_address master:19888

ENV yarn_resourcemanager_hostname master

ENV TYPE NULL

EXPOSE 50070 8088

CMD ["/Start"]
