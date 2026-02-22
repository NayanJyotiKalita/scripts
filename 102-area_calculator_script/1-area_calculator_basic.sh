#!/bin/bash

#####################################################################
# Author: Nayan Jyoti Kalita
# Version: v0.0.1
#
# Script to calculate the area of basic geometric shapes.
#
# Supported shapes:
# 1. Circle
# 2. Square
# 3. Rectangle
#
# The script supports:
# - Command-line mode
# - Interactive mode
#
# Usage:
#   ./area_calculator.sh [option] [shape] [dimension1] [dimension2]
#
# Options:
#   -h   Display help message
#   -i   Interactive mode
#
# Examples:
#   ./area_calculator.sh circle 5
#   ./area_calculator.sh rectangle 5 10
#   ./area_calculator.sh -i
#
#####################################################################

# Display help/usage information
display_help() {
    echo "Usage: ./calculate_area.sh [option] [shape] [dimension1] [dimension2]"
    echo -e "\nCalculate the area of various geometric shapes.\n"
    echo -e "Options:\n  -h              Display this help message.\n  -i              Interactive mode.\n"
    echo -e "Shapes and dimensions:\n  circle radius          Calculate the area of a circle.\n  square side            Calculate the area of a square.\n  rectangle length width Calculate the area of a rectangle."
    exit 0
}

# Calculate area based on shape
calculate_area() {
    case "$1" in
        circle) echo "Area of the circle: $(echo "3.14159 * $2 * $2" | bc)" ;;
        square) echo "Area of the square: $(echo "$2 * $2" | bc)" ;;
        rectangle) echo "Area of the rectangle: $(echo "$2 * $3" | bc)" ;;
        *) echo "Invalid shape. Use -h for help."; exit 1 ;;
    esac
}

# Interactive mode for user input
interactive_mode() {
    echo -e "Choose shape:\n1. Circle\n2. Square\n3. Rectangle"
    echo "Enter your choice (1/2/3): "
    read -p "Enter choice: " choice
    case $choice in
        1) read -p "Enter the radius: " radius; calculate_area circle $radius; exit 0;;
        2) read -p "Enter the length: " length; calculate_area square $length; exit 0;;
        3) read -p "Enter the length and width: " length width; calculate_area rectangle $length $width; exit 0;;
        *) echo "Invalid choice."; exit 1;;
    esac
}

# Argument handling
[[ "$1" == "-h" ]] && display_help
[[ "$1" == "-i" ]] && interactive_mode
[[ $# -lt 2 ]] && { echo "Insufficient arguments. Use -h for help."; exit 1; }

calculate_area "$1" "$2" "$3"
