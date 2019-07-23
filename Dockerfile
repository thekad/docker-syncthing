FROM docker.io/library/alpine:3.8

ENV SYNCTHING_VERSION 1.2.0
ENV SYNCTHING_HTTP_PORT 8384
ENV LANG en_US.UTF-8

RUN apk --no-progress update && \
    apk --no-progress add curl tar && \
    curl --silent \
        --location \
        --output /tmp/syncthing-v${SYNCTHING_VERSION}.tar.gz \
        https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz && \
    adduser -S -h /syncthing syncthing && \
    tar -C /tmp -xvzf /tmp/syncthing-v${SYNCTHING_VERSION}.tar.gz && \
    mv -v /tmp/syncthing*/syncthing /syncthing/ && \
    chown -R syncthing /syncthing && \
    rm -rfv /tmp/syncthing*

EXPOSE $SYNCTHING_HTTP_PORT

COPY start.sh /start.sh

USER syncthing

ENTRYPOINT ["/start.sh"]
