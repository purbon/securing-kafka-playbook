#!/bin/sh
set -e

docker-compose exec kafka kafka-console-producer --bootstrap-server kafka:29093 --producer.config /etc/kafka/client.properties  --topic test
docker-compose exec kafka kafka-console-consumer --bootstrap-server kafka:29093 --consumer.config /etc/kafka/client.properties --topic test