FROM ubuntu:18.04

COPY sources.list /etc/apt/sources.list 
RUN apt-get update \
    && apt-get install sudo wget -y \
    && useradd -m -g sudo -u 1000 xiaomo \
    && echo "xiaomo	ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo "nobody	ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && apt-get clean all

# Docker
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 19.03.7
RUN wget -O /usr/local/src/docker.tgz "https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
    && tar --strip-components=1 -xvzf /usr/local/src/docker.tgz -C /usr/local/bin \
    && rm -rf /usr/local/src/docker.tgz

USER nobody