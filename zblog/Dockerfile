FROM php:7.2.0-fpm-alpine3.7
MAINTAINER "Xiao Mo" <root@xiaomo.red>

COPY repositories /etc/apk/repositories

RUN docker-php-ext-install pdo_mysql mysqli

# gd
RUN apk add --no-cache libpng-dev libjpeg-turbo-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

ENV ZBLOG_VERSION=1.5.1
RUN set -ex; \
	curl -o Z-BlogPHP.zip -fSL "https://update.zblogcn.com/zip/Z-BlogPHP_1_5_1_1740_Zero.zip"; \
	mkdir /usr/src/zblog; \
	unzip Z-BlogPHP.zip -d /usr/src/zblog; \
	rm Z-BlogPHP.zip; \
	chown -R www-data:www-data /usr/src/zblog; \
	chmod -R 755 /usr/src/zblog/zb_install /usr/src/zblog/zb_system /usr/src/zblog/zb_users

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
