#!/usr/bin/env bash

# Read from the file we created
MYSQL_RDS_ENDPOINT=$(cat /tmp/mysql_endpoint | tr -d '\n')
MASTER_PRIVATE_IP=$(cat /tmp/master-server-addr | tr -d '\n')


echo "Installing k3s on master..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --bind-address=${MASTER_PRIVATE_IP} --datastore-endpoint=${MYSQL_RDS_ENDPOINT})/k3sdb" sh -s -

sudo cp /var/lib/rancher/k3s/server/node-token /tmp/token
sudo chown ubuntu /tmp/token

echo "Output nodes"
sudo k3s kubectl get nodes

