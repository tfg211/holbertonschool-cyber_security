#!/bin/bash
awk '/Accepted password for root/ {print $11}' auth.log | sort -u | wc -l | tr -d '\n'
