FROM alpine:3.22.4
RUN apk add --no-cache autossh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN adduser -D -H proxy
USER proxy
ENTRYPOINT ["/entrypoint.sh"]
