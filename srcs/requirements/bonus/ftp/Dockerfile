FROM alpine:3.20

RUN apk update && apk add vsftpd

COPY tools/init.sh /usr/local/bin
COPY conf/vsftpd.conf /tmp

RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["init.sh"]
