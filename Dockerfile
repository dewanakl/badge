FROM php:8.2-apache

RUN apt-get update
RUN apt-get install -y zip unzip libonig-dev libicu-dev
RUN apt-get install -y libzip-dev libpng-dev libwebp-dev

RUN docker-php-ext-install pdo zip pdo_mysql gd
RUN docker-php-ext-enable pdo zip pdo_mysql gd mbstring intl opcache

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/
WORKDIR /var/www/html/

COPY default.conf /etc/apache2/sites-available/000-default.conf

ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction
RUN chown -R www-data:www-data cache

RUN service apache2 restart
