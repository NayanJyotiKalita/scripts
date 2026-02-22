#!/bin/bash

#####################################################################
# Author: Dhama Dhora
# Version: v0.0.1
#
# Script to calculate the area of various geometric shapes.
#
# Below are the shapes that are supported by this script:
# 1. Circle
# 2. Square
# 3. Rectangle
#
# The script supports both command-line mode and interactive mode.
# It can also log calculation details to a specified log file.
#
# Features:
# - Command-line arguments for direct calculation
# - Interactive selection mode
# - Optional debug flag (reserved)
# - Custom log file support
#
# Usage:
#   ./calculate_area.sh [-h] [-i] [--debug] [--logfile filename] [shape dimensions]
#
# Examples:
#   ./calculate_area.sh circle 5
#   ./calculate_area.sh rectangle 5 10
#   ./calculate_area.sh -i
#   ./calculate_area.sh --logfile /tmp/area.log square 4
#
#####################################################################

log_file=/home/user/logs/calculate_area.log

# Display help/usage information
display_help() {
    echo "Usage: ./calculate_area.sh [-h] [-i] [--debug] [--logfile filename] [shape dimensions]"
    echo "Calculate the area of various geometric shapes."

    echo -e "Options:"
    echo "-h              Display this help message."
    echo "-i              Interactive mode."
    echo "--debug         Enable detailed debug logging."
    echo "--logfile FILE  Specify the file to log to."

    echo -e "\nShapes:"
    echo "circle radius              Calculate the area of a circle."
    echo "square side                Calculate the area of a square."
    echo "rectangle length width     Calculate the area of a rectangle."
    exit 0
}

# Calculate area based on shape and parameters
calculate_area() {
    timestamp=$(date +"[%Y-%m-%d %H-%M-%S]")
    shape=$1
    param1=$2

    case "$1" in
        circle)
            area=$(echo "3.14159 * $param1 * $param1" | bc)
            echo "The area of the circle is $area square units."
            log_msg="$timestamp [INFO] :: Calculated area of the circle with radius $param1: $area"
            echo $log_msg >> $log_file
            ;;

        square)
            area=$(echo "$param1 * $param1" | bc)
            echo "The area of the square is $area square units."
            log_msg="$timestamp [INFO] :: Calculated area of the square with side $param1: $area"
            echo $log_msg >> $log_file
            ;;

        rectangle)
            param2=$3
            area=$(echo "$param1 * $param2" | bc)
            echo "The area of the rectangle is $area square units."
            log_msg="$timestamp [INFO] :: Calculated area of the rectangle with length $param1 and width $param2: $area"
            echo $log_msg >> $log_file
            ;;

        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac
}

# Interactive mode for user input
interactive_mode() {
    echo -e "Select the type of area to calculate:"
    echo "1. Circle"
    echo "2. Square"
    echo "3. Rectangle"

    read -p "Enter choice(1-3): " choice
    case $choice in
        1)
            read -p "Enter the radius: " radius
            calculate_area circle $radius
            exit 0
            ;;
        2)
            read -p "Enter the length: " length
            calculate_area square $length
            exit 0
            ;;
        3)
            read -p "Enter the length: " length
            read -p "Enter the width: " width
            calculate_area rectangle $length $width
            exit 0
            ;;
        *)
            echo "Invalid choice. Use -h for help"
            exit 1
            ;;
    esac
}

# Ensure at least one argument is provided
[[ $# -eq 0 ]] && { echo "Insufficient arguments. Use -h for help."; exit 1; }

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h)
            display_help
            ;;
        -i)
            interactive_mode
            exit 0
            ;;
        circle | rectangle | square)
            shape=$1
            param1=$2
            param2=$3
            calculate_area "$shape" "$param1" "$param2"
            exit 0
            ;;
        --debug)
            # Reserved for future debug implementation
            ;;
        --logfile)
            log_file="$2"
            shift
            ;;
        *)
            echo "Unknown Option: $1. Use -h for help"
            exit 1
            ;;
    esac
    shift
done
