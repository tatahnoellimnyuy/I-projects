FROM php:8-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN a2enmod rewrite

COPY apache-config/website2.conf /etc/apache2/sites-available/website2.conf
RUN a2ensite website2.conf

RUN mkdir -p /var/www/www.website2.local

WORKDIR /tmp/wordpress


RUN curl -O https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz --strip-components=1
RUN rm latest.tar.gz
RUN mv wp-config-sample.php wp-config.php
RUN sed -i 's/database_name_here/wordpress_db/' wp-config.php
RUN sed -i 's/username_here/wordpress_user/' wp-config.php
RUN sed -i 's/password_here/wordpress_password/' wp-config.php
RUN sed -i 's/localhost/db/' wp-config.php
RUN sed -i "s/wp_/wp1_/g" wp-config.php
RUN sed -i "s/\$table_prefix = 'wp_';/\$table_prefix = 'wp2_';/g" wp-config.php
WORKDIR /var/www/www.website2.local
RUN chown -R www-data:www-data /var/www/www.website2.local

EXPOSE 80
CMD ["sh", "-c", "if [ ! -f /var/www/www.website2.local/installation-complete.txt ]; then \
                   cp -ru /tmp/wordpress/* /var/www/www.website2.local/ && \
                   touch /var/www/www.website2.local/installation-complete.txt && \
                   rm -r /tmp/wordpress; \
                 fi; \
                 apache2-foreground"]