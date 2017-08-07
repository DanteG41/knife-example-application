#!/usr/bin/env bash
set -e

if [ -f /var/nginx_env.lock ]; then
    echo "Skipping"
    exit 0
fi

touch /var/nginx_env.lock

ep /etc/nginx/nginx.conf
ep /etc/nginx/includes/*.conf
ep /etc/nginx/sites-enabled/*.conf
