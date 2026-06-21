# Active Directory - PowerView Reconnaissance & Hardening

## 📌 Introduction

A true understanding of Active Directory security requires looking through two lenses simultaneously: the **attacker** looking for the path of least resistance, and the **defender** structuralizing walls to break that path.

This project-based module deep-dives into **PowerView**, an industry-standard PowerShell-based reconnaissance tool used to query Active Directory domain environments with speed and precision. Moving past basic graphical management tools, this repository documents how an operator queries underlying LDAP directories to discover hidden permission flaws, over-privileged accounts, and vulnerable trust configurations.

Crucially, the module balances this offensive approach with enterprise-grade **Defensive Hardening**: leveraging Group Policy Objects (GPOs), deploying Windows **LAPS** (Local Administrator Password Solution), and enforcing least-privilege models to close the very security gaps PowerView uncovers.

---

## 🎯 Why It Matters

PowerView is a diagnostic lens that shows you exactly what a malicious actor sees upon establishing an initial network foothold. Security teams that understand PowerView queries can proactively audit their own identity environments, neutralizing dangerous Access Control Lists (ACLs) and weak GPO mappings before an incident occurs.

When paired with modern defenses like LAPS, strict administrative segmentation, and robust event auditing, the skills practiced here directly map to the operational blueprints used by mature enterprises to defend their directory infrastructures.

---

## 🧠 Learning Objectives

By the completion of this module, the following advanced directory engineering and auditing concepts are thoroughly mastered without external assistance:

* **PowerShell Directory Interrogation:** Understanding how PowerView wraps complex .NET framework functions and native LDAP queries to parse Active Directory objects via the command line.
* **Object Enumeration:** Extracting raw data structures tracking active domain users, nested groups, domain-joined computers, and Domain Controllers.
* **ACL & Security Descriptor Analysis:** Identifying dangerous object permissions—such as `GenericAll`, `WriteDacl`, and `GenericWrite`—that allow non-administrative users to control other objects.
* **Group Policy Auditing:** Querying GPOs to extract security configurations and locate misapplied local rights.
* **Trust & Pivot Mapping:** Identifying trust boundaries between separate domains and forests to spot opportunities for lateral movement.
* **Target Hunting:** Finding user accounts vulnerable to cryptographic extraction attacks, such as **Kerberoasting** and **AS-REP Roasting**, directly through PowerShell filters.

---

## 🛠️ Lab Architecture & Testing Environment

The operations are conducted across a multi-node enterprise lab segment. While offensive auditing occurs directly on a domain-joined victim workstation, the ultimate objective is mapping the security boundaries protecting the central Domain Controller.

```
                      [ Isolated Laboratory Network ]
                                     │
         ┌───────────────────────────┼───────────────────────────┐
         ▼                           ▼                           ▼
┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│   Kali Linux    │         │   Windows 11    │         │ Windows Server  │
│  (Attacker OS)  │         │ (bh_intern Node)│         │      2019       │
└─────────────────┘         └─────────────────┘         │(Domain Controller)
                             [PowerView Engine]         └─────────────────┘

```

### Virtual Machine Configurations

* **Attacker Machine:** Kali Linux (monitoring network patterns and framework communication).
* **Workstation Asset:** Windows 11 Enterprise (the direct testing station containing the pre-installed PowerView auditing environment).
* **Domain Infrastructure Host:** Windows Server 2019 (the targeted production Domain Controller).

### Initial Access Profiling

* **Target Workstation Domain Account:** `bh_intern`
* **Authentication Token:** `User@2025!`

---

## 💻 PowerView Operational Workflow

To begin auditing the Active Directory environment from the Windows 11 workstation, you must bypass the local script restrictive policies and load the tool into your current shell process memory.

### 1. Execution Policy Bypass

Open a PowerShell terminal and lower the execution restrictions for your active process scope:

```powershell
Set-ExecutionPolicy Bypass -Scope Process

```

### 2. Loading the PowerView Module

Dot-source the script file to map all structural cmdlets directly into your operational environment:

```powershell
. .\PowerView.ps1

```

### 3. Essential PowerView Audit Cheat Sheet

| Objective | PowerView Cmdlet Syntax |
| --- | --- |
| **Get Domain Details** | `Get-NetDomain` |
| **Enumerate Users** | `Get-NetUser |
| **List Domain Groups** | `Get-NetGroup` |
| **Audit Object ACLs** | `Get-ObjectAcl -SamAccountName "TargetUser"` |
| **Find Local Admin Access** | `Find-LocalAdminAccess` |
| **Map Domain Trusts** | `Get-NetDomainTrust` |
| **Identify Kerberoastable Targets** | `Get-NetUser -SPN` |

---

## 🛡️ Defensive Hardening Matrix (Remediation)

To counter the wide-reaching situational awareness PowerView gives an attacker, the following defensive configurations are systematically analyzed and implemented:

> [!IMPORTANT]
> ### 🔑 1. Windows LAPS Deployment
> 
> 
> In unhardened environments, local administrator accounts often reuse identical passwords across all workstations. If one machine is compromised, the attacker can use those credentials to move laterally across the entire network. Windows LAPS resolves this by automatically generating a unique, complex password for each computer's local administrator account and storing it securely within a protected attribute in Active Directory.
> ### 📜 2. Least-Privilege Administrative Models
> 
> 
> Admin accounts must be restricted to explicitly defined operational zones:
> * **Tier 0:** Domain Controllers and critical identity services.
> * **Tier 1:** Enterprise servers and production storage systems.
> * **Tier 2:** User workstations and endpoint devices.
> *Administrative credentials from Tier 0 must never be entered on or cached by lower-tier assets, cutting off lateral privilege escalation paths.*
> 
> 
> ### 🚫 3. Legacy Protocol Decommissioning
> 
> 
> Legacy transport layers like **SMBv1** are completely disabled across the domain infrastructure to block automated credential coercion and remote code execution vulnerabilities.

---

## ⚙️ Development & Formatting Guidelines

* **Authoring Environment:** Development of documentation, notes, and local environment adjustments are handled via terminal-native editors (`vi`, `vim`, `emacs`).
* **POSIX Formatting:** Every text file and code logging asset maintained inside this repository ends with a clean trailing newline character (`\n`) to ensure consistent parsing across multi-platform terminals.

---

## ⚠️ Disclaimer

> [!WARNING]
> This repository is developed and maintained strictly for authorized security auditing, professional certification preparation, and academic lab tracking. Executing automated domain queries or auditing production networks without explicit, written legal consent from system administrators is strictly prohibited.
