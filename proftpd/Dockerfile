FROM ubuntu:16.04
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends curl jq netcat proftpd-mod-mysql mariadb-client-10.0 openssl -y --allow-unauthenticated \
    && apt-get clean all \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN groupmod -g 82 www-data \
    && usermod -u 82 -s /bin/false -d /bin/null -c "proftpd user" -g www-data www-data \
    && mkdir -p /var/www \
    && sed -i "s/# DefaultRoot/DefaultRoot/g" /etc/proftpd/proftpd.conf \
    && sed -i "s/# RequireValidShell/RequireValidShell/g" /etc/proftpd/proftpd.conf \
    && sed -i "s|#Include /etc/proftpd/sql.conf|Include /etc/proftpd/sql.conf|g" /etc/proftpd/proftpd.conf \
    && sed -i "s/#LoadModule mod_sql\.c/LoadModule mod_sql\.c/g" /etc/proftpd/modules.conf \
    && sed -i "s/#LoadModule mod_sql_mysql.c/LoadModule mod_sql_mysql.c/g" /etc/proftpd/modules.conf \
    && sed -i "s/#LoadModule mod_quotatab_sql.c/LoadModule mod_quotatab_sql.c/g" /etc/proftpd/modules.conf \
    && sed -i "s/^#.PassivePorts.*/PassivePorts 60000 60100/g" /etc/proftpd/proftpd.conf

EXPOSE 20 21 60000-60100

ENV MYSQL_PORT=3306 \
    MYSQL_DATABASE=ftp \
    MYSQL_HOST=mysql \
    MYSQL_USER=root \
    MYSQL_PASSWORD=root \
    MasqueradeAddress=**IP** \
    TSL_CERTFILE=null \
    TSL_KEYFILE=null

VOLUME /var/www

COPY sql /var/lib/proftpd
COPY sql.conf /etc/proftpd/sql.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

CMD ["docker-entrypoint.sh"]