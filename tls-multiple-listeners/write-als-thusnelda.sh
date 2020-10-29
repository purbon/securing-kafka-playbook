#!/usr/bin/env bash


docker-compose exec kafka kafka-console-producer --broker-list thusnelda:29094 \
                  --topic test \
                  --producer.config /etc/kafka/thusnelda.properties

docker-compose exec kafka kafka-console-consumer --bootstrap-server thusnelda:29094 \
                  --topic test \
                  --consumer.config /etc/kafka/thusnelda.properties \
                  --from-beginning
