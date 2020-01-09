FROM alpine:3.11

COPY repositories /etc/apk/repositories

ARG UDPXY_VERSION=1.0.23-12
RUN apk add --no-cache -t .build wget make gcc musl-dev \
    && mkdir -p /usr/local/src \
    && wget http://www.udpxy.com/download/1_23/udpxy.${UDPXY_VERSION}-prod.tar.gz -O /usr/local/src/udpxy.${UDPXY_VERSION}-prod.tar.gz \
    && tar -zvxf /usr/local/src/udpxy.${UDPXY_VERSION}-prod.tar.gz -C /usr/local/src/ \
    && cd /usr/local/src/udpxy-${UDPXY_VERSION} && make \
    && cp udpxy /usr/bin/udpxy \
    && rm -rf /usr/local/src \
    && apk del --no-cache .build

EXPOSE 4022

ENTRYPOINT ["/usr/bin/udpxy"]
CMD ["-p", "4022"]