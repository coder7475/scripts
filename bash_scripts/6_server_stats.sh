#!/bin/bash

# Function to get total CPU usage
get_cpu_usage() {
    echo "Total CPU Usage:"
    # Extract the idle CPU percentage and subtract from 100 to get usage
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
    cpu_usage=$((100 - cpu_idle))
    echo "$cpu_usage%"
}

# Function to get total memory usage
get_memory_usage() {
    echo "Total Memory Usage (Free vs Used):"
    # Using free command to get memory stats and calculate percentages
    free_mem=$(free -m | grep Mem)
    total_mem=$(echo $free_mem | awk '{print $2}')
    used_mem=$(echo $free_mem | awk '{print $3}')
    free_mem=$(echo $free_mem | awk '{print $4}')
    total_mem_gb=$(echo "scale=2; $total_mem / 1024" | bc)
    mem_percentage=$(echo "scale=2; $used_mem / $total_mem * 100" | bc)
    echo "Total: $total_mem_gb GB Used: $used_mem MB, Free: $free_mem MB ($mem_percentage% used)"
}

# Function to get total disk usage
get_disk_usage() {
    echo "Total Disk Usage (Free vs Used):"
    df -h --total | grep 'total' | awk '{print "Used: "$3", Free: "$4", Usage: "$5}'
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to get top 5 processes by memory usage
get_top_mem_processes() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Stretch goal: Get additional stats
get_additional_stats() {
    echo "OS Version:"
    uname -a

    echo ""
    echo "Uptime:"
    uptime

    echo ""
    echo "Load Average:"
    uptime | awk -F'load average:' '{ print $2 }'

    echo ""
    echo "Logged In Users:"
    who

    echo ""
    echo "Failed Login Attempts:"
    sudo grep "Failed password" /var/log/auth.log | wc -l
}

# Main script
echo "Server Performance Stats"
echo "========================"
get_cpu_usage
echo ""
get_memory_usage
echo ""
get_disk_usage
echo ""
get_top_cpu_processes
echo ""
get_top_mem_processes
echo ""

# Uncomment the following line if you want additional stats as part of the output
get_additional_stats
echo ""