FROM confluentinc/cp-server-connect:7.1.0

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

USER root

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:0.5.0 \
    && confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.2.1 \
    && confluent-hub install --no-prompt debezium/debezium-connector-sqlserver:1.6.0


RUN yum install -y \
      libmnl \
      findutils \
      which

RUN wget http://vault.centos.org/8.1.1911/BaseOS/x86_64/os/Packages/iproute-tc-4.18.0-15.el8.x86_64.rpm
RUN rpm -i --nodeps --nosignature http://vault.centos.org/8.1.1911/BaseOS/x86_64/os/Packages/iproute-tc-4.18.0-15.el8.x86_64.rpm
RUN wget http://vault.centos.org/8.1.1911/BaseOS/x86_64/os/Packages/iptables-libs-1.8.2-16.el8.x86_64.rpm
RUN rpm -i --nodeps --nosignature http://vault.centos.org/8.1.1911/BaseOS/x86_64/os/Packages/iptables-libs-1.8.2-16.el8.x86_64.rpm

USER root
