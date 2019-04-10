FROM debian:9

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install bzip2 wget openssh-server -y \
    && wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-0.9.8.tar.bz2 -O /usr/local/src/iRedMail-0.9.8.tar.bz2 \
    && tar xjf /usr/local/src/iRedMail-0.9.8.tar.bz2 -C /usr/local/ \
    && mv /usr/local/iRedMail-0.9.8  /usr/local/iRedMail  \ 
    && cd /usr/local/iRedMail && mkdir -p /usr/local/iRedMail/runtime /usr/local/iRedMail/misc \