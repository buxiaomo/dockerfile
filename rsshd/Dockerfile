FROM alpine:3.6
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ENV LANG=en_US.UTF-8 \
    TZ=Asia/Shanghai

RUN apk --update add --no-cache openssh tzdata rssh \
    && sed -i "s/#Port 22/Port 22/" /etc/ssh/sshd_config \
    && sed -i "s/#HostKey/HostKey/g" /etc/ssh/sshd_config \
    && sed -i "s/#PubkeyAuthentication/PubkeyAuthentication/g" /etc/ssh/sshd_config \
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin\ yes/" /etc/ssh/sshd_config \
    && sed -i "s/#UseDNS no/UseDNS no/" /etc/ssh/sshd_config \
    && sed -i "s/#PasswordAuthentication/PasswordAuthentication/" /etc/ssh/sshd_config \
    && mkdir /root/.ssh \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV USER=root \
    PASSWORD=root

EXPOSE 22
EXPOSE 10000-10100

CMD ["/docker-entrypoint.sh"]
