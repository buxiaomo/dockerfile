FROM php:7.2.8-fpm-alpine3.7
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY repositories /etc/apk/repositories

# Mysql
RUN docker-php-ext-install pdo_mysql mysqli

# Bzip2
RUN apk add --no-cache bzip2-dev \
    && docker-php-ext-install bz2

# gd
RUN set -ex \
    && apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# mcrypt
RUN set -ex \
    && apk add --no-cache -t .build autoconf g++ make \
    && apk add --no-cache libmcrypt-dev \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    && apk del -t .build

# Redis
RUN set -ex \
    && apk add --no-cache --virtual .build-deps g++ make autoconf \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps

# Zip
RUN apk add --no-cache zlib-dev \
    && docker-php-ext-install zip

# Imagick
RUN set -ex \
    && apk add --no-cache -t .build g++ make autoconf \
    && apk add --no-cache libtool imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del .build

# iconv
RUN docker-php-ext-install iconv

# memcached
RUN set -ex \
    && apk add --no-cache -t .build g++ make autoconf \
    && apk add --no-cache libmemcached-dev \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && apk del .build

# memcache
RUN set -ex \
    && apk add --no-cache -t .build git \
    && git clone https://github.com/websupport-sk/pecl-memcache /usr/src/php/ext/memcache \
    && docker-php-ext-install memcache \
    && apk del .build

# swoole4
RUN set -ex \
    && apk add --no-cache -t .build g++ make autoconf \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
    && apk del .build