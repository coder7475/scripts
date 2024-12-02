#!/bin/bash

# The setup module returns detailed information about the remote systems managed by Ansible, also known as system facts.
ansible server1 -i ~/ansible/inventory -m setup
# To print only the most relevant information, run
ansible server1 -i ~/ansible/inventory -m setup -a "gather_subset=min"
# To print only specific items, ex: ip address run:
ansible server1 -i ~/ansible/inventory -m setup -a "filter=*ipv*"