#!/bin/bash

# Ping all servers inside preview-inventory as admin user
ansible all -i preview-inventory -m ping -u admin