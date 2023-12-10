FROM php:8.0-fpm-alpine

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 badge && adduser -G badge -g badge -s /bin/sh -D badge

RUN mkdir -p /var/www/html

# ADD ./badge/ /var/www/html

RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN chown -R badge:badge /var/www/html
