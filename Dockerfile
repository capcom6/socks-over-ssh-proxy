FROM alpine:3.22.4

LABEL org.opencontainers.image.title="SOCKS-over-SSH Proxy"
LABEL org.opencontainers.image.description="Minimal Docker-based SOCKS5 proxy tunnel over SSH using autossh"
LABEL org.opencontainers.image.url="https://github.com/capcom6/socks-over-ssh-proxy"
LABEL org.opencontainers.image.licenses="Apache-2.0"

RUN apk add --no-cache autossh=1.4g-r3
COPY --chmod=0755 entrypoint.sh /entrypoint.sh
RUN addgroup -g 1000 proxy \
  && adduser -u 1000 -G proxy -D -H proxy
USER proxy
EXPOSE 1080
ENTRYPOINT ["/entrypoint.sh"]
