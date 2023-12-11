# Use the official PHP image
FROM php:8.1-alpine

# Set the working directory
WORKDIR /var/www/html

# Copy the application files
COPY . /var/www/html

# Install dependencies
RUN apt-get update && \
    apt-get install -y libzip-dev zip && \
    docker-php-ext-install zip gd pdo pdo_pgsql && \
    composer install --optimize-autoloader --no-dev && \
    chown -R www-data:www-data cache && \
    cp .env.example .env && \
    php saya key

# Expose the port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
