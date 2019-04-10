FROM ubuntu:16.04
MAINTAINER Xiao Mo

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install --no-install-recommends -y curl mysql-client lsb-release \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL http://repo.proxysql.com/ProxySQL/repo_pub_key | apt-key add - \
    && echo deb http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/$(lsb_release -sc)/ ./ \
       | tee /etc/apt/sources.list.d/proxysql.list \
    && apt-get update \
    && apt-get install proxysql \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

ENV ADMIN_CREDENTIALS_USER=admin \
    ADMIN_CREDENTIALS_PASS=admin 

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

VOLUME [ "/var/lib/proxysql" ]

EXPOSE 6032 6033

CMD [ "docker-entrypoint.sh" ]