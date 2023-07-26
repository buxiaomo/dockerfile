FROM openjdk:11.0.14.1-jre

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && useradd -m -u 1000 jenkins -s /bin/bash \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

# Jenkins Swarm plugins
ARG JENKINS_SWARM_VERSION=3.40
RUN wget -q https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}.jar -O /usr/local/bin/swarm-client.jar \
    && chmod +x /usr/local/bin/swarm-client.jar

# gosu
ARG GOSU_VERSION=1.16

RUN set -x \
    && uname -m \
    && wget -q https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 -O /bin/gosu \
    && chmod +x /bin/gosu

# Kubectl
ARG KUBECTL_VERSION=1.27.3
RUN wget -q -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# helm
ARG HELM_VERSION=3.3.4
RUN wget -q -O /tmp/helm.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar --strip-components=1 -xzf /tmp/helm.tar.gz -C /usr/local/bin linux-amd64/helm \
    && rm -rf /tmp/helm.tar.gz

# Docker
ARG DOCKER_VERSION=24.0.4
RUN wget -q -O /tmp/docker.tgz https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz \
    && tar --strip-components=1 -xzf /tmp/docker.tgz -C /usr/local/bin docker/docker \
    && rm -rf /tmp/docker.tgz

# nerdctl
RUN wget -q -O /tmp/nerdctl-1.4.0-linux-amd64.tar.gz https://github.com/containerd/nerdctl/releases/download/v1.4.0/nerdctl-1.4.0-linux-amd64.tar.gz \
    && tar -zxf /tmp/nerdctl-1.4.0-linux-amd64.tar.gz -C /usr/local/bin \
    && chmod +s /usr/local/bin/nerdctl \
    && wget -q -O /tmp/buildkit-v0.12.0.linux-amd64.tar.gz https://github.com/moby/buildkit/releases/download/v0.12.0/buildkit-v0.12.0.linux-amd64.tar.gz \
    && tar --strip-components=1 -xzf /tmp/buildkit-v0.12.0.linux-amd64.tar.gz -C /usr/local/bin bin/buildctl \
    && rm -rf /tmp/nerdctl-1.4.0-linux-amd64.tar.gz /tmp/buildkit-v0.12.0.linux-amd64.tar.gz

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /home/jenkins

VOLUME [ "/home/jenkins" ]

ENV PROMETHEUS_PORT -1
ENV LABELS shared
ENV JENKINS_EXECUTORS 2

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh", "-c", "java -jar /usr/local/bin/swarm-client.jar -name $HOSTNAME -master $JENKINS_MASTER -username $JENKINS_USER -password $JENKINS_PASS -executors $JENKINS_EXECUTORS -labels $LABELS $JENKINS_OPTS"]
