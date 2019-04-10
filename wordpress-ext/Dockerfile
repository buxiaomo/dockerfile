FROM wordpress:5.0.2-php7.1-fpm

RUN pecl install redis \
    && docker-php-ext-enable redis