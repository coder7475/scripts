#!/bin/bash

sudo apt update && sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git -y

