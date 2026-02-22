#!/bin/bash

#####################################################################
# Author: Nayan Jyoti Kalita
# Version: v1.0.0
#
# Script: Log Analyzer
#
# Description:
# Perform log analysis on system/application log files. Supports
# filtering log entries by level (INFO, WARN, ERROR, DEBUG) and
# categorizing log levels with counts.
#
# Features:
# - Filter logs by severity level
# - Count occurrences of each log level
# - Interactive mode
# - Custom log file support
#
# Usage:
#   ./log_analyzer.sh [-h] [-i] [--file filename] [operation criteria]
#
# Options:
#   -h              Display help
#   -i              Interactive mode
#   --file FILE     Log file to operate on
#
# Operations:
#   filter LEVEL    Filter logs by level (INFO, WARN, ERROR, DEBUG)
#   categorize      Count log levels
#
# Examples:
#   ./log_analyzer.sh --file app.log filter ERROR
#   ./log_analyzer.sh --file syslog categorize
#   ./log_analyzer.sh -i
#
#####################################################################

###############################################################
# Display help information
###############################################################
show_help() {
    echo "Usage: ./log_analyzer.sh [-h] [-i] [--file filename] [operation criteria]"
    echo "Perform log analysis on system log files."
    echo
    echo "Options:"
    echo "  -h               Display help"
    echo "  -i               Interactive mode"
    echo "  --file FILE      Log file to operate on"
    echo
    echo "Operations:"
    echo "  filter LEVEL     Filter logs by level (INFO, WARN, ERROR, DEBUG)"
    echo "  categorize       Count log levels"
    exit 0
}

###############################################################
# Validate log file existence
###############################################################
validate_file() {
    if [[ -z "$log_file" || ! -f "$log_file" ]]; then
        echo "Invalid or missing log file"
        exit 1
    fi
}

###############################################################
# Filter logs by severity level
###############################################################
filter() {
    local criteria="$1"
    validate_file

    case "$criteria" in
        ERROR|INFO|WARN|DEBUG)
            grep "$criteria" "$log_file"
            ;;
        *)
            echo "Invalid criteria. Use -h for help"
            exit 1
            ;;
    esac
}

###############################################################
# Categorize log levels with counts
###############################################################
categorize() {
    validate_file
    grep -Eo 'ERROR|INFO|WARN|DEBUG' "$log_file" | sort | uniq -c | sort -nr
}

###############################################################
# Interactive mode
###############################################################
interactive_mode() {
    read -p "Enter the log filename: " log_file
    validate_file

    read -p "Choose operation (filter/categorize): " operation

    case "$operation" in
        filter)
            read -p "Enter criteria (ERROR/INFO/WARN/DEBUG): " criteria
            filter "$criteria"
            ;;
        categorize)
            categorize
            ;;
        *)
            echo "Invalid operation"
            exit 1
            ;;
    esac
}

###############################################################
# Argument handling
###############################################################
[[ $# -eq 0 ]] && { echo "Insufficient arguments. Use -h for help."; exit 1; }

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h)
            show_help
            ;;
        -i)
            interactive_mode
            exit 0
            ;;
        --file)
            log_file="$2"
            shift
            ;;
        filter)
            criteria="$2"
            filter "$criteria"
            exit 0
            ;;
        categorize)
            categorize
            exit 0
            ;;
        *)
            echo "Invalid input. Use -h for help"
            exit 1
            ;;
    esac
    shift
done
