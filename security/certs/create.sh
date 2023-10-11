#!/usr/bin/env bash

# Cleanup files

rm -rf things
mkdir -p things
#cd things && rm -f *.crt *.csr *_creds *.jks *.srl *.key *.pem *.der *.p12 *.log
#cd ..

# Generate CA key
openssl req -new -x509 -keyout snakeoil-ca-1.key -out snakeoil-ca-1.crt -days 1825 -subj '/CN=ca1.test.confluentdemo.io/OU=TEST/O=CONFLUENT/L=PaloAlto/ST=Ca/C=US' -passin pass:confluent -passout pass:confluent

users=(ldap kafka client schemaregistry connect connector controlcenter mds thusnelda zookeeper)
cd things

echo "Creating certificates"
printf '%s\0' "${users[@]}" | xargs -0 -I{} -n1 -P15 sh -c '../create-cert.sh "$1" > "certs-create-$1.log" 2>&1 && echo "Created certificates for $1"' -- {}
echo "Creating certificates completed"
cd ..