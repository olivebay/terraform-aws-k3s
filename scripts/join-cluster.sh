#!/usr/bin/env bash

# Read from the file we created
K3S_TOKEN=$(cat /tmp/token | tr -d '\n')
MASTER_PRIVATE_IP=$(cat /tmp/master-server-addr | tr -d '\n')

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server=https://${MASTER_PRIVATE_IP}:6443 --token=${K3S_TOKEN}" sh -s -

