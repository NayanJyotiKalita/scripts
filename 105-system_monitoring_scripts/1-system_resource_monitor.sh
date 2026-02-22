#!/bin/bash

#####################################################################
# Author: Nayan Jyoti Kalita
# Version: v1.0.0
#
# Script: System Resource Monitor
#
# Description:
# Monitor CPU, memory, and disk usage on a Linux system and report
# status levels (OK / WARNING / CRITICAL) based on defined thresholds.
#
# Requirements:
#   CPU    > 80%  → WARNING
#   Memory > 75%  → WARNING
#   Disk   > 85%  → CRITICAL
#
# Usage:
#   ./system_resource_monitor.sh
#
#####################################################################

###############################################################
# Collect system usage metrics
###############################################################

# CPU usage (%)
cpu=$(top -bn1 | awk '/Cpu/ {printf "%.0f", 100 - $8}')

# Memory usage (%)
mem=$(free | awk '/Mem/ {printf "%.0f", $3/$2 * 100}')

# Disk usage for root filesystem (%)
disk=$(df / | awk 'END {print $5}' | sed 's/%//')

###############################################################
# Display metrics
###############################################################
echo "CPU usage   : ${cpu}%"
echo "Memory usage: ${mem}%"
echo "Disk usage  : ${disk}%"

###############################################################
# Threshold evaluation
###############################################################

status="OK"

# CPU or Memory warning
if [[ "$cpu" -gt 80 || "$mem" -gt 75 ]]; then
    echo "WARNING: High CPU or Memory usage"
    status="WARNING"
fi

# Disk critical
if [[ "$disk" -gt 85 ]]; then
    echo "CRITICAL: Disk almost full"
    status="CRITICAL"
    exit 2
fi

###############################################################
# Final status
###############################################################
if [[ "$status" == "OK" ]]; then
    echo "System status: OK"
fi
