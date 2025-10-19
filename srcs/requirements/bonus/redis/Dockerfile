FROM alpine:3.20

RUN apk update && \
        apk upgrade && \
        apk add redis

CMD ["redis-server","--protected-mode","no"]
