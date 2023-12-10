FROM php:8.0-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 badge && adduser -G badge -g badge -s /bin/sh -D badge

RUN mkdir -p /var/www/html

ADD ./src/ /var/www/html

RUN docker-php-ext-install pdo pdo_mysql gd pdo_pgsql

RUN chown -R badge:badge /var/www/html
