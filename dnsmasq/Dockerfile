FROM alpine:3.12.0

RUN apk --no-cache add dnsmasq=2.81-r0

VOLUME /etc/dnsmasq.d

EXPOSE 53 53/udp

ENTRYPOINT ["dnsmasq", "-k"]