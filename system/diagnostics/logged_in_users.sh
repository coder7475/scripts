#!/bin/bash

# logged_in_users.sh
# Check who else is logged in

echo "### 2. Who else is logged in? ###"
echo "Logged In Users:"
who
echo
echo "Users and their last login info:"
who -Hu
echo
echo "Users with a shell:"
grep sh$ /etc/passwd
echo
