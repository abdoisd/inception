FROM alpine:3.20

RUN     apk update && apk add \
                wget php82 php82-pdo_mysql php82-session

WORKDIR /var/www

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    mv adminer-4.8.1.php index.php

CMD     [ "php82", "-S", "[::]:8080", "-t", "/var/www" ]
