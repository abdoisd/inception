FROM alpine:3.20

RUN apk add php83 php-tokenizer php-phar mariadb-client php83-fpm php83-mysqli php83-json php83-curl php83-mbstring php83-xml php83-gd wget php83-zip curl \
    && mkdir -p /var/www/html \
    && curl -o wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz \
    && tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm wordpress.tar.gz

COPY conf/php-fpm.conf /etc/php83/php-fpm.d/www.conf

COPY tools/wp.sh /usr/local/bin/wp.sh
RUN chmod +x /usr/local/bin/wp.sh

CMD ["sh", "-c", "/usr/local/bin/wp.sh"]
