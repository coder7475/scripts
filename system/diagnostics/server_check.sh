#!/bin/bash

# Server Information and System Check Script
# For Ubuntu or Debian-based distros

# 1. Check OS, Kernel, Hardware Architecture, Uptime
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

# 2. Who else is logged in?
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

# 3. Physical or Virtual Machine?
echo "### 3. Physical or Virtual Machine? ###"
echo "System Manufacturer:"
dmidecode -s system-manufacturer
echo
echo "System Product Name:"
dmidecode -s system-product-name
echo
echo "Detailed Hardware Info:"
lshw -c system | grep product | head -1
echo
echo "Product Name (Alternative method):"
cat /sys/class/dmi/id/product_name
echo
echo "System Vendor (Alternative method):"
cat /sys/class/dmi/id/sys_vendor
echo

# 4. Hardware Information
echo "### 4. Hardware Information ###"
echo "CPU Information:"
cat /proc/cpuinfo
echo
echo "Memory Usage:"
cat /proc/meminfo
echo
echo "Network Interfaces:"
ifconfig -a
# Uncomment the following line if `ifconfig` is unavailable
# ip addr
echo
echo "Network Interface eth0 Info:"
ethtool eth0
echo
echo "Full Hardware Info:"
lshw
echo
echo "PCI Devices Info:"
lspci
echo
echo "DMI Hardware Info:"
dmidecode
echo

# 5. Check All Installed Software
echo "### 5. Check All Installed Software ###"
echo "All Installed Packages (dpkg):"
dpkg -l
echo
echo "Check if a specific package is installed (e.g., curl):"
dpkg -l | grep curl
echo
echo "Package info (e.g., curl):"
apt-cache policy curl
echo
echo "List all installed apt packages:"
apt list --installed
echo
echo "Check if a specific package is installed via apt (e.g., curl):"
apt list --installed | grep curl
echo
echo "Package details (e.g., curl):"
apt-cache show curl
echo
echo "Package versions available (e.g., curl):"
apt-cache madison curl
echo
echo "Update package list:"
sudo apt update
echo
echo "List of APT repositories:"
ls -l /etc/apt/sources.list.d/
echo

# 6. Running Processes & Services
echo "### 6. Running Processes & Services ###"
echo "Process Tree:"
pstree -pa 1
echo
echo "List All Processes:"
ps -ef
echo
echo "Process Info (ps aux):"
ps auxf
echo
echo "Systemd Services:"
systemctl
echo

# 7. Check Network Connections
echo "### 7. Check Network Connections ###"
echo "Netstat (Open connections):"
netstat -tulpn
echo
echo "Detailed Netstat Info:"
netstat -anp
echo
echo "Open Network Files (lsof):"
lsof -i
echo
echo "Socket Stats (ss):"
ss
echo
echo "All TCP Sockets (ss):"
ss -t
echo
echo "All UDP Sockets (ss):"
ss -u
echo
echo "Listening Sockets (ss):"
ss -l
echo
echo "All Sockets (ss):"
ss -a
echo
echo "Socket Summary (ss):"
ss -s
echo
echo "Process Using Socket (ss):"
ss -p
echo
echo "Numerical Addresses (ss):"
ss -n
echo
echo "Firewall Rules (iptables):"
iptables -L -n
echo
echo "DNS Configuration (resolv.conf):"
cat /etc/resolv.conf
echo

# 8. Kernel Information
echo "### 8. Kernel Information ###"
echo "Grub Configuration:"
cat /boot/grub/grub.conf
echo
echo "Kernel Parameters (sysctl):"
sysctl -a
echo
echo "Loaded Kernel Modules:"
lsmod
echo
echo "Module Info (e.g., tcp_bbr):"
modinfo tcp_bbr
echo
echo "Current Kernel Version:"
uname -r
echo
echo "Kernel Command Line Parameters:"
cat /proc/cmdline
echo

# 9. Logs
echo "### 9. Logs ###"
echo "System Logs (journalctl):"
journalctl
echo
echo "Latest System Log Entries (syslog):"
tail -f /var/log/syslog
echo
echo "Kernel Ring Buffer Messages (dmesg):"
dmesg
echo

echo "### All checks completed. ###"
