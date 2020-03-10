FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install sudo -y \
    && useradd -m -g sudo -u 1000 xiaomo \
    && echo "xiaomo	ALL=(ALL:ALL) NOPASSWD: ALL" /etc/sudoers

WORKDIR /home/xiaomo