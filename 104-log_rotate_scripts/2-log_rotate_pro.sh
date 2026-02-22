#!/bin/bash

#####################################################################
# Author: Nayan Jyoti Kalita
# Version: v1.0.0
#
# Script: Log Rotation (Size-Based with Compression & Retention)
#
# Description:
# Monitor the size of an application log file and rotate it when the
# file exceeds a defined size threshold. Rotation renames the log
# with a timestamp, compresses the archived log, and enforces a
# retention policy to keep only the latest N archives.
#
# Features:
# - Size-based log rotation
# - Timestamped archive names
# - Automatic gzip compression
# - Retention cleanup (keep last N logs)
#
# Usage:
#   ./log_rotate_size.sh
#

# When log exceeds 100MB:
#
# 1️⃣ app.log → app.log.2026-02-23_12-30-01
# 2️⃣ compress → app.log.2026-02-23_12-30-01.gz
# 3️⃣ new empty app.log created
# 4️⃣ only last 7 archives kept
#####################################################################

set -euo pipefail

###############################################################
# Configuration
###############################################################
LOG="/opt/app/app.log"      # Log file path
MAX_SIZE=100000000          # 100 MB in bytes
RETENTION=7                 # Number of rotated logs to keep

###############################################################
# Validate log file
###############################################################
if [[ ! -f "$LOG" ]]; then
    echo "Log file not found: $LOG"
    exit 1
fi

###############################################################
# Get current log size
###############################################################
SIZE=$(stat -c%s "$LOG")

###############################################################
# Rotate if size exceeds threshold
###############################################################
if [[ "$SIZE" -gt "$MAX_SIZE" ]]; then
    TIMESTAMP=$(date +%F_%H-%M-%S)
    ARCHIVE="$LOG.$TIMESTAMP"

    # Rename current log
    mv "$LOG" "$ARCHIVE"

    # Create new empty log
    touch "$LOG"

    # Compress archive
    gzip "$ARCHIVE"

    echo "Log rotated: $ARCHIVE.gz"

    ###########################################################
    # Retention: keep only latest N archives
    ###########################################################
    ls -1t "$LOG".*.gz 2>/dev/null | tail -n +$((RETENTION+1)) | xargs -r rm --

    echo "Retention applied (kept last $RETENTION archives)"
else
    echo "Log size normal"
fi

##################################################################
# to set up cronjob:

# crontab -e
# 0 * * * * /opt/scripts/log_rotate_size.sh >> /var/log/log_rotate.log 2>&1
##################################################################
