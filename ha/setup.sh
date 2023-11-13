#!/bin/sh
set -e

docker-compose exec kafka1 kafka-topics --bootstrap-server kafka1:29092 --command-config /etc/kafka/admin.properties \
 --create --topic test

docker-compose exec kafka1 kafka-acls --bootstrap-server kafka1:29092 --command-config /etc/kafka/admin.properties \
 --add --allow-principal "User:client" \
 --producer --topic test

 docker-compose exec kafk1 kafka-acls --bootstrap-server kafka1:29092 --command-config /etc/kafka/admin.properties \
  --add --allow-principal "User:client" \
  --consumer --group "*" --topic test
