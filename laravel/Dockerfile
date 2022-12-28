FROM php:8-apache

#----------------CONFIG CONTAINER----------------
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apt update && apt install mariadb-client unzip git nano ssh openssh-server python3-pip python -y
RUN mkdir /home/laravel_user
RUN useradd -s/bin/bash -d/home/laravel_user laravel_user
WORKDIR /var/www/html
COPY ./sshd_config /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

#----------------LANCEMENT SERVICE SSH----------------
COPY ssh_init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ssh_init.sh

#----------------INSTALL COMPOSER----------------
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

#----------------CREATE PROJECT----------------
#RUN php composer.phar create-project laravel/laravel docker-laravel
COPY ./docker-laravel docker-laravel
WORKDIR /var/www/html/docker-laravel
RUN chmod 777 -R storage

#----------------CONFIG PROJECT----------------
RUN docker-php-ext-install pdo_mysql
RUN php artisan config:clear
RUN php artisan route:clear
RUN php artisan view:clear

#----------------CONNECT DATABASE----------------
RUN sed -i 's/DB_HOST=127.0.0.1/DB_HOST=db/g' .env
RUN sed -i 's/DB_PASSWORD=/DB_PASSWORD=root/g' .env
CMD ["/usr/local/bin/ssh_init.sh"]; tail -F anything
