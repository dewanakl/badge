# Gunakan versi PHP 8.1 dan Nginx
FROM php:8.1-alpine

# Instal dependensi
# RUN apt-get update && apt-get install -y \
#     libzip-dev \
#     unzip \
#     nginx

# Aktifkan ekstensi PHP yang diperlukan
# RUN docker-php-ext-install pdo_mysql zip

# Instal Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Salin proyek Laravel ke dalam kontainer
COPY . /var/www/html

# Atur izin untuk direktori penyimpanan Laravel
RUN chown -R www-data:www-data /var/www/html/cache

# Instal dependensi proyek Laravel menggunakan Composer
# RUN composer install --optimize-autoloader --no-dev

# Salin konfigurasi Nginx
COPY nginx.conf /etc/nginx/sites-available/default
