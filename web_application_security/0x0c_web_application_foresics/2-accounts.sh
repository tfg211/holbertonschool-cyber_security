#!/bin/bash
tail -n 1000 auth.log | grep "Accepted" | awk -F'for ' '{print $2}' | awk '{print $1}' | head -n 1
