#!/usr/bin/env bash



## Query all users

docker-compose exec ldap ldapsearch -LLL -x -H ldap://ldap:389 -b 'dc=test,dc=com' -D "cn=mds,dc=test,dc=com" -w 'Developer!'

docker-compose exec ldap ldapsearch -LLL -x -H ldap://ldap:389 -b 'ou=service_account,dc=test,dc=com' -D "cn=mds,dc=test,dc=com" -w 'Developer!'

## Query groups

## Other

docker-compose exec ldap  ldapsearch -LLL -x -H ldap://ldap:389 -b 'ou=people,dc=test,dc=com' -D "cn=mds,dc=test,dc=com" -w 'Developer!' - "(objectclass=posixGroup)"

ldapsearch \
-H ldap://ldap:389 \
-x \
-D "cn=mds,dc=test,dc=com" \
-w 'Developer!' \
-b "ou=people,dc=test,dc=com" \
-s sub \
-v \
-LLL \
"(&(objectClass=posixGroup)(cn=ship_crew))" \
dn objectClass cn memberuid


dn: cn=professor,ou=service_account,dc=test,dc=com
changetype: add
objectClass: person
objectClass: simpleSecurityObject
description: A professor service account
userPassword: professor
sn: Service Account


dn: cn=admin_staff,ou=groups,dc=test,dc=com
objectClass: top
objectClass: posixGroup
cn: admin_staff
gidNumber: 5000
memberuid: cn=Hubert J. Farnsworth,ou=service_account,dc=test,dc=com
memberuid: cn=Hermes Conrad,ou=service_account,dc=test,dc=com

ldap.java.naming.factory.initial=com.sun.jndi.ldap.LdapCtxFactory
ldap.com.sun.jndi.ldap.read.timeout=3000
ldap.java.naming.provider.url=ldap:<ldap-server-address>
# how mds authenticates to ldap server
ldap.java.naming.security.principal=<CN=mds,CN=Demo,DC=confluent,DC=io>
ldap.java.naming.security.credentials=<password>
ldap.java.naming.security.authentication=simple
# ldap search mode (GROUPS is default)
#ldap.search.mode=GROUPS
#ldap.search.mode=USERS
# how to search for users
ldap.user.search.base=<CN=Demo,DC=confluent,DC=io>
# how to search for groups
ldap.group.search.base=<CN=Demo,DC=confluent,DC=io>
# which attribute in ldap record corresponds to user name
ldap.user.name.attribute=sAMAccountName
ldap.user.memberof.attribute.pattern=<CN=(.*),CN=Demo,DC=confluent,DC=io>
ldap.group.object.class=group
ldap.group.name.attribute=sAMAccountName
ldap.group.member.attribute.pattern=<CN=(.*),CN=Demo,DC=confluent,DC=io>
