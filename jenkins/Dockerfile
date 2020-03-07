FROM jenkins/jenkins:2.204.4
MAINTAINER "Xiao Mo" <root@xiaomo.site>

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

USER root

# 下载Kubernetes二进制文件
ENV KUBE_VERSION=v1.13.0
RUN wget https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/kubernetes-server-linux-amd64.tar.gz -O /usr/local/src/kubernetes-server-linux-amd64.tar.gz \
    && tar -zxvf /usr/local/src/kubernetes-server-linux-amd64.tar.gz  \
        --strip-components=3 -C /usr/local/bin \
        kubernetes/server/bin/kubectl \
    && rm -rf /usr/local/src/kubernetes-server-linux-amd64.tar.gz

COPY plugins.txt /tmp/
RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')
