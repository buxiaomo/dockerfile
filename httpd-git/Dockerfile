FROM httpd:2.4.34
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY ./sources/sources.list /etc/apt/sources.list
COPY ./sources/backports.list /etc/apt/sources.list.d/backports.list
COPY ./sources/stretch.list /etc/apt/sources.list.d/stretch.list

# Add mod_auth_mysql Module
RUN apt-get update \ 
    && apt-get install patch wget g++ libmysqld-dev -y \
    && wget https://sourceforge.net/p/modauthmysql/patches/13/attachment/mod_auth_mysql_3.0.0_patch_apache2.4.diff -O /usr/local/src/mod_auth_mysql_3.0.0_patch_apache2.4.diff \
    && wget https://nchc.dl.sourceforge.net/project/modauthmysql/modauthmysql/3.0.0/mod_auth_mysql-3.0.0.tar.gz -O /usr/local/src/mod_auth_mysql-3.0.0.tar.gz \
    && tar -zvxf /usr/local/src/mod_auth_mysql-3.0.0.tar.gz -C /usr/local/src \
    && cd /usr/local/src \
    && patch -p0 < mod_auth_mysql_3.0.0_patch_apache2.4.diff \
    && apxs -c -L/usr/lib64/mysql -I/usr/include/mysql -lmysqlclient -lm -lz mod_auth_mysql-3.0.0/mod_auth_mysql.c \
    && apxs -i mod_auth_mysql-3.0.0/mod_auth_mysql.la \
    && rm -rf /usr/local/src/* \
    && apt-get remove --purge patch wget g++ libmysqld-dev -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* /usr/local/apache2/htdocs/*
COPY ./conf/mysql_auth_module.conf /usr/local/apache2/conf/extra

# Add Git
RUN apt-get update \ 
    && apt-get install --no-install-recommends git git-core -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*


# Add git config
# COPY ./conf/git.conf /usr/local/apache2/conf/extra
COPY ./conf/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV USERNAME=admin \
    PASSWORD=admin \
    ProgectName=test 

ENV MYSQL_ROOT_PASSWORD=root \
    MYSQL_DATABASE=git \
    MYSQL_USER=git \
    MYSQL_PASSWORD=git

WORKDIR /usr/local/apache2/htdocs

VOLUME ["/usr/local/apache2/htdocs"]

EXPOSE 80

CMD [ "docker-entrypoint.sh" ]