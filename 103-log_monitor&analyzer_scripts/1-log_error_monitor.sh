#####################################################################
# Topic: Shell Scripting
# Focus Areas:
# - Case Studies
# - Interviews
#
# Practical 1:
# Monitor ERROR entries in a production application log file.
#
# Scenario:
# A production server is running an application. You need to monitor
# the number of ERROR messages in the application log (app.log)
# and raise an alert if errors are present.
#
#####################################################################

###############################################################
# Step 1: Create Sample Log File (for practice/demo)
###############################################################

# Example log file path
# /opt/app/app.log

# Sample content:
# INFO  Application started
# INFO  Database connected
# ERROR Connection timeout
# INFO  Retrying...
# ERROR Disk space low

###############################################################
# Step 2: Script to Monitor ERROR Count
###############################################################

#!/bin/bash
# Shebang: tells the system to use the bash interpreter

set -euo pipefail
# -e  -> exit on error
# -u  -> error on undefined variable
# -o pipefail -> fail if any command in pipeline fails

LOG_FILE="/opt/app/app.log"
# Variable storing the log file path

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    # !  -> NOT operator
    # -f -> true if file exists and is a regular file

    echo "Log file not found: $LOG_FILE"
    exit 1
    # Exit code 1 -> error
fi

# Count lines containing the word ERROR
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")
# $() -> command substitution
# grep -> search text
# -c -> count matching lines

# Alert if errors exist
if [ "$ERROR_COUNT" -gt 0 ]; then
    echo "ALERT: $ERROR_COUNT error(s) found in log file!"
fi
