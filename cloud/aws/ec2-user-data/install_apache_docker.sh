#!/bin/bash

set -e

# Update
yes | sudo apt update

# Install Apache
yes | sudo apt install apache2

# Install prerequisites for Docker
yes | sudo apt install ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker apt repository
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update again to pick Docker packages
yes | sudo apt update

# Install Docker Engine + CLI + containerd + compose plugin
yes | sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Apache service
sudo systemctl enable --now apache2

# Enable and start Docker service
sudo systemctl enable --now docker
