#!/bin/sh

set -eu

: "${SSH_HOST:?SSH_HOST is required}"
: "${SSH_USER:?SSH_USER is required}"

SSH_PORT="${SSH_PORT:-22}"
SOCKS_BIND_ADDRESS="${SOCKS_BIND_ADDRESS:-127.0.0.1}"

case "$SSH_HOST" in
  \[*\])
    SSH_HOST="${SSH_HOST#\[}"
    SSH_HOST="${SSH_HOST%\]}"
    ;;
esac

case "$SSH_HOST" in
  *[!A-Za-z0-9._:-]* | -*)
    echo "SSH_HOST contains invalid characters" >&2
    exit 1
    ;;
esac

case "$SSH_USER" in
  *[!A-Za-z0-9._-]* | -*)
    echo "SSH_USER contains invalid characters" >&2
    exit 1
    ;;
esac

case "$SSH_PORT" in
  '' | *[!0-9]* | ??????*)
    echo "SSH_PORT must be a number between 1 and 65535" >&2
    exit 1
    ;;
esac

if [ "$SSH_PORT" -lt 1 ] || [ "$SSH_PORT" -gt 65535 ]; then
  echo "SSH_PORT must be between 1 and 65535" >&2
  exit 1
fi

case "$SOCKS_BIND_ADDRESS" in
  *[[:space:]]* | *[!]0-9A-Za-z.:[]*)
    echo "SOCKS_BIND_ADDRESS contains invalid characters" >&2
    exit 1
    ;;
esac

exec autossh -M 0 \
  -o "StrictHostKeyChecking=accept-new" \
  -o "UserKnownHostsFile=/tmp/known_hosts" \
  -o "ServerAliveInterval=30" \
  -o "ServerAliveCountMax=3" \
  -o "ExitOnForwardFailure=yes" \
  -o "ConnectTimeout=10" \
  -o "BatchMode=yes" \
  -o "IdentitiesOnly=yes" \
  -o "PasswordAuthentication=no" \
  -N -D "${SOCKS_BIND_ADDRESS}:1080" \
  -p "$SSH_PORT" \
  -i /run/secrets/socks_ssh_key \
  "${SSH_USER}@${SSH_HOST}"
