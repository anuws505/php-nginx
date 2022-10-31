# initialize image
FROM debian:bullseye

# install nginx
RUN apt-get update && \
    apt-get install -y nginx

# install php-fpm
RUN apt-get install -y php7.4 php7.4-common php-pear php7.4-mbstring php7.4-fpm
RUN apt-get install -y php7.4-gd php7.4-intl php7.4-soap php7.4-curl php7.4-mysql

LABEL maintainer="anuws505"
LABEL version="1.0"
LABEL description="A PHP and Nginx on Debain 11"

RUN mkdir /opt/certs
COPY certs/. /opt/certs/.
COPY etc_nginx_sites-available_default /etc/nginx/sites-available/default
COPY www/. /var/www/html/.
RUN chown -R www-data:www-data /var/www/html
# -- or when default root dir --
# RUN chmod 777 /var/www/html/var
# RUN chmod 777 /var/www/html/app/etc
# RUN chmod 777 /var/www/html/media
# RUN chmod 777 /var/www/html/media/customer
# RUN chmod 777 /var/www/html/media/dhl
# RUN chmod 777 /var/www/html/media/dhl/logo.jpg
# RUN chmod 777 /var/www/html/media/downloadable

EXPOSE 80/tcp
EXPOSE 443/tcp

# CMD ["/bin/bash", "-c", "nginx -g 'daemon off;'"]
CMD ["/bin/bash", "-c", "service php7.4-fpm start && nginx -g 'daemon off;' && nginx -s reload"]