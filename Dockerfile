FROM php:8.2-fpm

RUN apt-get update
RUN apt-get install -y zip unzip nginx
RUN apt-get install -y libzip-dev libpng-dev libwebp-dev

RUN docker-php-ext-install pdo zip pdo_mysql gd
RUN docker-php-ext-enable pdo zip pdo_mysql gd

ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/
WORKDIR /var/www/html/

# COPY default.conf /etc/apache2/sites-available/000-default.conf
COPY nginx.conf /etc/nginx/sites-available/default

RUN composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction
RUN chown -R www-data:www-data cache

# RUN a2enmod rewrite
EXPOSE 443
CMD ["php-fpm"]
