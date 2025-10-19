FROM alpine:3.20

RUN apk update && \
    apk add mariadb mariadb-client bash

COPY tools/sh.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/sh.sh

ENTRYPOINT [ "sh.sh" ]
