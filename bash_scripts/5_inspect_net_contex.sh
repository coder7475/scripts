#!/usr/bin/env bash

echo "# Network devices"
sudo ip link list

echo -e "\n# Route table"
sudo ip route list

echo -e "\n# iptables rules"
sudo iptables --list-rules