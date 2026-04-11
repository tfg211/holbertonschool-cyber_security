#!/bin/bash

LOG_FILE="logs.txt"

if [[ ! -f "$LOG_FILE" ]]; then
    exit 1
fi

ATTACKER_IP=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

grep "$ATTACKER_IP" "$LOG_FILE" | awk -F'\"' '{print $6}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
