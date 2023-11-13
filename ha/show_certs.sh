#!/usr/bin/env bash

docker-compose exec kafka openssl s_client -connect kafka:29093 2>&1 < /dev/null | sed -n '/-----BEGIN/,/-----END/p' | openssl x509 -noout -text
