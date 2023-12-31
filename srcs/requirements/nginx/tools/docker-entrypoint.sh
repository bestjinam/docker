#!/bin/bash
set -e

# Symbolic linking logs
ln -sf /dev/stdout /var/log/nginx/access.log && \
ln -sf /dev/stderr /var/log/nginx/error.log

# Generate openssl certificate
#mkdir -p $CERT_
#openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#        -keyout /etc/nginx/ssl/$DOMAIN_NAME.key \
#        -out /etc/nginx/ssl/$DOMAIN_NAME.crt \
#        -subj "/C=KR/L=Seoul/O=42Seoul/CN=$DOMAIN_NAME" \
#        > /dev/null 2>&1

# Execute nginx
exec nginx -g "daemon off;"
