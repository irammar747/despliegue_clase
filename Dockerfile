FROM php:8.4-apache

# Actualizamos el sistema e instalamos dependencias para Postgres y mysql
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql
