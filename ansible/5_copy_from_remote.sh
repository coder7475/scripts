#!/bin/bash

ansible all -i inventory -m copy -a "src=~/myfile.txt remote_src=yes dest=./file.txt"