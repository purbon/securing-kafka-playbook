#!/usr/bin/env bash

docker run -d -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba \
    --random netem --duration 10m \
    delay \
    --time 50000 \
    --jitter 1000 \
    --distribution pareto \
    kafka3 kafka2
