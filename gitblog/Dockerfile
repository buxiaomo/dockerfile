FROM wordpress:5.0.2-php7.1-fpm

ENV GITBLOG_VERSION 2.3.2
RUN set -ex \
    && apt-get update \
    && apt-get install unzip \
	&& curl -o gitblog.zip -fSL "https://github.com/jockchou/gitblog/archive/v${GITBLOG_VERSION}.zip" \
	&& unzip gitblog.zip -d /usr/src/ \
	&& rm gitblog.zip \
	&& chown -R www-data:www-data /usr/src/gitblog-${GITBLOG_VERSION} \
    && rm -rf /usr/src/gitblog-${GITBLOG_VERSION}/conf.yaml \
    && apt-get remove unzip -y \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]