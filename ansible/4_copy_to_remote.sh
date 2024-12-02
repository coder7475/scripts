#!/bin/bash

ansible all -i inventory -m copy -a "src=./file.txt dest=~/myfile.txt"