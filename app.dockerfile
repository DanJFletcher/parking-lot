FROM php:7.3.6-fpm-stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev mysql-client libmagickwand-dev libpng-dev supervisor \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install pdo_mysql bcmath opcache \
    && docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install pcntl \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug
     
COPY docker/config/php/conf.d/*.ini /usr/local/etc/php/conf.d/

COPY docker/supervisord.conf /etc/supervisord.conf
