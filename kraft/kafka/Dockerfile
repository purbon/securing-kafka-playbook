FROM confluentinc/cp-enterprise-kafka:7.3.1
MAINTAINER pere.urbon@gmail.com
ENV container docker

USER root

RUN wget https://rpmfind.net/linux/centos/8-stream/BaseOS/x86_64/os/Packages/iproute-tc-5.18.0-1.el8.x86_64.rpm
RUN yum install -y iproute iptables which
RUN rpm -i iproute-tc-5.18.0-1.el8.x86_64.rpm

# 2. Configure Kafka
#COPY server.properties /etc/kafka/server.properties
#EXPOSE 9092
#CMD kafka-server-start.sh /etc/kafka/server.properties

#USER appuser
