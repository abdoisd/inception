FROM alpine:3.20

RUN     apk update && \
                apk upgrade && \
                apk add curl

WORKDIR /app

RUN curl -L https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar xzf portainer.tar.gz \
    && rm portainer.tar.gz

ENTRYPOINT ["./portainer/portainer"]
