#!/usr/bin/env bash


docker exec kafka4 kafka-topics --bootstrap-server kafka4:29095  --create --topic bar --partitions 3 --replication-factor 2
docker exec kafka4 kafka-topics --bootstrap-server kafka4:29095 --describe


docker exec kafka4 kafka-topics --bootstrap-server kafka4:29095  --create --topic foo --partitions 3 --replication-factor 2
docker exec kafka4 kafka-topics --bootstrap-server kafka4:29095 --describe
