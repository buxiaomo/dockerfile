FROM golang:1.9-alpine as confd
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY repositories /etc/apk/repositories

ARG CONFD_VERSION=0.15.0
ADD https://github.com/kelseyhightower/confd/archive/v${CONFD_VERSION}.tar.gz /tmp/

RUN apk add --no-cache \
    bzip2 \
    make && \
  mkdir -p /go/src/github.com/kelseyhightower/confd && \
  cd /go/src/github.com/kelseyhightower/confd && \
  tar --strip-components=1 -zxf /tmp/v${CONFD_VERSION}.tar.gz && \
  go install github.com/kelseyhightower/confd && \
  rm -rf /tmp/v${CONFD_VERSION}.tar.gz

FROM golang:1.9-alpine
MAINTAINER "Mo" <root@buxiaomo.com>
COPY --from=confd /go/bin/confd /usr/local/bin/confd
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN mkdir -p /etc/confd/conf.d /etc/confd/templates

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["confd"]
