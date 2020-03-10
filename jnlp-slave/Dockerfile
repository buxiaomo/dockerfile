FROM jenkinsci/jnlp-slave:4.0.1-1
MAINTAINER "Xiao Mo" <root@xiaomo.site>

# Docker
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 19.03.7
RUN wget -O /usr/local/src/docker.tgz "https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
    && tar --strip-components=1 -xvzf /usr/local/src/docker.tgz -C /usr/local/bin \
    && rm -rf /usr/local/src/docker.tgz