#!/usr/bin/env bash

echo "Joined group list for kafka-connect node 0"
echo ""

docker logs kafka-connect0 2>&1 | grep "Joined group"

echo ""
echo ""


echo "Joined group list for kafka-connect node 1"
echo ""

docker logs kafka-connect1 2>&1 | grep "Joined group"

echo ""
echo ""
