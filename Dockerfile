FROM nanoninja/php-fpm:7.3.6

ENV BOOKSTACK=BookStack \
   BOOKSTACK_VERSION=0.26.2 \
   BOOKSTACK_HOME="/var/www/html"

ADD bookstack $BOOKSTACK_HOME
COPY docker-entrypoint.sh /

RUN apt-get update && apt-get install -y curl wget vim git libtidy-dev \
   && docker-php-ext-install tidy \
   && cd /var/www && curl -sS https://getcomposer.org/installer | php \
   && mv /var/www/composer.phar /usr/local/bin/composer \
   && cd $BOOKSTACK_HOME && composer install && chown -R www-data:www-data $BOOKSTACK_HOME \
   && apt-get -y autoremove && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /var/tmp/*

WORKDIR $BOOKSTACK_HOME
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 9000

VOLUME ["$BOOKSTACK_HOME/public","$BOOKSTACK_HOME/storage/uploads"]

CMD ["php-fpm"]
