#!/bin/bash

# Update and install Git
echo "Starting installation of Git..."
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
echo "Installing Git package..."
sudo apt-get install -y git
GIT_VERSION=$(git --version)
echo "Git installed successfully: $GIT_VERSION"

# Install Node.js
echo "Starting installation of Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
echo "Installing Node.js package..."
sudo apt-get install -y nodejs
NODE_VERSION=$(node -v)
echo "Node.js installed successfully: $NODE_VERSION"

# Install and check Nginx
echo "Starting installation of Nginx..."
sudo apt update
echo "Installing Nginx package..."
sudo apt install -y nginx
echo "Enabling Nginx service..."
sudo systemctl enable nginx
NGINX_STATUS=$(sudo service nginx status | grep Active)
echo "Nginx service status: $NGINX_STATUS"
NGINX_VERSION=$(nginx -v 2>&1)
echo "Nginx installed successfully: $NGINX_VERSION"

# Install and configure PM2
echo "Starting installation of PM2..."
sudo npm install -g pm2@latest
echo "Configuring PM2 startup..."
sudo pm2 startup
PM2_VERSION=$(pm2 --version)
echo "PM2 installed successfully: $PM2_VERSION"

# Install and configure UFW
echo "Starting installation of UFW..."
sudo apt install -y ufw
echo "Allowing OpenSSH..."
sudo ufw allow OpenSSH
echo "Allowing Nginx Full..."
sudo ufw allow 'Nginx Full'
echo "Enabling UFW firewall..."
sudo ufw enable -y
UFW_STATUS=$(sudo ufw status)
echo "UFW status:\n$UFW_STATUS"

# Install Certbot
echo "Installing Certbot for SSL configuration..."
sudo apt-get install -y certbot python3-certbot-nginx
CERTBOT_VERSION=$(certbot --version 2>&1)
echo "Certbot installed successfully: $CERTBOT_VERSION"

# Final Server hardening
echo "Starting server updates and cleanup..."
sudo apt update
echo "Applying upgrades..."
sudo apt upgrade -y
echo "Removing unnecessary packages..."
sudo apt autoremove -y

echo "Final checks..."
FINAL_NODE_VERSION=$(node -v)
FINAL_NGINX_VERSION=$(nginx -v 2>&1)
FINAL_NPM_VERSION=$(npm -v)
FINAL_GIT_VERSION=$(git --version)
FINAL_PM2_VERSION=$(pm2 --version)
FINAL_UFW_STATUS=$(sudo ufw status)

echo "Summary of installations:"
echo "Node.js: $FINAL_NODE_VERSION"
echo "Nginx: $FINAL_NGINX_VERSION"
echo "npm: $FINAL_NPM_VERSION"
echo "Git: $FINAL_GIT_VERSION"
echo "PM2: $FINAL_PM2_VERSION"
echo "UFW - $FINAL_UFW_STATUS"

echo "Setup script completed successfully."
