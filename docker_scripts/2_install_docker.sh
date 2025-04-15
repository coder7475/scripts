#!/bin/bash

sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Create a directory for Docker's GPG key:
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's official GPG key:
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# Update the package index again:
sudo apt-get update

# Install Docker and related packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Activate the docker
sudo systemctl start containerd
sudo systemctl start docker

# Check the status
sudo systemctl status containerd
sudo systemctl status docker

