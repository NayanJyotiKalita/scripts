#!/bin/bash

#####################################################################
# Author: Dhama Dhora
# Version: v0.0.2
#
# Script to calculate the area of geometric shapes with logging.
#
# Supported shapes:
# 1. Circle
# 2. Square
# 3. Rectangle
#
# Features:
# - Command-line mode
# - Interactive mode
# - Timestamped logging of calculations
#
#####################################################################

log_file="/home/user/logs/calculate_area.log"

display_help() {
    echo "Usage: ./calculate_area.sh [-h] [-i] [shape dimensions]"
    echo "Calculate the area of various geometric shapes."
    echo -e "Shapes:\n  circle radius\n  square side\n  rectangle length width"
    exit 0
}

calculate_area() {
    case "$1" in
        circle)
            area=$(echo "3.14159 * $2 * $2" | bc)
            echo "Area of the circle is: $area square units."
            ;;
        square)
            area=$(echo "$2 * $2" | bc)
            echo "Area of the square is: $area"
            ;;
        rectangle)
            area=$(echo "$2 * $3" | bc)
            echo "Area of the rectangle is: $area"
            ;;
        *)
            echo "Invalid shape. Use -h for help."
            exit 1
            ;;
    esac
}

interactive_mode() {
    timestamp=$(date +"[%Y-%m-%d %H-%M-%S]")

    echo -e "Choose shape:\n1. Circle\n2. Square\n3. Rectangle"
    read -p "Enter choice: " choice

    case $choice in
        1)
            read -p "Enter the radius: " radius
            area=$(echo "3.14159 * $radius * $radius" | bc)
            echo "Area of the circle is: $area square units."
            echo "$timestamp [INFO] :: Calculated area of circle radius=$radius area=$area" >> "$log_file"
            exit 0
            ;;
        2)
            read -p "Enter the length: " length
            area=$(echo "$length * $length" | bc)
            echo "Area of the square is: $area"
            echo "$timestamp [INFO] :: Calculated area of square side=$length area=$area" >> "$log_file"
            exit 0
            ;;
        3)
            read -p "Enter the length: " length
            read -p "Enter the width: " width
            area=$(echo "$length * $width" | bc)
            echo "Area of the rectangle is: $area"
            echo "$timestamp [INFO] :: Calculated area of rectangle length=$length width=$width area=$area" >> "$log_file"
            exit 0
            ;;
        *)
            echo "Invalid choice."
            exit 1
            ;;
    esac
}

[[ "$1" == "-h" ]] && display_help
[[ "$1" == "-i" ]] && interactive_mode
[[ $# -lt 2 ]] && { echo "Insufficient arguments. Use -h for help."; exit 1; }

calculate_area "$1" "$2" "$3"
