#!/bin/bash

# Check if the IP address argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <container_ip>"
    exit 1
fi

container_ip=$1

# Check if the container endpoint is reachable
response=$(curl -s -o /dev/null -w "%{http_code}" http://$container_ip:8080)
if [ "$response" == "200" ]; then
    echo "Container endpoint is reachable"
else
    echo "Container endpoint is not reachable"
    exit 1
fi
