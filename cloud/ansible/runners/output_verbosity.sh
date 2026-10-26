#!/bin/bash

# increase verbosity by level 1
ansible-playbook -i inventory playbook.yml -v

# increase verbosity by level 2
ansible-playbook -i inventory playbook.yml -vv

# increase verbosity by level 3
ansible-playbook -i inventory playbook.yml -vvv

# Debugging information for the remote node that can't be connected
ansible-playbook -i inventory playbook.yml -vvvv