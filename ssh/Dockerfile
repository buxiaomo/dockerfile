FROM openjdk:8-jdk
MAINTAINER Xiao Mo

RUN apt-get update \
    && apt-get install -y openssh-server=1:7.4p1-10+deb9u4 \
    && mkdir /var/run/sshd \
    && sed -ri 's/#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && apt-get clean all

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV ROOT_PASSWORD=root

EXPOSE 22

VOLUME [ "/var/jenkins_home" ]

CMD ["docker-entrypoint.sh"]