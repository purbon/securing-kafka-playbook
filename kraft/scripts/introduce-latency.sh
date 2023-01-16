#!/usr/bin/env bash

docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba \
    --random netem --duration 5m \
    delay \
    --time 10000 \
    --jitter 40 \
    --distribution pareto \
    kafka1 kafka2
