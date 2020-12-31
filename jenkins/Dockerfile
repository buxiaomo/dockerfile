FROM jenkins/jenkins:2.273

USER root

# Docker
ARG DOCKER_VERSION=19.03.9
RUN wget -O /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar --strip-components=1 -xvzf /tmp/docker.tgz -C /usr/local/bin docker/docker \
    && rm -rf /tmp/docker.tgz

COPY plugins.txt /tmp/
RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')