#!/usr/bin/env bash

 docker exec kafka1 kafka-metadata-quorum --bootstrap-server kafka4:29095 describe --status 
