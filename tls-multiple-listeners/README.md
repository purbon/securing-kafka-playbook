KAFKA_SUPER_USERS:
User:CN=kafka,O=Confluent Ltd,L=Berlin,ST=Berlin,C=DE;User:CN=client,O=Confluent Ltd,L=Berlin,ST=Berlin,C=DE

# kafka-authorizer.log

[2020-02-29 06:41:26,510] DEBUG No acl found for resource Topic:LITERAL:test, authorized = false (kafka.authorizer.logger)
[2020-02-29 06:41:26,510] INFO Principal = User:1.2.840.113549.1.9.1=#16126b61666b6140636f6e666c75656e742e696f,CN=kafka,OU=PS,O=Confluent Ltd,L=Berlin,ST=Berlin,C=DE is Denied Operation = Describe from host = 127.0.0.1 on resource = Topic:LITERAL:test (kafka.authorizer.logger)

# openssl connection verification

```bash
$> openssl s_client -connect localhost:9092

subject=/C=DE/ST=Berlin/L=Berlin/O=Confluent Ltd/OU=PS/CN=kafka/emailAddress=kafka@confluent.io
issuer=/C=DE/ST=Berlin/O=Confluent Ltd/OU=PS/CN=intermediate c/emailAddress=ca@confluent.io
---
Acceptable client certificate CA names
/C=DE/ST=Berlin/O=Confluent Ltd/OU=PS/CN=intermediate c/emailAddress=ca@confluent.io
/C=DE/ST=Berlin/L=Berlin/O=Confluent Ltd/OU=PS/CN=ca/emailAddress=ca@confluent.io
Server Temp Key: ECDH, P-256, 256 bits
---
SSL handshake has read 4598 bytes and written 169 bytes
---
New, TLSv1/SSLv3, Cipher is ECDHE-RSA-AES256-GCM-SHA384
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES256-GCM-SHA384
    Session-ID: 5E5A8E604031E18ADFD9E21D7C127171BFFAA0C824D26A6FA9BBA2E21379E728
    Session-ID-ctx:
    Master-Key: CB63D75F292C1E722A4A0C4056B2BBC3E2637DDB060B6443BFCB64234062AFC9043C4A5C8B5BBF786E44D833222D6163
    Start Time: 1582992992
    Timeout   : 7200 (sec)
    Verify return code: 21 (unable to verify the first certificate)
---
```

```bash
openssl s_client -connect localhost:9092 -tls1

CONNECTED(00000005)
4537853548:error:1400410B:SSL routines:CONNECT_CR_SRVR_HELLO:wrong version number:/BuildRoot/Library/Caches/com.apple.xbs/Sources/libressl/libressl-22.260.1/libressl-2.6/ssl/ssl_pkt.c:386:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 5 bytes and written 0 bytes
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1
    Cipher    : 0000
    Session-ID:
    Session-ID-ctx:
    Master-Key:
    Start Time: 1582993203
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
---
```

```bash
openssl s_client -connect localhost:9092 -dtls1

CONNECTED(00000005)
write:errno=61
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 0 bytes and written 0 bytes
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
   Protocol  : DTLSv1
   Cipher    : 0000
   Session-ID:
   Session-ID-ctx:
   Master-Key:
   Start Time: 1582993252
   Timeout   : 7200 (sec)
   Verify return code: 0 (ok)
---
```

```bash
openssl s_client -connect localhost:9092 -cipher RC4-SHA

CONNECTED(00000005)
4491798124:error:1400410B:SSL routines:CONNECT_CR_SRVR_HELLO:wrong version number:/BuildRoot/Library/Caches/com.apple.xbs/Sources/libressl/libressl-22.260.1/libressl-2.6/ssl/ssl_pkt.c:386:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 5 bytes and written 0 bytes
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : 0000
    Session-ID:
    Session-ID-ctx:
    Master-Key:
    Start Time: 1582993292
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
---
```

```
openssl s_client -connect localhost:9092 -cipher NULL-MD5

CONNECTED(00000005)
4730148460:error:1400410B:SSL routines:CONNECT_CR_SRVR_HELLO:wrong version number:/BuildRoot/Library/Caches/com.apple.xbs/Sources/libressl/libressl-22.260.1/libressl-2.6/ssl/ssl_pkt.c:386:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 5 bytes and written 0 bytes
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : 0000
    Session-ID:
    Session-ID-ctx:
    Master-Key:
    Start Time: 1582993348
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
---
```

```
openssl s_client -connect localhost:9092 -cipher AES256-SHA256
-----END CERTIFICATE-----
subject=/C=DE/ST=Berlin/L=Berlin/O=Confluent Ltd/OU=PS/CN=kafka/emailAddress=kafka@confluent.io
issuer=/C=DE/ST=Berlin/O=Confluent Ltd/OU=PS/CN=intermediate c/emailAddress=ca@confluent.io
---
Acceptable client certificate CA names
/C=DE/ST=Berlin/O=Confluent Ltd/OU=PS/CN=intermediate c/emailAddress=ca@confluent.io
/C=DE/ST=Berlin/L=Berlin/O=Confluent Ltd/OU=PS/CN=ca/emailAddress=ca@confluent.io
---
SSL handshake has read 3932 bytes and written 439 bytes
---
New, TLSv1/SSLv3, Cipher is AES256-SHA256
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : AES256-SHA256
    Session-ID: 5E5A8FE71012DCDA6188BA5D82CE575C13C5902342CEB153B2E6507584C1AE38
    Session-ID-ctx:
    Master-Key: FC56A6A9361C8DB865BB2DA6A4EDD55F5570E077FBA7D6A9FB02F3AA23ADF5A8839F9978F7D450A012E925B67AC0B0BC
    Start Time: 1582993383
    Timeout   : 7200 (sec)
    Verify return code: 21 (unable to verify the first certificate)
---
```
