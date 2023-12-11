# Used for prod build.
FROM php:8.2-fpm-alpine

# Install dependencies.
# RUN apt-get update && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx libonig-dev

# Install PHP extensions.
# RUN docker-php-ext-install pdo pdo_pgsql bcmath curl opcache mbstring gd
# RUN docker-php-ext-enable pdo_pgsql bcmath curl opcache mbstring gd

# RUN apt-get update \
#     && docker-php-ext-install pgsqli pdo pdo_pgsql \
#     && docker-php-ext-enable pdo_pgsql bcmath curl opcache mbstring gd

# Copy composer executable.
COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

# Copy configuration files.
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

# Set working directory to /var/www.
WORKDIR /var/www

# Copy files from current folder to container current folder (set in workdir).
COPY --chown=www-data:www-data . .

# Fix files ownership.
RUN chown -R www-data /var/www/cache/views

# Set correct permission.
RUN chmod -R 755 /var/www/cache/views

# Adjust user permission & group
# RUN usermod --uid 1000 www-data
# RUN groupmod --gid 1001 www-data

# Run the entrypoint file.
ENTRYPOINT [ "docker/entrypoint.sh" ]
