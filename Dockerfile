FROM alpine:latest
LABEL maintainer "cosmin.cimpoi@gmail.com"

RUN addgroup -S icecast && \
    adduser -S icecast
    
RUN apk add --update \
        icecast \
        mailcap && \
    rm -rf /var/cache/apk/*

COPY ./src/etc/icecast.xml /etc/
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
CMD icecast -c /etc/icecast.xml
