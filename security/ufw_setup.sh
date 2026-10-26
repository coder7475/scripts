#!/bin/bash

sudo apt update
sudo apt install -y ufw

# Allow SSH connections
sudo ufw allow OpenSSH

# Allow HTTP and HTTPS connections
sudo ufw allow 'Nginx Full'

# Enable UFW
sudo ufw enable

# Check the status of UFW
sudo ufw status
