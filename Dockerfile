FROM docker.io/library/alpine:latest

ARG SYNCTHING_VERSION=1.15.1

ENV SYNCTHING_HTTP_PORT 8384
ENV LANG en_US.UTF-8
ENV SYNCTHING_VERSION=${SYNCTHING_VERSION}

RUN apk --no-progress update && \
    apk --no-progress upgrade && \
    apk --no-progress add curl tar dumb-init && \
    curl --silent \
        --location \
        --output /tmp/syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz \
        https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz && \
    adduser -S -h /syncthing syncthing

EXPOSE $SYNCTHING_HTTP_PORT

COPY start.sh /start.sh

USER syncthing

ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["/start.sh"]
