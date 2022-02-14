#!/bin/bash

# Install pre-requisites
apt-get install -y apt-transport-https
apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# Add stable repository
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
apt-get update

# Install Grafana
apt-get install -y grafana

# Initialize Grafana
systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server.service

# Install Zabbix plugin for Grafana
grafana-cli plugins install alexanderzobnin-zabbix-app
systemctl restart grafana-server