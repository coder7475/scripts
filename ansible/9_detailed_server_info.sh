#!/bin/bash

# The setup module returns detailed information about the remote systems managed by Ansible, also known as system facts.
ansible server1 -i inventory -m setup