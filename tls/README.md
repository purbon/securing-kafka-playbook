KAFKA_SUPER_USERS:
User:CN=kafka,O=Confluent Ltd,L=Berlin,ST=Berlin,C=DE;User:CN=client,O=Confluent Ltd,L=Berlin,ST=Berlin,C=DE

# kafka-authorizer.log

[2020-02-29 06:41:26,510] DEBUG No acl found for resource Topic:LITERAL:test, authorized = false (kafka.authorizer.logger)
[2020-02-29 06:41:26,510] INFO Principal = User:1.2.840.113549.1.9.1=#16126b61666b6140636f6e666c75656e742e696f,CN=kafka,OU=PS,O=Confluent Ltd,L=Berlin,ST=Berlin,C=DE is Denied Operation = Describe from host = 127.0.0.1 on resource = Topic:LITERAL:test (kafka.authorizer.logger)
