#!/bin/bash
echo 'echo -e "\n" | ssh-keygen -t rsa -b 4096 -N "" -C "root@example"' | docker exec -i jenkins bash
