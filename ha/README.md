# Dynamic certificate rotation

This playbook shows a very simplifed update process for TLS certificates in Kafka done using the dynamic configs.

## Setup


To setup this example you should need docker and docker-compose, once this is available in your system please run the following commands:

```bash
$ docker-compose up -d
[+] Running 2/2
 ✔ Container zookeeper  Started                                                                                                                                                                          0.0s 
 ✔ Container kafka      Started                                                                                                                                                                          0.0s 
```

This will start a Kafka (single node) cluster with TLS as external listener, you can see the certificate available if you run the command

```bash 
$ ./show_certs.sh                                                                                                                                                                   ‹system: ruby 2.6.10p210›
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            ed:32:f5:c1:12:1a:1d:2f
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = ca1.test.confluentdemo.io, OU = TEST, O = CONFLUENT, L = PaloAlto, ST = Ca, C = US
        Validity
            Not Before: Oct 11 15:54:11 2023 GMT
            Not After : Oct  9 15:54:11 2028 GMT
        Subject: C = US, ST = Ca, L = PaloAlto, O = CONFLUENT, OU = TEST, CN = kafka
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:d0:68:1a:5d:86:e5:bf:f5:da:a3:fe:b6:e8:10:
                    96:8c:03:c1:91:6d:b4:8b:10:01:bf:a7:24:66:f0:
                    02:d8:d3:92:c0:ec:02:dc:dc:af:09:df:de:19:39:
                    8b:ca:b1:74:ce:7c:88:16:39:93:61:14:d4:46:50:
                    97:fa:df:d3:aa:c7:a7:6a:62:dc:d1:7d:0b:15:92:
                    4f:a9:41:73:92:b8:cc:cd:3f:34:ed:e8:7f:6f:22:
                    a5:25:41:91:aa:99:eb:01:bf:dc:c5:6f:cb:ed:3b:
                    0e:a0:bb:f1:ae:ca:88:81:ae:54:ea:79:01:51:18:
                    36:6d:27:ea:d2:80:b3:2a:80:ac:f6:6a:a5:70:d4:
                    83:fe:70:cc:95:9a:f6:46:0a:c9:d4:20:28:d4:4f:
                    49:2d:fa:b2:3e:fb:c2:20:d3:e5:fc:de:2b:d0:75:
                    99:0e:2c:77:1d:54:47:88:f2:f1:52:ec:ee:e9:0b:
                    18:bb:ad:02:26:f8:bb:c0:af:9f:fa:1a:ec:20:28:
                    bc:63:87:f6:34:32:5f:b8:ce:18:20:e7:c4:1d:22:
                    81:43:8a:eb:c5:13:e9:5f:75:5d:fa:ad:d6:5f:34:
                    00:6c:4f:a6:d1:02:ed:fe:6e:9c:6f:d0:8e:13:7a:
                    0c:01:ee:1f:47:e5:c2:01:2e:d5:99:91:36:18:42:
                    4a:ad
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Subject Alternative Name: 
                DNS:kafka.test.local, DNS:localhost, DNS:broker, DNS:kafka
            X509v3 Subject Key Identifier: 
                24:27:4A:17:23:EB:FC:C6:5A:38:C4:F6:58:54:C3:29:2B:F9:77:4D
            X509v3 Authority Key Identifier: 
                5C:45:62:04:D6:07:72:72:2E:05:E6:78:7B:9B:6A:15:F6:17:18:17
    Signature Algorithm: sha256WithRSAEncryption
    Signature Value:
        a5:f7:b6:6c:b0:f1:4f:17:7d:14:1d:05:94:5a:28:6d:e5:6a:
        d5:ea:0b:f5:d0:0d:c7:82:86:0b:e2:9e:c4:cb:5f:c7:9e:03:
        3a:ac:3a:b8:68:1b:96:bb:8f:29:45:07:f2:7b:a6:41:68:50:
        06:59:11:ff:ce:ed:42:98:cc:2a:bb:09:d9:6c:53:9f:84:75:
        60:34:98:5a:b5:8e:f4:60:50:35:2f:ad:ce:34:f1:9c:2c:f8:
        f4:69:02:0b:ed:6a:cd:fc:1a:4b:26:43:74:5d:6f:06:f6:0d:
        ae:77:94:f8:07:c2:52:8e:16:db:9a:90:4c:35:7f:db:ec:af:
        18:9d:b3:17:4e:17:30:36:9a:3c:1f:8e:4d:e2:e7:5f:75:9a:
        2f:dd:0b:85:10:9c:9d:b8:46:ad:15:0f:da:92:64:26:d8:4a:
        10:87:b1:e2:aa:b0:87:c9:2f:b3:b8:be:ca:94:3e:db:19:2a:
        35:89:65:35:46:eb:87:38:80:4b:d5:f7:0d:51:b6:99:6e:ee:
        9f:11:5d:93:b0:ed:56:b9:82:3f:32:bd:bc:a1:8b:c2:43:b5:
        46:33:7a:cc:0f:c3:f7:20:49:70:70:25:7b:b9:7c:42:9d:49:
        f1:62:ea:c9:10:c9:08:2c:38:24:08:52:50:ca:10:77:0e:75:
        3f:8d:21:28
```

We should focus from this cert on the validy section, as following we're going update the certs for new ones with increased validity (please don't do this in prod, XD).

*before*
```
        Validity
            Not Before: Oct 11 15:54:11 2023 GMT
            Not After : Oct  9 15:54:11 2028 GMT
```

## Rotate the certs

Note, we have previously made available in the shared volume the new certs under the keystore named __kafka3650.keystore__, in production alike systmes you should be updating this
every new rotation. Keep in mind, files should be named separetely.

To rotate the JKS stores you should use the following command

```bash 
$ ./rotate_certs.sh                                                                                                                                                                 ‹system: ruby 2.6.10p210›
Completed updating config for broker 1.
... redacted ...
```

## Validation

if now you retrieve the updated certs, you will notice a few differences

```bash
$ ./show_certs.sh                                                                                                                                                                   ‹system: ruby 2.6.10p210›
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            ef:14:04:b9:d9:da:6a:77
.... redacted....        
```

Serial number is different as old one was __ed:32:f5:c1:12:1a:1d:2f__.

As well the validation is now on the 10y range

```bash
       Validity
            Not Before: Oct 11 15:54:16 2023 GMT
            Not After : Oct  8 15:54:16 2033 GMT
```

So the cert, was correctly updated.

Keep in mind, already open connection will still use the old certs, until a new connection is initiated.
