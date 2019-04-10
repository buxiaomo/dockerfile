FROM java:8u111-jre
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    CLASSPATH=.:$JAVA_HOME/lib/ \
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

RUN wget -O /usr/local/src/Mycat-server-1.6-RELEASE-20161028204710-linux.tar.gz http://dl.mycat.io/1.6-RELEASE/Mycat-server-1.6-RELEASE-20161028204710-linux.tar.gz \
    && tar -zxf /usr/local/src/Mycat-server-1.6-RELEASE-20161028204710-linux.tar.gz -C /usr/local/ \
    && rm -rf /usr/local/src/Mycat-server-1.6-RELEASE-20161028204710-linux.tar.gz \
    && ln -sf /dev/stdout /usr/local/mycat/logs/mycat.log

ENV MYCAT_HOME=/usr/local/mycat \
    PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$MYCAT_HOME/bin:$PATH

VOLUME /usr/local/mycat/conf

WORKDIR ${MYCAT_HOME}

EXPOSE 8066 9066

CMD ["bin/mycat", "console"]
