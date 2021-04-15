FROM openjdk:8u212-jre-alpine3.9

# gosu
ARG GOSU_VERSION=1.12
RUN wget https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 -O /bin/gosu \
    && chmod +x /bin/gosu

# git
RUN apk add --no-cache git shadow bash \
    && adduser -h /home/jenkins -u 1000 -D jenkins

# Jenkins Swarm plugins
ARG JENKINS_SWARM_VERSION=3.25
RUN wget https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}.jar -O /usr/local/bin/swarm-client.jar \
    && chmod +x /usr/local/bin/swarm-client.jar

# Docker
ARG DOCKER_VERSION=20.10.5
RUN wget -O /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar --strip-components=1 -xzf /tmp/docker.tgz -C /usr/local/bin docker/docker \
    && rm -rf /tmp/docker.tgz

# Kubectl
ARG KUBECTL_VERSION=1.20.2
RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# helm
ARG HELM_VERSION=3.3.4
RUN wget -O /tmp/helm.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar --strip-components=1 -xzf /tmp/helm.tar.gz -C /usr/local/bin linux-amd64/helm \
    && rm -rf /tmp/helm.tar.gz

ARG DOCKER_COMPOSE_VERSION=1.28.5
RUN wget -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-x86_64 \
    && chmod +x /usr/local/bin/docker-compose

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /home/jenkins

ENV PROMETHEUS_PORT -1
ENV LABELS swarm
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh", "-c", "java -jar /usr/local/bin/swarm-client.jar -name $AGENT_NAME -master $JENKINS_MASTER -username $JENKINS_USER -password $JENKINS_PASS -executors $JENKINS_EXECUTORS $JENKINS_OPTS -labels $LABELS"]