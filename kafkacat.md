# Kafkacat

docker run --tty \
           confluentinc/cp-kafkacat \
           kafkacat -b kafka:9092 -C -K: \
                    -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\n\Partition: %p\tOffset: %o\n--\n' \
                    -t test
