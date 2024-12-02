#!/bin/bash

ansible all -i inventory -m file -a "dest=/var/www/file.txt mode=600 owner=sammy group=sammy" --become  -K