#!/usr/bin/env bash

echo "zookeeper0 status: "
docker-compose exec zookeeper echo mntr | nc localhost 2181 | grep zk_server_state

echo "zookeeper1 status: "
docker-compose exec zookeeper01 echo mntr | nc localhost 2182 | grep zk_server_state

echo "zookeeper2 status: "
docker-compose exec zookeeper02 echo mntr | nc localhost 2183 | grep zk_server_state


echo "zookeeper0 sync followers: "
docker-compose exec zookeeper   echo mntr | nc localhost 2181 | grep zk_synced_followers

echo "zookeeper1 sync followers: "
docker-compose exec zookeeper01 echo mntr | nc localhost 2182 | grep zk_synced_followers

echo "zookeeper2 sync followers: "
docker-compose exec zookeeper02 echo mntr | nc localhost 2183 | grep zk_synced_followers
