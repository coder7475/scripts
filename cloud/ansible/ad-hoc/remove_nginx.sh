#!/bin/bash

ansible all -i inventory -m apt -a "name=nginx state=absent" --become  -K