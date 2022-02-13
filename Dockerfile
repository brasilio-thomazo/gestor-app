FROM archlinux:base

ARG user
ARG uid

RUN pacman -Syu --noconfirm
RUN pacman -S php-fpm php php-gd php-pgsql php-intl php-sodium php-sqlite php-xsl php-tidy php-memcached php-redis vim --noconfirm
RUN php --version
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -G http -u ${uid} ${user}
RUN mkdir -p /run/php-fpm && chown -R ${user}:http /run/php-fpm
WORKDIR /var/www
# USER ${user}
EXPOSE 9000
ENTRYPOINT ["php-fpm","-F"]