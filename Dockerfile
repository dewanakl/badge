# Use the official PHP image with FPM
FROM php:8.1-fpm-alpine

# Set the working directory
WORKDIR /var/www/html

# Copy the application files
COPY . /var/www/html

# Install dependencies
RUN docker-php-ext-install zip gd pdo pdo_pgsql && \
    composer install --optimize-autoloader --no-dev && \
    chown -R www-data:www-data cache && \
    cp .env.example .env && \
    php saya key

# Expose the port
# EXPOSE 80

# Start PHP-FPM
CMD ["php-fpm"]

