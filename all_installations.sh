#!/bin/bash

# Update and install Git
echo "Installing Git..."
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y git

# Install Node.js
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

# Install and check Nginx
echo "Installing and checking Nginx..."
sudo apt update
sudo apt install -y nginx
sudo service nginx status

# Install and configure PM2
echo "Installing and configuring PM2..."
sudo npm install -g pm2@latest
sudo pm2 startup
sudo pm2 --version

# Install and configure UFW
echo "Installing and configuring UFW..."
sudo apt update
sudo apt install -y ufw
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw enable
sudo ufw status
