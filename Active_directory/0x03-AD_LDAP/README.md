# Active Directory - LDAP Enumeration & Domain Analysis

## 📌 Introduction

Active Directory (AD) serves as the central nervous system for enterprise networks, managing identities, access, and security policies across global environments. Because it binds an entire corporate infrastructure together, it is the highest-value target for adversaries seeking total network dominance.

This project explores the core directory services protocol that powers AD: the **Lightweight Directory Access Protocol (LDAP)**. Moving past standalone endpoint auditing, this module focuses on mapping domain structures, hunting for Service Principal Names (SPNs), exploiting implicit trusts, and exposing misconfigurations in protocols like Kerberos and NTLM.

---

## 🎯 Why It Matters

During an internal network assessment, an operator's focus shifts from exploiting single software bugs to abusing the trust relationships inherent in identity management. Techniques such as **Kerberoasting**, **Pass-the-Hash (PtH)**, **LLMNR Poisoning**, and **Golden Ticket generation** are heavily relied upon by real-world threat groups because they turn legitimate network features into exploitation paths.

Understanding how to query directory infrastructure safely and identifying exposures like unauthenticated LDAP binds is the first line of defense in protecting modern enterprise landscapes.

---

## 🧠 Learning Objectives

By completing this project, the following architectural and offensive concepts are mastered without external assistance:

* **AD Infrastructure Mapping:** Defining the organizational boundaries of Domains, Forests, Domain Controllers (DCs), and cross-environment Trust Relationships.
* **LDAP & Object Properties:** Interrogating directory databases natively to map out user schemas, organizational units (OUs), and custom attributes.
* **Service Principal Names (SPNs):** Understanding the role of SPNs in Windows environments and how they bridge services to underlying Active Directory user accounts.
* **Kerberos Subversion:** Breaking down the core ticket-granting pipeline to execute and defend against **Kerberoasting** and **Golden Ticket** persistence attacks.
* **NTLM & LLMNR Exploitation:** Capitalizing on backward-compatible fallback protocols via Pass-the-Hash (PtH) and network name resolution poisoning.

---

## 🛠️ Lab Architecture & Target Blueprint

The validation lab builds on the previous **Active Directory - Fundamentals** architecture, deploying multiple virtual nodes tied to an identical, isolated network segment.

```
                      [ Isolated Host Network ]
                                  │
             ┌────────────────────┴────────────────────┐
             ▼                                         ▼
    ┌─────────────────┐                       ┌─────────────────┐
    │   Kali Linux    │  ──(Anon LDAP Bind)─> │ Windows Server  │
    │   (Attacker)    │                       │      2019       │
    └─────────────────┘                       │ (Domain Control)│
             │                                └─────────────────┘
             │                                         ▲
       [Audit Engine]                               [Trust]
             │                                         │
             └───────────> ┌─────────────────┐ ────────┘
                           │   Windows 11    │
                           │ (Victim Domain  │
                           │   Workstation)  │
                           └─────────────────┘

```

### Lab Requirements & Environment Policy

* **Attacker System:** Kali Linux (the dedicated station for all programmatic scans and queries).
* **Workstation Asset:** Windows 11 Enterprise (simulating an authenticated enterprise domain user endpoint).
* **Target Environment:** Windows Server 2019 (acting as the core, functional Domain Controller).
* **Constraint:** Per testing guidelines, credentials to the Domain Controller are **not provided directly**. Initial network mappings must be established exclusively through unauthenticated enumeration, zeroing in on open directory configurations.

### Required Toolbelt

* **Directory Enumeration:** `ldapsearch`
* **Network Interrogation:** `crackmapexec` / `NetExec`

---

## 📂 Repository Structure

```
holbertonschool-cyber_security/
└── Active_directory/
    └── 0x03-AD_LDAP/
        └── 0-flag.txt

```

---

## ⚡ Active Attack Configurations & Tasks

### Task 0: Basic LDAP Enumeration (Anonymous Directory Binding)

#### Description & Mechanics

By default, LDAP directories should reject queries that lack valid cryptographic tokens or domain credentials. However, due to legacy system requirements or administrative misconfigurations, some Domain Controllers permit partial directory evaluation via an **Anonymous Bind**. This allows unauthenticated external network actors to query internal schemas and glean structural infrastructure intelligence.

```
[ Attacker ] ──( 1. Unauthenticated Anonymously Bound Query )──> [ Domain Controller ]
[ Attacker ] <──( 2. Exposed Schema & Custom Attributes )─────── [ Domain Controller ]

```

#### Operational Execution Plan

1. **Target Verification:** Run a connection check against the Domain Controller to determine if port `389` (LDAP) is reachable from the Kali Linux system.
2. **Anonymous Query Execution:** Use `ldapsearch` without authenticating identifiers (`-D` and `-w` flags omitted) to initiate a blank connection string directly against the target domain endpoint.
3. **Targeted Filtering:** Focus queries specifically on the custom project organizational unit: `OU=LDAP-Project`.
4. **Attribute Harvesting:** Deep-dive into standard object layouts, paying close attention to non-standard, custom property fields to discover the exposed flag string hidden inside a custom user attribute.

#### Deliverable Path

* **File Containing Extracted Flag:** `Active_directory/0x03-AD_LDAP/0-flag.txt`

---

## ⚙️ Workspaces & Execution Standards

* **Editing Interfaces:** Modification of configuration variables, command structures, or documentation is handled using terminal interfaces (`vi`, `vim`, `emacs`).
* **Operational Auditing:** Maintain clean step-by-step screenshots of all commands executed in Kali Linux to serve as a verifiably sound tactical log for compliance audits.
* **POSIX Rules:** Every script, flag file, and textual document compiled across this repository finishes with a trailing newline character (`\n`) to preserve stream manipulation integrity.

---

## 🔒 Defensive Architecture (Remediation)

> [!IMPORTANT]
> To defend enterprise directories against unauthenticated schema enumeration, administrators must enforce strict access security rules on the Domain Controller:
> 1. **Disable Anonymous LDAP Binds:** Enforce server compliance configurations by modifying registry variables or group policy rules to explicitly reject null directory requests (`DsHeuristics` configuration adjustments).
> 2. **Require LDAP Signing and Channel Binding:** Mandate LDAP over TLS/SSL (LDAPS on port `636`) to protect directory traffic from interception and prevent cleartext token extraction across corporate subnets.
> 3. **Sanitize Object Attributes:** Regularly audit custom schema attributes to ensure sensitive, production, or testing flags are never stored in plaintext within globally readable fields.
> 
> 

---

## ⚠️ Disclaimer

> [!WARNING]
> This repository is maintained strictly for ethical hacking education, academic lab compliance, and approved defensive infrastructure auditing. Targeting corporate networks or running unauthorized assessment sweeps against target machines without explicit, prior legal consent is strictly prohibited by law.
