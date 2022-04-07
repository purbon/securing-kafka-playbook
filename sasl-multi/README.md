#TODO:

1.- From no digest to digest in zookeeper
  2.- how to do the update and process
  2.1.- downtime or not downtime
2.- connect


# SASL authentication with multiple nodes

## Scenarios

### Upgrade from no-digest to digest authentication

ref: https://docs.confluent.io/platform/current/security/zk-security.html#sasl-authentication

*Initial state*

```bash
[2022-04-07 15:09:24,312] INFO [ZooKeeperClient ACL authorizer] Initializing a new session to zookeeper00:2181,zookeeper01:2182,zookeeper02:2183. (kafka.zookeeper.ZooKeeperClient)
[2022-04-07 15:09:24,312] INFO Initiating client connection, connectString=zookeeper00:2181,zookeeper01:2182,zookeeper02:2183 sessionTimeout=18000 watcher=kafka.zookeeper.ZooKeeperClient$ZooKeeperClientWatcher$@7cd4a4d7 (org.apache.zookeeper.ZooKeeper)
[2022-04-07 15:09:24,313] INFO jute.maxbuffer value is 4194304 Bytes (org.apache.zookeeper.ClientCnxnSocket)
[2022-04-07 15:09:24,314] INFO zookeeper.request.timeout value is 0. feature enabled=false (org.apache.zookeeper.ClientCnxn)
[2022-04-07 15:09:24,314] INFO [ZooKeeperClient ACL authorizer] Waiting until connected. (kafka.zookeeper.ZooKeeperClient)
[2022-04-07 15:09:24,317] INFO Opening socket connection to server zookeeper02/172.31.0.3:2183. (org.apache.zookeeper.ClientCnxn)
[2022-04-07 15:09:24,318] INFO SASL config status: Will not attempt to authenticate using SASL (unknown error) (org.apache.zookeeper.ClientCnxn)
[2022-04-07 15:09:24,318] INFO Socket connection established, initiating session, client: /172.31.0.5:35826, server: zookeeper02/172.31.0.3:2183 (org.apache.zookeeper.ClientCnxn)
[2022-04-07 15:09:24,345] INFO Session establishment complete on server zookeeper02/172.31.0.3:2183, session id = 0x30001a16e120000, negotiated timeout = 18000 (org.apache.zookeeper.ClientCnxn)
[2022-04-07 15:09:24,346] INFO [ZooKeeperClient ACL authorizer] Connected. (kafka.zookeeper.ZooKeeperClient)
```

*Add SASL-Digest and restart ZK one by one*

Add:
  authProvider.sasl=org.apache.zookeeper.server.auth.SASLAuthenticationProvider


zookeeper00

```bash
[2022-04-07 15:16:06,101] INFO The large request threshold is set to -1 (org.apache.zookeeper.server.ZooKeeperServer)
[2022-04-07 15:16:06,101] INFO Created server with tickTime 2000 minSessionTimeout 4000 maxSessionTimeout 40000 clientPortListenBacklog -1 datadir /var/lib/zookeeper/log/version-2 snapdir /var/lib/zookeeper/data/version-2 (org.apache.zookeeper.server.ZooKeeperServer)
[2022-04-07 15:16:06,102] INFO FOLLOWING - LEADER ELECTION TOOK - 62 MS (org.apache.zookeeper.server.quorum.Learner)
[2022-04-07 15:16:06,108] INFO Peer state changed: following - discovery (org.apache.zookeeper.server.quorum.QuorumPeer)
[2022-04-07 15:16:06,111] INFO Successfully connected to leader, using address: zookeeper02/172.31.0.3:2888 (org.apache.zookeeper.server.quorum.Learner)
```

zookeeper01

