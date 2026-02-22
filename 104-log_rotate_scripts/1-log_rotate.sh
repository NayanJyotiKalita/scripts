#!/bin/bash

#####################################################################
# Author: Nayan Jyoti Kalita
# Version: v1.0.0
#
# Script: Log Rotation (Size-Based)
#
# Description:
# Monitor the size of an application log file and rotate it when the
# file exceeds a defined size threshold. Rotation renames the log
# with a timestamp and creates a new empty log file.
#
# Scenario:
# Application log (/opt/app/app.log) grows daily.
# If size > 100 MB → rotate log.
#
# Rotation Process:
# 1. Rename current log with timestamp
# 2. Create new empty log file
#
# Usage:
#   ./log_rotate.sh
#
#####################################################################

set -euo pipefail

###############################################################
# Configuration
###############################################################
LOG="/opt/app/app.log"     # Log file path
MAX_SIZE=100000000        # 100 MB in bytes

###############################################################
# Get current log size (bytes)
###############################################################
SIZE=$(stat -c%s "$LOG")
# stat -c%s → print file size in bytes

###############################################################
# Rotate if size exceeds threshold
###############################################################
if [[ "$SIZE" -gt "$MAX_SIZE" ]]; then
    # Rename log with timestamp
    mv "$LOG" "$LOG.$(date +%F_%H-%M-%S)"

    # Create new empty log file
    touch "$LOG"

    echo "LOG rotated (size exceeded threshold)"
else
    echo "Log size normal"
fi
