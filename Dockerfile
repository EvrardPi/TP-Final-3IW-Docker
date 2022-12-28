FROM php:8-apache

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN apt update && apt install mariadb-client unzip git -y

RUN mkdir /home/laravel_user

RUN useradd -s/bin/bash -d/home/laravel_user laravel_user

WORKDIR /var/www/html

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('co$
RUN php composer-setup.php

RUN php -r "unlink('composer-setup.php');"

RUN php composer.phar create-project laravel/laravel docker-laravel

WORKDIR /var/www/html/docker-laravel

RUN docker-php-ext-install pdo_mysql

#RUN php artisan config:clear

#RUN php artisan route:clear

#RUN php artisan view:clear

RUN sed -i 's/DB_HOST=127.0.0.1/DB_HOST=mysqlbdd/g' .env

RUN sed -i 's/DB_PASSWORD=/DB_PASSWORD=root/g' .env

#RUN php artisan migrate