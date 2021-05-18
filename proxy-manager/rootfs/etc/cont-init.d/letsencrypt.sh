#!/usr/bin/with-contenv bashio

# Generate config
bashio::var.json \
    acme_server "$(bashio::config 'acme_server')" \
    | tempio \
        -template /usr/share/tempio/letsencrypt.ini \
        -out /etc/letsencrypt.ini

if bashio::config.has_value 'acme_root_cert'; then
  printf "$(bashio::config 'acme_root_cert')" > /usr/local/share/ca-certificates/acme-root-cert.crt
  update-ca-certificates
fi
