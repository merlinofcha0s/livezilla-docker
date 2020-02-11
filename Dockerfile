FROM nginx:1.13.9-alpine

MAINTAINER CASAUCAU Cyril

EXPOSE 8000
CMD ["/sbin/entrypoint.sh"]

ARG livezilla_ver
ARG archive_url

ENV livezilla_ver 8.0.1.7
ENV archive_url ${archive_url:-https://www.livezilla.net/downloads/pubfiles/livezilla_server_${livezilla_ver}.zip}

RUN apk add --no-cache --update \
    mysql-client \
    php7 \
    php7-bcmath \
    php7-dom \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-fileinfo \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-phar \
    php7-posix \
    php7-session \
    php7-simplexml \
    php7-soap \
    php7-xml \
    php7-zip \
    php7-zlib \
    php7-tokenizer \
    php7-mysqli \
    wget sqlite git curl bash grep \
    supervisor

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    ln -sf /dev/stdout /var/log/php7/error.log && \
    ln -sf /dev/stderr /var/log/php7/error.log

RUN adduser -S -s /bin/bash -u 1001 -G root www-data

RUN touch /var/run/nginx.pid && \
    chown -R www-data:root /var/run/nginx.pid /etc/php7/php-fpm.d

RUN mkdir -p /var/www/html && \
    mkdir -p /usr/share/nginx/cache && \
    mkdir -p /var/cache/nginx && \
    mkdir -p /var/lib/nginx && \
    chown -R www-data:root /var/www /usr/share/nginx/cache /var/cache/nginx /var/lib/nginx/

WORKDIR /var/www/html/
USER 1001

RUN wget ${archive_url} && \ 
    unzip livezilla_server_${livezilla_ver}.zip && \
    mv livezilla/* /var/www/html/ && \
    rm -r livezilla_server_${livezilla_ver}.zip && \
    chown -R www-data:root /var/www/html

COPY conf/php-fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY conf/supervisord.conf /etc/supervisor/supervisord.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx-site.conf /etc/nginx/conf.d/default.conf
COPY conf/config.php /var/www/html/_config/config.php
COPY entrypoint.sh /sbin/entrypoint.sh

USER root
RUN chmod g+rwx /var/run/nginx.pid && \
    chmod -R g+rw /var/www /usr/share/nginx/cache /var/cache/nginx /var/lib/nginx/ /etc/php7/php-fpm.d && \
    chmod 777 -R /var/www/html/stats /var/www/html/_log /var/www/html/_config
USER 1001
