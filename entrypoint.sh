#!/bin/sh

set -eu

exec autossh -M 0 \
  -o "StrictHostKeyChecking=accept-new" \
  -o "UserKnownHostsFile=/tmp/known_hosts" \
  -o "ServerAliveInterval=30" \
  -o "ServerAliveCountMax=3" \
  -o "ExitOnForwardFailure=yes" \
  -N -D 0.0.0.0:1080 \
  -p ${SSH_PORT:-22} \
  -i /run/secrets/socks_ssh_key \
  ${SSH_USER}@${SSH_HOST}
