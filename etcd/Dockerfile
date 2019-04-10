FROM alpine:3.7
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ENV ETCD_VERSION v3.2.9
RUN mkdir -p /usr/local/src/ /var/lib/etcd \
    && wget -O /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64.tar.gz https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz \
    && tar -zxf /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64.tar.gz -C /usr/local/src \
    && cp /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64/etcd /usr/local/bin/ \
    && cp /usr/local/src/etcd-${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/ \
    && rm -rf /tmp/* /usr/local/src /var/cache/apk/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

VOLUME /etcd

EXPOSE 2379 2380 4001 7001

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["etcd"]