FROM daocloud.io/buxiaomo/oracle-jdk:8u181
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ENV VERSION 6.2.4
RUN apt-get update \
    && apt-get install wget curl -y \
    && wget http://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}.tar.gz -O /usr/local/src/elasticsearch-${VERSION}.tar.gz \
    && tar -zvxf /usr/local/src/elasticsearch-${VERSION}.tar.gz -C /usr/local/ \
    && mv /usr/local/elasticsearch-${VERSION} /usr/local/elasticsearch \
    && rm -rf /usr/local/src/* \
    && apt-get remove wget -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV ELASTICSEARCH_HOME /usr/local/elasticsearch

RUN useradd elk \
    && chown -R elk.elk /usr/local/elasticsearch

USER elk

WORKDIR /usr/local/elasticsearch

VOLUME [ "/usr/local/elasticsearch/data" ]

EXPOSE 9200

CMD ["/usr/local/elasticsearch/bin/elasticsearch"]