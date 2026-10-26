#!/bin/bash

echo "Installing PM2..."
sudo npm install -g pm2@latest

echo "Setting up PM2 to start on boot..."
sudo pm2 startup

echo "Checking PM2 version..."
sudo pm2 --version