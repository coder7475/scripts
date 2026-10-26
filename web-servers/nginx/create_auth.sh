#!/bin/bash

while true; do
  read -r -p "Username: " ngxuser
  if [[ -z "$ngxuser" ]]; then
    echo "Username is empty. Try again!"
    continue
  fi
  ngxpass="$(openssl passwd -6)"
  if (($? != 0)); then
    echo "Try again!"
  else
    break
  fi
done
echo "$ngxuser:$ngxpass" | sudo tee -a /etc/nginx/users
