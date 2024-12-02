#!/bin/bash

# List all tasks contained in a playbook
ansible-playbook -i inventory playbook.yml --list-tasks

# Listing Playbook Tags
ansible-playbook -i inventory playbook.yml --list-tags
