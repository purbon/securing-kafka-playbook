# LDAP notes


Successful group cache:

```bash
[2022-05-19 10:09:56,014] TRACE Searching groups with base ou=groups,dc=test,dc=com filter (objectClass=groupOfNames):  (io.confluent.security.auth.provider.ldap.LdapGroupManager)

[2022-05-19 10:09:56,016] TRACE Processing full search result cn=Kafka Developers: null:null:{member=member: cn=Philip J. Fry,ou=service_account,dc=test,dc=com, cn=Turanga Leela,ou=service_account,dc=test,dc=com, cn=Bender Bending Rodriguez,ou=service_account,dc=test,dc=com, cn=Hermes Conrad,ou=service_account,dc=test,dc=com, cn=Hubert J. Farnsworth,ou=service_account,dc=test,dc=com, cn=cn: kafkadev, Kafka Developers} (io.confluent.security.auth.provider.ldap.LdapGroupManager)

[2022-05-19 10:09:56,016] DEBUG Search completed, group cache is {Hubert J. Farnsworth=[kafkadev], Hermes Conrad=[kafkadev], Bender Bending Rodriguez=[kafkadev], Turanga Leela=[kafkadev], Philip J. Fry=[kafkadev]} (io.confluent.security.auth.provider.ldap.LdapGroupManager)
```


## Userful LDAP filters


Only log in from a certain group:

```bash
 (&(|(ou:dn:=service_account)(ou:dn:=people))(memberOf=cn=Kafka Developers,ou=groups,dc=test,dc=com))
 ```


 Only log in from two given OU:

 ```bash
  (|(ou:dn:=service_account)(ou:dn:=people))
  ```
