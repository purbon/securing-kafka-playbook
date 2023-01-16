#!/usr/bin/env bash


docker exec kafka4 kafka-console-consumer --bootstrap-server kafka4:29095  --topic bar --from-beginning
