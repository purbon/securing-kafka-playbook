#!/usr/bin/env bash

echo "Creating Datagen source connector"
curl -X PUT \
     --key connect/secrets/connect.key.pem \
     --cacert connect/secrets/ca-chain.cert.pem \
     --cert connect/secrets/connect.cert.pem:confluent \
     -H "Content-Type: application/json" \
     --data '{
               "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
               "kafka.topic": "pageviews",
               "quickstart": "pageviews",
               "key.converter": "org.apache.kafka.connect.storage.StringConverter",
               "value.converter": "org.apache.kafka.connect.json.JsonConverter",
               "value.converter.schemas.enable": "false",
               "max.interval": 500,
               "iterations": 50000000,
               "tasks.max": "5"
          }' \
     https://localhost:18083/connectors/datagen-pageviews/config | jq .

sleep 5
