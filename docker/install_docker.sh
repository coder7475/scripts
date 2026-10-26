#!/bin/bash
# ====================================================================
# Docker Installation Script for Ubuntu
# 
# This script installs Docker Community Edition and related components
# on Ubuntu-based systems with error handling and verification.
# ====================================================================

# Exit immediately if a command fails
set -e

# Function for error handling
error_exit() {
    echo "ERROR: $1" >&2
    exit 1
}

# Function to display status messages
info() {
    echo -e "\n[INFO] $1"
}

# Check if script is run as root or with sudo
if [ "$EUID" -ne 0 ] && [ -z "$SUDO_USER" ]; then
    error_exit "This script must be run with sudo or as root"
fi

# Check if system is Ubuntu-based
if [ ! -f /etc/os-release ] || ! grep -q "Ubuntu\|Debian" /etc/os-release; then
    error_exit "This script is designed for Ubuntu/Debian-based systems"
fi

# Uninstall old versions (if any)
info "Checking for old Docker installations..."
if dpkg -l | grep -q "docker\|docker-engine\|docker.io\|containerd\|runc"; then
    info "Removing old Docker versions..."
    sudo apt-get remove -y docker docker-engine docker.io containerd runc || error_exit "Failed to remove old Docker versions"
fi

# Update package index
info "Updating package index..."
sudo apt-get update || error_exit "Failed to update package index"

# Install prerequisites
info "Installing prerequisites..."
sudo apt-get install -y ca-certificates curl gnupg || error_exit "Failed to install prerequisites"

# Create directory for Docker's GPG key
info "Setting up Docker repository..."
sudo install -m 0755 -d /etc/apt/keyrings || error_exit "Failed to create keyrings directory"

# Download Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc || error_exit "Failed to download Docker's GPG key"
sudo chmod a+r /etc/apt/keyrings/docker.asc || error_exit "Failed to set permissions on Docker's GPG key"

# Add Docker's repository to Apt sources
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || error_exit "Failed to add Docker repository"

# Update the package index again
info "Updating package index with Docker repository..."
sudo apt-get update || error_exit "Failed to update package index with Docker repository"

# Install Docker and related packages
info "Installing Docker Engine and related packages..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || error_exit "Failed to install Docker packages"

# Ensure Docker service is enabled and started
info "Starting Docker services..."
sudo systemctl enable containerd docker || error_exit "Failed to enable Docker services"
sudo systemctl start containerd docker || error_exit "Failed to start Docker services"

# Add current user to docker group (to use Docker without sudo)
if [ -n "$SUDO_USER" ]; then
    info "Adding user $SUDO_USER to the docker group..."
    sudo usermod -aG docker "$SUDO_USER" || error_exit "Failed to add user to docker group"
    info "NOTE: Log out and back in for the group changes to take effect"
fi

# Verify Docker installation
info "Verifying Docker installation..."
docker --version || error_exit "Docker installation verification failed"
docker run hello-world || error_exit "Docker hello-world test failed"

info "Docker installation completed successfully!"
info "Docker version: $(docker --version)"
info "Docker Compose version: $(docker compose version)"

# Print instructions for the user
echo "
====================================================================
Docker has been successfully installed on your system!

To use Docker as a non-root user:
  1. Log out and log back in for the group changes to take effect
  2. Verify with: docker run hello-world

For more information, visit https://docs.docker.com/
===================================================================="