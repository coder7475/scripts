#!/bin/bash

# list all servers in inventory
ansible all -i ~/ansible/inventory --list -y
# Ping all servers inside preview-inventory as admin user
ansible all -i ~/ansible/inventory -m ping -u admin