FROM alpine:3.20

RUN apk add php82 php82-pdo_mysql php82-session

COPY website/ /var/www/html/

CMD [ "php82", "-S", "[::]:1234", "-t", "/var/www/html" ]
