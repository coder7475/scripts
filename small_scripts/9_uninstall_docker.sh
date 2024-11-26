#!/bin/bash

read -p "Are you sure you want to uninstall Docker packages? (y/n): " confirm
if [[ $confirm == [yY] ]]; then
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
        sudo apt-get remove -y $pkg
    done
else
    echo "Uninstallation canceled."
fi