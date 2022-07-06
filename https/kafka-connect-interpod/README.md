# Kafka Connect security scenarios

This playbook shows possible error scenarios that could happen when deploying a Kafka Connect cluster using a TLS connection.

## Requirements

To be able to execute this playbook you require:

* Docker (19.03 or later)
* Docker compose (1.24.1 or later)
* curl

## Bootstrap the playbook

The playbook bootstrap can be done by executing the ```./up``` script.

### Prepared TLS certificates and keystores

A set of prepared TLS certificates and keystores are available within the _connect/secrets_ directory.
Most relevant ones are:

* _certificate.p12_: TLS certificate to verify the failure of mTLS (this is a self sign certificate)
* _rest-client.p12_: TLS certificate to verify the positive verification using mTLS (this cert is sign by the same CA as the server identity)
* _server.keystore_ and _server.truststore_: keystores prepared for the Kafka Connect REST server identity.

All this certs has been created with the scripts in this repo.

## Scenarios

### Create a connector in a follower with broken SAN names in the TLS certificates

```bash

$ ./scripts/list-connect-asign.sh                                                                                       2.7.0
Joined group list for kafka-connect node 0

[2022-07-06 13:03:35,040] INFO [Worker clientId=connect0, groupId=kafka-connect-cp] Joined group at generation 1 with protocol version 2 and got assignment: Assignment{error=0, leader='connect0-db458045-a1fe-42d6-9f40-2521e3a77963', leaderUrl='https://kafka-connect:18083/', offset=-1, connectorIds=[], taskIds=[], revokedConnectorIds=[], revokedTaskIds=[], delay=0} with rebalance delay: 0 (org.apache.kafka.connect.runtime.distributed.DistributedHerder)


Joined group list for kafka-connect node 1

[2022-07-06 13:03:35,035] INFO [Worker clientId=connect1, groupId=kafka-connect-cp] Joined group at generation 1 with protocol version 2 and got assignment: Assignment{error=0, leader='connect0-db458045-a1fe-42d6-9f40-2521e3a77963', leaderUrl='https://kafka-connect:18083/', offset=-1, connectorIds=[], taskIds=[], revokedConnectorIds=[], revokedTaskIds=[], delay=0} with rebalance delay: 0 (org.apache.kafka.connect.runtime.distributed.DistributedHerder)



~/work/ps/workshops/securing-kafka-playbook/https/kafka-connect-interpod on  master! ⌚ 15:05:26
$ ./scripts/create-datagen-node1.sh                                                                                     2.7.0
Creating Datagen source connector
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   687  100   170  100   517    113    345  0:00:01  0:00:01 --:--:--   459
{
  "error_code": 500,
  "message": "IO Error trying to forward REST request: javax.net.ssl.SSLHandshakeException: No subject alternative DNS name matching kafka-connect found."
}
```

In this scenario, the leader is connect0 (node0) and we try to create the connector in the node1, the reader can see in the docker-compose file and in the keystore the container DNS name from node0 is not included in the SAN list.

In this case the communication would break between the follower and the leader in the moment the follower pass the request to their leader
in order to do the change in the cluster config definitions.

The reader can see that creating this now in node0 will succeed as this node is the leader.

```bash

~/work/ps/workshops/securing-kafka-playbook/https/kafka-connect-interpod on  master! ⌚ 15:05:43
$ ./scripts/create-datagen-node0.sh                                                                                     2.7.0
Creating Datagen source connector
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   966  100   449  100   517    579    667 --:--:-- --:--:-- --:--:--  1244
{
  "name": "datagen-pageviews",
  "config": {
    "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
    "kafka.topic": "pageviews",
    "quickstart": "pageviews",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": "false",
    "max.interval": "500",
    "iterations": "50000000",
    "tasks.max": "5",
    "name": "datagen-pageviews"
  },
  "tasks": [],
  "type": "source"
}

~/work/ps/workshops/securing-kafka-playbook/https/kafka-connect-interpod on  master! ⌚ 15:11:19
$
```
