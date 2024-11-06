#!/bin/bash

echo "Stopping Netdata service..."
sudo systemctl stop netdata

echo "Disabling Netdata service..."
sudo systemctl disable netdata

echo "Removing Netdata directories and files..."
sudo rm -rf /etc/netdata
sudo rm -rf /var/lib/netdata
sudo rm -rf /var/log/netdata
sudo rm -rf /usr/libexec/netdata
sudo rm -rf /usr/sbin/netdata
sudo rm -rf /etc/init.d/netdata
sudo rm -rf /usr/share/netdata

echo "Checking for any remaining Netdata processes..."
if pgrep netdata > /dev/null
then
    echo "Killing remaining Netdata processes..."
    sudo pkill netdata
else
    echo "No Netdata processes found."
fi

echo "Netdata uninstalled successfully!"