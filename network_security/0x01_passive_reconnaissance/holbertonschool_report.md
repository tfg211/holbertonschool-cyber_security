# Passive Reconnaissance Report
## Target: holbertonschool.com

---

## 1. Introduction

This report documents passive reconnaissance performed on the domain
**holbertonschool.com** using the Shodan search engine.
All information was collected without any active scanning or interaction
with the target systems.

---

## 2. IP Addresses and Ranges

Based on Shodan results, the following IP addresses are associated with
holbertonschool.com and its subdomains:

- 35.180.27.154
- 52.47.143.83

### Autonomous System Information

- Provider: Amazon Web Services (AWS)
- Service: EC2
- Region: France (Paris)

These findings indicate that holbertonschool.com is hosted on cloud
infrastructure provided by AWS.

---

## 3. Discovered Subdomains

The following subdomains were identified through passive reconnaissance:

- holbertonschool.com
- www.holbertonschool.com
- yriry.holbertonschool.com

The subdomain **yriry.holbertonschool.com** appears to host a Level 2 forum.

---

## 4. Technologies and Frameworks

The analysis of Shodan data revealed the following technologies in use:

### Web Servers
- Nginx (Ubuntu)

### Cloud Infrastructure
- Amazon Web Services (EC2)

### Security and Networking
- TLS 1.2
- TLS 1.3
- SSL certificates issued by Let's Encrypt

### HTTP Behavior
- HTTP 301 Moved Permanently redirects
- Ports exposed: 80 (HTTP), 443 (HTTPS)

---

## 5. Conclusion

Passive reconnaissance using Shodan provided valuable insight into the
infrastructure of holbertonschool.com.
The domain relies on AWS cloud services, uses modern encryption standards,
and is protected by HTTPS.
Multiple subdomains were identified, each serving different purposes.

---

## 6. Tools Used

- Shodan (https://www.shodan.io)