```bash
[2022-04-07 15:15:59,868] WARN Interrupted while waiting for message on queue (org.apache.zookeeper.server.quorum.QuorumCnxManager)
java.lang.InterruptedException
	at java.base/java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.reportInterruptAfterWait(AbstractQueuedSynchronizer.java:2056)
	at java.base/java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.awaitNanos(AbstractQueuedSynchronizer.java:2133)
	at org.apache.zookeeper.util.CircularBlockingQueue.poll(CircularBlockingQueue.java:105)
	at org.apache.zookeeper.server.quorum.QuorumCnxManager.pollSendQueue(QuorumCnxManager.java:1447)
	at org.apache.zookeeper.server.quorum.QuorumCnxManager.access$900(QuorumCnxManager.java:98)
	at org.apache.zookeeper.server.quorum.QuorumCnxManager$SendWorker.run(QuorumCnxManager.java:1271)
[2022-04-07 15:15:59,869] WARN Send worker leaving thread id 1 my id = 2 (org.apache.zookeeper.server.quorum.QuorumCnxManager)
[2022-04-07 15:16:00,716] INFO Revalidating client: 0x10001a16df10000 (org.apache.zookeeper.server.quorum.Learner)
[2022-04-07 15:16:06,058] INFO Received connection request from /172.31.0.4:41490 (org.apache.zookeeper.server.quorum.QuorumCnxManager)
[2022-04-07 15:16:06,072] INFO Notification: my state:FOLLOWING; n.sid:1, n.state:LOOKING, n.leader:1, n.round:0x1, n.peerEpoch:0x1, n.zxid:0x100000036, message format version:0x2, n.config version:0x0 (org.apache.zookeeper.server.quorum.FastLeaderElection)
```

zookeeper02

```bash
rum.QuorumCnxManager)
[2022-04-07 15:15:59,868] WARN Interrupted while waiting for message on queue (org.apache.zookeeper.server.quorum.QuorumCnxManager)
java.lang.InterruptedException
	at java.base/java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.reportInterruptAfterWait(AbstractQueuedSynchronizer.java:2056)
	at java.base/java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.awaitNanos(AbstractQueuedSynchronizer.java:2133)
	at org.apache.zookeeper.util.CircularBlockingQueue.poll(CircularBlockingQueue.java:105)
	at org.apache.zookeeper.server.quorum.QuorumCnxManager.pollSendQueue(QuorumCnxManager.java:1447)
	at org.apache.zookeeper.server.quorum.QuorumCnxManager.access$900(QuorumCnxManager.java:98)
	at org.apache.zookeeper.server.quorum.QuorumCnxManager$SendWorker.run(QuorumCnxManager.java:1271)
[2022-04-07 15:15:59,869] WARN Send worker leaving thread id 1 my id = 3 (org.apache.zookeeper.server.quorum.QuorumCnxManager)
[2022-04-07 15:16:06,058] INFO Received connection request from /172.31.0.4:47042 (org.apache.zookeeper.server.quorum.QuorumCnxManager)
[2022-04-07 15:16:06,080] INFO Notification: my state:LEADING; n.sid:1, n.state:LOOKING, n.leader:1, n.round:0x1, n.peerEpoch:0x1, n.zxid:0x100000036, message format version:0x2, n.config version:0x0 (org.apache.zookeeper.server.quorum.FastLeaderElection)
[2022-04-07 15
```


ZookeeperClient ref: https://github.com/apache/zookeeper/blob/54cb5c39a445c63967ec7c3a46724fe87908440b/zookeeper-server/src/main/java/org/apache/zookeeper/client/ZooKeeperSaslClient.java#L115


* Introduce JAAS with client section on each broker *
* Restart each broker one by one, leader last *


- Perform a rolling restart of brokers, this time setting the configuration parameter zookeeper.set.acl to true, which enables the use of secure ACLs when creating znodes.

- Execute the ZkSecurityMigrator tool using the script: bin/zookeeper-security-migration with zookeeper.acl set to secure. This tool traverses the corresponding sub-trees, changing the ACLs of the znodes.


```bash
$> zookeeper-security-migration --zookeeper.connect zookeeper00:2181 --zookeeper.acl secure
```


```bash
appuser@zookeeper00 ~]$ zookeeper-shell  localhost:2181
Connecting to localhost:2181
Welcome to ZooKeeper!
JLine support is disabled
[2022-04-07 16:14:44,242] WARN SASL configuration failed. Will continue connection to Zookeeper server without SASL authentication, if Zookeeper server allows it. (org.apache.zookeeper.ClientCnxn)
javax.security.auth.login.LoginException: No JAAS configuration section named 'Client' was found in specified JAAS configuration file: '/etc/kafka/zookeeper.sasl.jaas.config'.
	at org.apache.zookeeper.client.ZooKeeperSaslClient.<init>(ZooKeeperSaslClient.java:189)
	at org.apache.zookeeper.ClientCnxn$SendThread.startConnect(ClientCnxn.java:1161)
	at org.apache.zookeeper.ClientCnxn$SendThread.run(ClientCnxn.java:1210)

WATCHER::

WatchedEvent state:AuthFailed type:None path:null

WATCHER::

WatchedEvent state:SyncConnected type:None path:null
ls /brokers/ids
[1, 2]
getAcl /brokers/ids
'sasl,'kafka
: cdrwa
'world,'anyone
: r
```
