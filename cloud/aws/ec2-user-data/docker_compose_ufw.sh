#!/bin/bash
set -e

apt update
apt upgrade -y

apt install -y docker.io

# Install Docker Compose V2 plugin
echo "Installing Docker Compose V2 plugin..."

# Add Docker repository (required for docker-compose-plugin)
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

apt update
apt install -y docker-compose-plugin

# Verify Docker Compose V2 is installed
echo "Verifying Docker Compose V2..."
docker compose version

echo "Adding ubuntu user to docker group..."
usermod -aG docker ubuntu

echo "Starting Docker..."
systemctl enable docker
systemctl start docker

echo "Docker installed successfully!"

# Create application directory
echo "Creating application directory..."
mkdir -p /opt/gre-quant/{app,logs}

# Set ownership
chown -R ubuntu:ubuntu /opt/gre-quant

# Configure firewall
ufw allow 80/tcp  # HTTP
ufw allow 443/tcp # HTTPS
ufw allow 22/tcp  # SSH

echo "Bootstrap complete!"
