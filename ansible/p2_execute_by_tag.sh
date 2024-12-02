#!/bin/bash

# Execute by tag
ansible-playbook -i inventory playbook.yml --tags=setup

# Skipping task by tag
ansible-playbook -i inventory playbook.yml --exclude-tags=setup

# Execution started at certain task
ansible-playbook -i inventory playbook.yml --start-at-task=Copy index page