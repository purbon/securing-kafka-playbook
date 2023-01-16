
#!/usr/bin/env bash

docker exec --interactive  kafka4 kafka-console-producer --bootstrap-server kafka4:29095  --topic bar
