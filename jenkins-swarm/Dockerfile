FROM openjdk:8u212-jre-alpine3.9

# git
RUN apk add git --no-cache \
    && adduser -h /home/jenkins -u 1000 -D jenkins

# Jenkins Swarm plugins
ARG JENKINS_SWARM_VERSION=3.24
RUN wget https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}.jar -O /usr/local/bin/swarm-client.jar \
    && chmod +x /usr/local/bin/swarm-client.jar

# Docker
ARG DOCKER_VERSION=19.03.9
RUN wget -O /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar --strip-components=1 -xvzf /tmp/docker.tgz -C /usr/local/bin docker/docker \
    && rm -rf /tmp/docker.tgz

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /home/jenkins

USER jenkins

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh", "-c", "java -jar /usr/local/bin/swarm-client.jar -master $JENKINS_MASTER -username $JENKINS_USER -password $JENKINS_PASS -executors $JENKINS_EXECUTORS -name $PROJECT -labels $LABELS $JENKINS_OPTS"]