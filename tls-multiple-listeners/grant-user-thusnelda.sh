#!/bin/sh
set -e

docker-compose exec kafka kafka-acls --bootstrap-server kafka:29093 --command-config /etc/kafka/admin.properties \
 --add --allow-principal "User:thusnelda" \
 --producer --topic test

 docker-compose exec kafka kafka-acls --bootstrap-server kafka:29093 --command-config /etc/kafka/admin.properties \
  --add --allow-principal "User:thusnelda" \
  --consumer --group "*" --topic test
