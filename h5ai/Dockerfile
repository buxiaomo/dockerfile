FROM php:8.1.18-apache

RUN apt-get update \
    && apt-get install  --no-install-recommends graphicsmagick-imagemagick-compat ffmpeg -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y zlib1g-dev libjpeg-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install -j "$(nproc)" gd \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y exiftool \
    && docker-php-ext-configure exif \
    && docker-php-ext-install -j "$(nproc)" exif \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
RUN apt-get update \
    && apt-get install zip unzip -y \
    && curl https://release.larsjung.de/h5ai/h5ai-0.30.0.zip --output /usr/local/src//h5ai-0.30.0.zip
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["apache2-foreground"]