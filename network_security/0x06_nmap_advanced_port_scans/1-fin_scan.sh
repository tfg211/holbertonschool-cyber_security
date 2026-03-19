#!/bin/bash
sudo nmap -sF -ff -T2 -p 80,85 $1
