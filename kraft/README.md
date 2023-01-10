# Kafka KRaft playbook

This repository is an initial playbook with examples of using Apache Kafka without Zookeeper.

## Minimum set of new configurations

This is the minimum set of new configurations required to run in KRaft mode

| Configuration   | Description  | Default value    |
|-----------------|--------------|------------------|
| process.roles   | The roles that this node plays, either broker, controller or both. Empty for zookeeper legacy | ""                  |
| node.id         | The ID associated with the process roles when using KRaft | -1                |
| controller.quorum.voters  | Map of id/endpoint information for the set of voters in a comma-separated list of {id}@{host}:{port} entries | ""                |


## Check the cluster metadata

Kraft introduces a new command to check the metadata  quorum, this is an example of how to use it.

```bash
$ docker exec kafka kafka-metadata-quorum --bootstrap-server kafka:29092 describe --status                               2.7.0
ClusterId:              Yyxa-hpWRt2p5xx14kXX6Q
LeaderId:               1
LeaderEpoch:            1
HighWatermark:          317
MaxFollowerLag:         0
MaxFollowerLagTimeMs:   0
CurrentVoters:          [1]
CurrentObservers:       []
```
