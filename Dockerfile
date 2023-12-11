# Gunakan versi PHP 8.1 dan Nginx
# FROM php:8.1-alpine

# Instal dependensi
# RUN apt-get update && apt-get install -y \
#     libzip-dev \
#     unzip \
#     nginx

# Aktifkan ekstensi PHP yang diperlukan
# RUN docker-php-ext-install pdo_mysql zip

# Instal Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Salin proyek Laravel ke dalam kontainer
# COPY . /var/www/html

# Atur izin untuk direktori penyimpanan Laravel
# RUN chown -R www-data:www-data /var/www/html/cache

# Instal dependensi proyek Laravel menggunakan Composer
# RUN composer install --optimize-autoloader --no-dev

# Salin konfigurasi Nginx
# COPY nginx.conf /etc/nginx/sites-available/default


FROM composer:2.6 as build
ENV COMPOSER_ALLOW_SUPERUSER=1
# RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction

RUN apt-get update && apt-get install -y zip

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/* && \


COPY . /var/www/html/
COPY --from=build /usr/bin/composer /usr/bin/composer
RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction

FROM php:8.1-apache-buster as production

ENV APP_ENV=production
ENV APP_DEBUG=false

RUN docker-php-ext-install pdo pdo_mysql gd pdo_pgsql
# COPY docker/php/conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

COPY --from=build /app /var/www/html
COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY .env.example /var/www/html/.env

RUN chown -R www-data:www-data /var/www/html/cache

RUN php saya key && a2enmod rewrite
