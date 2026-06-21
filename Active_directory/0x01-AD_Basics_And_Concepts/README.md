# Active Directory - Fundamentals

## 🎯 Project Overview

This repository contains the practical implementations, reconnaissance findings, and exploitation logs for the **Active Directory Fundamentals** module.

Active Directory (AD) serves as the identity and access management backbone for over 90% of enterprise environments globally, making it the premier target for modern cyberattacks. This project transitions from the structural basics of Domains and Domain Controllers to advanced enumeration and misconfiguration abuse within Users, Groups, and Group Policy Objects (GPOs).

---

## 💡 Why This Matters

From ransomware operators to nation-state threat actors, adversaries target Active Directory to rapidly escalate privileges, establish persistence, and execute domain-wide compromises.

Understanding AD architecture isn't just an administrative skill—it is an absolute prerequisite for effective Red Team operations and Assumed-Breach simulations. This project documents the mindset of an adversary mapping internal network structures, abusing trust boundaries, and targeting identity misconfigurations from an external attacker position.

---

## 🧠 Learning Objectives

By the conclusion of this project, the following core infrastructure and directory service mechanisms are mastered:

* **Active Directory Architecture:** The design and hierarchical boundaries of Domains, Forests, Trees, and Organizational Units (OUs).
* **Identity Management:** Deep technical understanding of **Authentication** (who you are) versus **Authorization** (what you can access).
* **Directory Enumeration:** Querying databases and directory information services natively via **LDAP (Lightweight Directory Access Protocol)**.
* **The Domain Controller (DC):** The function of the engine hosting the Active Directory Domain Services (AD DS) database, handling Kerberos/NTLM authentication requests.

---

## 🛠️ Lab Architecture & Environment Setup

The attack lifecycle is executed within an isolated host-only lab environment comprising three core nodes:

```
                  [ Host Network ]
                         │
        ┌────────────────┴────────────────┐
        ▼                                 ▼
┌───────────────┐                 ┌───────────────┐
│  Kali Linux   │  ──[Attack]──>  │Windows Server │
│  (Attacker)   │                 │     2019      │
└───────────────┘                 │  (Domain Ctrl)│
        │                         └───────────────┘
        │                                 ▲
     [Audit]                           [Trust]
        │                                 │
        └─────────> ┌───────────────┐ ────┘
                    │  Windows 11   │
                    │   (Victim Work│
                    │    station)   │
                    └───────────────┘

```

### Virtual Machine Configurations

* **Attacker Machine:** Kali Linux (all exploitation, enumeration, and scanning scripts originate here).
* **Victim Workstation:** Windows 11 Enterprise (simulates user target workspace).
* **Target Environment:** Windows Server 2019 (acting as the functional Domain Controller).

> [!NOTE]
> All Windows Virtual Machines utilize standard pre-configured provisioning profiles imported directly as-is, connected to an identical host-only or isolated network segment to prevent internal traffic bleed-out.

### Remote Access Protocol

Initial administrative verification uses **WinRM** over secure channels from Kali Linux:

* **Username:** `labuser`
* **Password:** `P@ssw0rd123!`

---

## 🔑 Core Cryptographic & Directory Mechanisms

| Terminology | Structural Definition | Security Relevance |
| --- | --- | --- |
| **Authentication** | Validates identity tokens (e.g., Kerberos tickets, NTLM challenge-response). | Primary target for credential dumping and spraying attacks. |
| **Authorization** | Evaluates Access Control Entries (ACEs) inside Security Descriptors. | Exploited via permission inheritance issues and weak ACL configurations. |
| **LDAP** | Protocol utilized to query and modify directory service objects. | Open source mapping technique allowing massive internal domain discovery. |
| **Domain Controller** | The server executing authentication validations and storing the `ntds.dit` file. | The ultimate objective of an internal domain compromise. |

---

## 📂 Project Tasks & Repository Structure

### Directory Blueprint

```
holbertonschool-cyber_security/
└── Active_directory/
    └── 0x01-AD_Basics_And_Concepts/
        └── 0-flag.txt

```

### Task 0: Domain Reconnaissance: Extracting Core Domain Information

* **Objective:** Query the Active Directory root domain object using explicit attribute lookups to find a hidden flag injected into a non-standard domain property field.
* **Methodology:** Standard directory searches restrict lookups to common operational attributes. Locating this flag requires structural enumeration techniques that force the directory server to pass custom or extended properties.
* **Deliverable:** * Path: `Active_directory/0x01-AD_Basics_And_Concepts/0-flag.txt`
* Format: Contains the exact plaintext flag extracted from the directory lookup.



---

## 💻 Execution Standards

* **Coding Environment:** All manual lookups, custom automated automation chains, or notes are authored strictly utilizing clean textual interfaces (`vi`, `vim`, `emacs`).
* **POSIX Compliance:** To ensure continuous processing and parsing by Linux/Unix text manipulators, all text documents and script payloads structurally maintain a trailing newline character (`\n`).

---

## ⚠️ Disclaimer

> [!WARNING]
> This repository is maintained strictly for ethical hacking education, professional certification preparation, and authorized internal security assessments. Targeting systems without prior formal permission is strictly prohibited by law.
