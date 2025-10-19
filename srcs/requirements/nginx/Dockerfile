FROM alpine:3.20

RUN apk add nginx openssl \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
       -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
