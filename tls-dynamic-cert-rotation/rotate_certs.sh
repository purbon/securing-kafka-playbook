#!/usr/bin/env bash

docker-compose exec kafka kafka-configs --command-config /etc/kafka/admin.properties \
              --bootstrap-server kafka:29093 \
              --entity-type brokers --entity-name 1 \
              --alter \
              --add-config listener.name.ssl.ssl.keystore.location=/etc/kafka/secrets/kafka3650.keystore


openssl s_client -connect kafka:29093 2>&1 < /dev/null | sed -n '/-----BEGIN/,/-----END/p' | openssl x509 -noout -text
openssl s_client -connect localhost:9092 2>&1 < /dev/null | sed -n '/-----BEGIN/,/-----END/p' | openssl x509 -noout -text