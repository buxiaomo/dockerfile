FROM daocloud.io/buxiaomo/oracle-jdk:8u181
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ENV VERSION 6.2.4
RUN apt-get update \
    && apt-get install wget -y \
    && wget https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.tar.gz -O /usr/local/src/logstash-${VERSION}.tar.gz \
    && tar -zvxf /usr/local/src/logstash-${VERSION}.tar.gz -C /usr/local/ \
    && mv /usr/local/logstash-${VERSION} /usr/local/logstash \
    && rm -rf /usr/local/src/* \
    && apt-get remove wget -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV LOGSTASH_HOME /usr/local/logstash

RUN useradd elk \
    && chown -R elk.elk /usr/local/logstash

USER elk

WORKDIR /usr/local/logstash

VOLUME [ "/usr/local/logstash/data" ]

EXPOSE 9200

CMD ["/usr/local/logstash/bin/logstash","-f","/usr/local/logstash/config/logstash.conf"]