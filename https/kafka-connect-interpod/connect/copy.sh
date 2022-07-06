#!/usr/bin/env bash

cp /Users/pere/work/ps/workshops/securing-kafka-playbook/security/certs/snakeoil-ca-1.crt ca-chain.cert.pem
cp /Users/pere/work/ps/workshops/securing-kafka-playbook/security/certs/connect.certificate.pem connect.cert.pem
cp /Users/pere/work/ps/workshops/securing-kafka-playbook/security/certs/connect.key connect.key.pem
cp /Users/pere/work/ps/workshops/securing-kafka-playbook/security/certs/connect.truststore.jks server.truststore
cp /Users/pere/work/ps/workshops/securing-kafka-playbook/security/certs/connect.keystore.jks server.keystore
