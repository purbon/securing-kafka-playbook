#!/usr/bin/env bash

pumba netem delay -t 200 -d normal containers


docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock -d gaiaadm/pumba:0.9.0 \
    netem --duration 10m \
      delay \
        --time 30000 \
        --distribution normal \
      connect-1


docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock -d gaiaadm/pumba:0.9.0 \
    netem --duration 5m \
      delay \
        --time 30000 \
        --distribution normal \
      connect-1 kafka

docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock -d gaiaadm/pumba:0.9.0 \
    netem --duration 5m \
       delay \
         --time 30000 \
         --distribution normal \
       kafka connect-1
