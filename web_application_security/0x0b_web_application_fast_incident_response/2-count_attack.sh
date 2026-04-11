#!/bin/bash

# Define log file
LOG_FILE="logs.txt"

# Check if file exists
if [[ ! -f "$LOG_FILE" ]]; then
    exit 1
fi

# 1. Extract IPs
# 2. Sort and count occurrences
# 3. Sort by highest frequency
# 4. Take the top line
# 5. Print only the count (column 1)
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $1}'
