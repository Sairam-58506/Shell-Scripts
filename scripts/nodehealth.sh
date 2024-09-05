#!/usr/bin/env bash

# Function to check CPU usage
check_cpu() {
    echo "CPU Usage:"
    mpstat 1 1 | awk '/Average:/ {printf "CPU Idle: %.2f%%\n", $12}'
}

# Function to check memory usage
check_memory() {
    echo "Memory Usage:"
    free -h | awk '/Mem:/ {printf "Used: %s / Total: %s\n", $3, $2}'
}

# Function to check disk space usage
check_disk_space() {
    echo "Disk Space Usage:"
    df -h | awk '$NF=="/"{printf "Disk Usage: %d%%\n", $5}'
}

# Function to check network connectivity
check_network() {
    echo "Network Connectivity (pinging 8.8.8.8):"
    if ping -c 2 8.8.8.8 &> /dev/null; then
        echo "Network is UP"
    else
        echo "Network is DOWN"
    fi
}

# Function to check critical services (e.g., ssh)
check_service_status() {
    SERVICE="ssh"
    echo "Checking $SERVICE service status:"
    if systemctl is-active --quiet $SERVICE; then
        echo "$SERVICE is running"
    else
        echo "$SERVICE is not running"
    fi
}

# Function to check system uptime
check_uptime() {
    echo "System Uptime:"
    uptime -p
}

# Function to generate health report
generate_report() {
    echo "====================================="
    echo "Node Health Report - $(date)"
    echo "====================================="
    
    check_cpu
    echo "-------------------------------------"
    
    check_memory
    echo "-------------------------------------"
    
    check_disk_space
    echo "-------------------------------------"
    
    check_network
    echo "-------------------------------------"
    
    check_service_status
    echo "-------------------------------------"
    
    check_uptime
    echo "====================================="
}

# Call the function to generate the report
generate_report
