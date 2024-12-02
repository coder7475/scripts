#!/bin/bash

# To restart all servers in a webservers group, for instance, you would run:
ansible webservers -i inventory -a "/sbin/reboot"  --become  -K