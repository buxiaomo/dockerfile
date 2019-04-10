FROM debian:jessie
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install --no-install-recommends wget netcat -y \
    && wget -O /usr/local/src/tidb-latest-linux-amd64.tar.gz http://download.pingcap.org/tidb-latest-linux-amd64.tar.gz \
    && tar -zvxf /usr/local/src/tidb-latest-linux-amd64.tar.gz -C /usr/local/src/ \
    && mv /usr/local/src/tidb-latest-linux-amd64/bin/ /usr/local/tidb/ \
    && rm -rf /usr/local/src/* \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:/usr/local/tidb/

ADD tidb /usr/local/bin/tidb

VOLUME /data

EXPOSE 2379 2380 20160 10080 4000

CMD ["/usr/local/bin/tidb"]
