#!/bin/sh
set -e

docker-compose exec kafka kafka-topics --bootstrap-server kafka:29093 --command-config /etc/kafka/admin.properties \
 --create --topic test

docker-compose exec kafka kafka-acls --bootstrap-server kafka:29093 --command-config /etc/kafka/admin.properties \
 --add --allow-principal "User:client" \
 --producer --topic test

 docker-compose exec kafka kafka-acls --bootstrap-server kafka:29093 --command-config /etc/kafka/admin.properties \
  --add --allow-principal "User:client" \
  --consumer --group "*" --topic test
