#!/bin/bash

# Define log file
LOG_FILE="logs.txt"

# Check if file exists
if [[ ! -f "$LOG_FILE" ]]; then
    exit 1
fi

# Extract the endpoint (URL), count occurrences, sort, and print only the top URL
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
