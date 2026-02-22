#!/bin/bash

#####################################################################
# Author: Nayan Jyoti Kalita
# Version: v1.0.0
#
# Script: Log Analyzer
#
# Description:
# Analyze system/application log files to identify and summarize
# error messages. Supports counting, listing, and searching errors.
#
# Features:
# - Count total errors in log
# - List unique error messages with frequency
# - Search errors by keyword
# - Interactive menu mode
# - Custom log file support
#
# Usage:
#   ./log_analyzer.sh [-h] [-i] [log_file]
#
# Options:
#   -h        Display help message
#   -i        Interactive analysis mode
#   log_file  Path to log file (default: /var/log/syslog)
#
# Examples:
#   ./log_analyzer.sh -i
#   ./log_analyzer.sh /var/log/syslog
#   ./log_analyzer.sh -i /home/user/app.log
#
#####################################################################

# Default log file
LOG_FILE="/var/log/syslog"

###############################################################
# Display help/usage information
###############################################################
display_help() {
    echo "Usage: ./log_analyzer.sh [-h] [-i] [log_file]"
    echo
    echo "Analyze log files to identify and summarize error messages."
    echo
    echo "Options:"
    echo "  -h        Display this help message"
    echo "  -i        Interactive mode"
    echo "  log_file  Path to log file (default: /var/log/syslog)"
    exit 0
}

###############################################################
# Validate log file
###############################################################
validate_log() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo "Error: Log file not found: $LOG_FILE"
        exit 1
    fi
}

###############################################################
# Count errors
###############################################################
count_errors() {
    count=$(grep -ic "error" "$LOG_FILE")
    echo "Total number of errors: $count"
}

###############################################################
# List unique errors with frequency
###############################################################
list_errors() {
    echo "Unique error messages and their frequencies:"
    grep -i "error" "$LOG_FILE" | sort | uniq -ic
}

###############################################################
# Search errors by keyword
###############################################################
search_errors() {
    read -p "Enter keyword: " keyword
    echo "Errors containing keyword '$keyword':"
    grep -i "error" "$LOG_FILE" | grep -i -- "$keyword"
}

###############################################################
# Interactive menu
###############################################################
interactive_mode() {
    validate_log

    echo "Select log analysis type:"
    echo "1. Count Errors"
    echo "2. List Errors"
    echo "3. Search Errors"

    read -p "Enter choice (1-3): " choice

    case "$choice" in
        1) count_errors ;;
        2) list_errors ;;
        3) search_errors ;;
        *) echo "Invalid choice"; exit 1 ;;
    esac
}

###############################################################
# Argument parsing
###############################################################
INTERACTIVE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h) display_help ;;
        -i) INTERACTIVE=true ;;
        *) LOG_FILE="$1" ;;
    esac
    shift
done

validate_log

if $INTERACTIVE; then
    interactive_mode
else
    count_errors
fi
