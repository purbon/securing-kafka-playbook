# Security Apache Kafka

This is a collection of examples of how to build a top notch Apache Kafka deployment.

## Recommendations

* Use TLS 1.2 for Encryption in transit
* Use Kerberos or mTLS for authentication
* Use HTTPs (with mTLS) for connecting to Schema Registry or Kafka Connect REST apis
* Access Control
  * Use Confluent RBAC to help define granular access roles
  * Use GitOps for automating access control deployment and team self service
* Setup Zookeeper ACLs so only the brokers can access it
* Avoid using any PLAINTEXT configuration
* Harden the TLS setup to avoid using insecure configurations


### For SCRAM

* Use SCRAM only with TLS
* Protect the Zookeeper access
