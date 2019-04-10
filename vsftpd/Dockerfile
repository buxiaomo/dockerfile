FROM alpine:3.5
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY repositories /etc/apk/repositories

RUN apk add --no-cache -t build  curl g++ make \
    && apk add --no-cache mariadb-dev linux-pam-dev \
    && mkdir -p /usr/local/src \
    && curl -fSL http://prdownloads.sourceforge.net/pam-mysql/pam_mysql-0.7RC1.tar.gz  -o /usr/local/src/pam_mysql-0.7RC1.tar.gz \
    && tar -zvxf /usr/local/src/pam_mysql-0.7RC1.tar.gz -C /usr/local/src \
    && cd /usr/local/src/pam_mysql-0.7RC1 \
    && ./configure --with-mysql=/usr/bin/mysql_config \
    && make && make install \
    && apk del --no-cache build \
    && rm -rf /usr/local/src

RUN apk add --no-cache vsftpd \
    && adduser -u 82 -D www-data \
    && mkdir /vsftp

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY vsftpd /etc/pam.d/vsftpd

CMD /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
