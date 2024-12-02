#!/bin/bash

# To modify permissions on files and directories on your remote nodes, you can use the file module.
ansible all -i inventory -m file -a "dest=/var/www/file.txt mode=600 owner=admin group=admin" --become  -K