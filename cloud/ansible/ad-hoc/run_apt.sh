#!/bin/bash

# ansible target -i inventory -m module -a "module options"
# this will use the apt module to install the package tree on server1 with privilege escalation:
ansible server1 -i inventory -m apt -a "name=tree" --become