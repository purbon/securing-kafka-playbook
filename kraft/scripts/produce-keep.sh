
#!/usr/bin/env bash

batch=0
for (( ; ; ))
do
  echo "batch $batch"
  docker exec kafka4 bash -c "kafka-console-producer --bootstrap-server kafka4:29095  --topic bar < /data/msgs.txt"
  batch=$((batch+1))
done
