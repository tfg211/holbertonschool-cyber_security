#!/bin/bash

LOG_FILE="logs.txt"

if [[ ! -f "$LOG_FILE" ]]; then
    exit 1
fi

# Extract IP, count, sort, take the top one, then print ONLY the IP column
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
