#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print each command before executing
set -x

# Update package lists
sudo apt update

# Install prerequisites
sudo apt install -y software-properties-common

# Add Git PPA repository
sudo add-apt-repository -y ppa:git-core/ppa

# Update package lists again after adding repository
sudo apt update

# Install Git
sudo apt install -y git

# Verify installation
git --version

echo "Git installation completed successfully!"

