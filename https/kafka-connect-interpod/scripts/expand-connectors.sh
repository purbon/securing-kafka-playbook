#!/usr/bin/env bash

curl --key connect/secrets/connect.key.pem \
     --cacert connect/secrets/ca-chain.cert.pem \
     --cert connect/secrets/connect.cert.pem:confluent "https://localhost:18084/connectors?expand=status&expand=info" | jq .
