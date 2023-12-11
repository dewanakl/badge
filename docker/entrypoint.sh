#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction --no-dev
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env"
    cp .env.example .env
else
    echo "env file exists."
fi

php saya key

php-fpm -D
nginx -g "daemon off;"
