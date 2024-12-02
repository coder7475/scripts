#!/bin/bash

# To restart the nginx service on all hosts in group called webservers, for instance, you would run:
ansible webservers -i inventory -m service -a "name=nginx state=restarted" --become  -K