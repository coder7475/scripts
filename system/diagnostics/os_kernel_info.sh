#!/bin/bash

# os_kernel_info.sh
# Check OS, Kernel, Hardware Architecture, Uptime

echo "### 1. OS, Kernel, Hardware Architecture, Uptime ###"
echo "OS Information:"
cat /etc/os-release
echo
echo "Kernel Information:"
uname -a
echo
echo "Host Information:"
hostnamectl
echo
echo "System Uptime:"
uptime
echo
