# ⚡ Nmap Advanced Port Scans

Welcome to the **Nmap Advanced Port Scans** directory! This folder contains a collection of sophisticated Bash scripts that leverage unconventional TCP flag combinations to perform stealthy reconnaissance and firewall auditing.

## 📌 Overview

Advanced scanning is about understanding the nuances of the TCP/IP stack. By sending "malformed" or unexpected packets (like NULL, FIN, or XMAS), we can observe how a target's stack or firewall reacts, allowing us to map the network even under strict security policies.



## 🗂️ Script Catalog & Features

| Script Name | Scan Type | Description / Use Case |
| :--- | :--- | :--- |
| **`0-null_scan.sh`** | **NULL Scan (`-sN`)** | Sends packets with no flags set. Effective against older service versions and some stateless firewalls. |
| **`1-fin_scan.sh`** | **FIN Scan (`-sF`)** | Uses only the FIN bit. Designed to pass through filters that block SYN packets. |
| **`2-xmas_scan.sh`** | **XMAS Scan (`-sX`)** | Sets FIN, PSH, and URG flags (lighting the packet up "like a Christmas tree"). Used to elicit responses from non-Windows stacks. |
| **`3-maimon_scan.sh`** | **Maimon Scan (`-sM`)** | A specialized scan that uses FIN/ACK flags. It helps identify specific types of BSD-derived systems. |
| **`4-ack_scan.sh`** | **ACK Scan (`-sA`)** | Used to map firewall rulesets rather than find open ports. It determines if a port is "Filtered" or "Unfiltered." |
| **`5-window_scan.sh`** | **Window Scan (`-sW`)** | Similar to ACK scan but examines the TCP Window size field to distinguish between open and closed ports on certain systems. |
| **`6-custom_scan.sh`** | **Custom Flags (`--scanflags`)** | A flexible script that allows setting any combination of TCP flags (URG, ACK, PSH, RST, SYN, FIN) for manual probing. |

## 🛠️ Security Concepts Applied

* **Stealth Techniques:** Using "Inverse Mapping" (where no response implies an open port) to stay under the radar of simple IDS.
* **Firewall Fingerprinting:** Utilizing **ACK scans** to understand whether a firewall is stateful or stateless.
* **TCP RFC Compliance:** Understanding that different Operating Systems (Linux/BSD vs. Windows) handle non-standard TCP packets differently.
* **Evasion & Fragmentation:** Implementing time limits and custom flag combinations to bypass deep packet inspection (DPI).

## 🚀 How to use
Since these scripts modify TCP flags at a low level, they require root privileges:
```bash
chmod +x 2-xmas_scan.sh
sudo ./2-xmas_scan.sh <target_ip>
```

⚠️ Disclaimer All projects in this repository are created for educational purposes as part of the Holberton School curriculum. These advanced scans can be aggressive and easily detected by modern IPS (Intrusion Prevention Systems). Use only on authorized targets.
