#!/bin/bash

# Install Netdata
echo "Installing Netdata..."
# bash <(curl -Ss https://my-netdata.io/kickstart.sh)

curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh

echo "Netdata installation complete."