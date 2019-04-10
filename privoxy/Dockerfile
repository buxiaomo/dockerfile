FROM alpine:3.8

RUN apk add --no-cache privoxy

CMD [ "/usr/sbin/privoxy","--no-daemon","--pidfile","/var/run/privoxy.pid","--user","privoxy","/etc/privoxy/config" ]