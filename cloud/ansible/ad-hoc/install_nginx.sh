#!/bin/bash

# use ansible adhoc command to install nginx with sudo power and prompt for password
ansible all -i inventory -m apt -a "name=nginx" --become -K