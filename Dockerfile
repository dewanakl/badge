FROM php:8.2-apache

RUN apt-get update --fix-missing
RUN apt-get install -y zip unzip libonig-dev libicu-dev
RUN apt-get install -y libzip-dev libpng-dev libwebp-dev libpq-dev
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libjpeg-dev
RUN apt-get install -y build-essential libssl-dev zlib1g-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install pdo zip pdo_pgsql pgsql mbstring intl opcache
RUN docker-php-ext-enable pdo zip pdo_pgsql pgsql gd mbstring intl opcache

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/
WORKDIR /var/www/html/

COPY default.conf /etc/apache2/sites-available/000-default.conf

ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction
RUN chown -R www-data:www-data cache
