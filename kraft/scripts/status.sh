#!/usr/bin/env bash

 docker exec kafka4 kafka-metadata-quorum --bootstrap-server kafka4:29095 describe --status 
