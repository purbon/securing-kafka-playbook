#!/usr/bin/env bash

docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock -d gaiaadm/pumba:0.9.0 \
    netem --duration 20m \
      delay \
        --time 10000 \
        --distribution normal \
      kafka-connect1
