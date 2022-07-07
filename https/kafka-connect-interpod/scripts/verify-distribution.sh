#!/usr/bin/env bash

curl -s --key connect/secrets/connect.key.pem \
     --cacert connect/secrets/ca-chain.cert.pem \
     --cert connect/secrets/connect.cert.pem:confluent \
     "https://localhost:18083/connectors/datagen-pageviews/status" | jq .
