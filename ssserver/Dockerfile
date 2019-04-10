FROM alpine:3.5
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ENV SS_VERSION 1.2.1
RUN apk add --virtual build --no-cache curl  \
    && apk add --no-cache pwgen \
    && curl -fsSL https://github.com/shadowsocks/shadowsocks-go/releases/download/$SS_VERSION/shadowsocks-server.tar.gz -o /tmp/shadowsocks-server.tar.gz \
    && tar -zvxf  /tmp/shadowsocks-server.tar.gz -C /usr/local/bin/ \
    && rm -rf /tmp/shadowsocks-server.tar.gz \
    && apk del build --no-cache

ENV SS_PASSWORD=**NULL** \
    SS_METHOD=aes-256-cfb

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 8388

CMD ["/docker-entrypoint.sh"]