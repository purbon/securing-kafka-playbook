#!/usr/bin/env bash

openssl genrsa -out keypair.pem 2048
openssl rsa -in keypair.pem -outform PEM -pubout -out public.pem

CONFLUENT_PLATFORM_USERNAME=superUser CONFLUENT_PLATFORM_PASSWORD=superUser CONFLUENT_PLATFORM_MDS_URL=http://localhost:8091 confluent login 

confluent iam rbac role-binding create \
    --principal User:superUser  \
    --role SystemAdmin \
    --kafka-cluster t8iua-ATTOuEXZHHL77Wkg


curl -s http://localhost:8091/v1/metadata/id  | jq -r ".id"