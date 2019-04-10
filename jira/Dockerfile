FROM java:8u111-jre
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.jessie.list /etc/apt/sources.list

RUN echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

ENV JIRA_VERSION=7.11.2
RUN wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}-x64.bin \
        -O /usr/local/src/atlassian-jira-software-${JIRA_VERSION}-x64.bin \
    && chmod a+x /usr/local/src/atlassian-jira-software-${JIRA_VERSION}-x64.bin \
    && ./usr/local/src/atlassian-jira-software-${JIRA_VERSION}-x64.bin

EXPOSE 8080 8005

# VOLUME ["/var/lib/kafka"]

CMD ["docker-entrypoint.sh"]