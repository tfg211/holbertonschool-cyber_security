# Active Directory - Enumeration & Credential Abuse

## 📌 Introduction

This project maps out the offensive reconnaissance and credential exploitation lifecycle within an Active Directory (AD) enterprise domain. Moving beyond basic structural layouts, this module deep-dives into the tactical attack chains executed by real-world red teams and sophisticated threat actors.

By systematically mapping users, groups, computer objects, and access policies, we identify and exploit structural cryptographic flaws and configuration blind spots. From abusing Kerberos pre-authentication mechanics (**AS-REP Roasting**) to decrypting credentials offline, this repository details how minor directory misconfigurations lead to privilege escalation and data exposure.

---

## 🎯 Why It Matters

Enumeration is the bedrock of every successful Active Directory compromise. Before an adversary can establish lateral movement or domain dominance, they must build a map of the target terrain: tracking who holds explicit permissions, identifying which service entries are exposed, and isolating accounts lacking default security mitigations.

Techniques like **AS-REP Roasting**, **Kerberoasting**, and **DCSync** are not academic abstractions; they populate modern ransomware post-mortems and security breach logs daily. Mastering these vectors equips security professionals with the exact insights required to spot malicious traffic early, design ironclad identity boundaries, and perform thorough, realistic adversary simulations.

---

## 🧠 Learning Objectives

By completing this module, the following specialized enterprise security competencies are mastered without external assistance:

* **Advanced AD Discovery:** Crafting custom directory queries to harvest targets, active structures, domain trusts, and Group Policy layouts.
* **Kerberos Cryptographic Abuse:** Understanding structural weaknesses in target pre-authentication properties to selectively request crackable hashes.
* **Offline Hash Analysis:** Manipulating high-throughput cracking arrays (`hashcat`) to recover plaintext credentials from domain cryptographic tokens.
* **AD Attribute Parsing:** Querying protected directory objects natively via custom LDAP filter variables.
* **Behavioral Detection Indicators:** Interpreting security logs to isolate anomalous authentication requests and active enumeration footprints.

---

## 🛠️ Lab Infrastructure & Target Blueprint

The validation lab mimics an isolated corporate subnet, forcing an assumed-breach scenario where initial system access must be won entirely through active exploitation.

```
                      [ Host Virtual Network ]
                                 │
            ┌────────────────────┴────────────────────┐
            ▼                                         ▼
   ┌─────────────────┐                       ┌─────────────────┐
   │   Kali Linux    │  ───[AS-REP Roast]──>  │ Windows Server  │
   │   (Attacker)    │                       │      2019       │
   └─────────────────┘                       │ (Domain Control)│
            │                                └─────────────────┘
            │                                         ▲
       [Monitoring]                                [Trust]
            │                                         │
            └───────────> ┌─────────────────┐ ────────┘
                          │   Windows 11    │
                          │ (Victim Domain  │
                          │   Workstation)  │
                          └─────────────────┘

```

### Lab Specifications & Initial Access

* **Attacker System:** Kali Linux (loaded with exploitation tools and cracking hardware interfaces).
* **Workstation Asset:** Windows 11 Enterprise (simulating a standard enterprise victim host).
* **Target Domain Controller:** Windows Server 2019 (hosting Active Directory Domain Services).
* **Global Access Verification Credentials:** * **Username:** `student`
* **Password:** `Str0ngPass!2026`



> [!NOTE]
> Testing requirements dictate that the Domain Controller credentials are **not** provided directly. Access must be systematically achieved via Kali Linux through active network enumeration and tactical asset exploitation.

### Core Attack Toolkit

* **Impacket Suite:** Dedicated python network protocol structures (`GetNPUsers.py`, `secretsdump.py`).
* **Responder:** Internal Link-Local Multicast Name Resolution (LLMNR) and NetBIOS poisoner.
* **Hashcat:** Advanced, multi-threaded rule-based password cracking engine.
* **Metasploit Framework:** Post-exploitation orchestration console (`msfconsole`).
* **Native Tooling:** Direct directory parsers (`ldapsearch`).

---

## 📂 Repository Layout

```
holbertonschool-cyber_security/
└── Active_directory/
    └── 0x02-AD_Enumeration_attack/
        └── 0-flag.txt

```

---

## ⚡ Active Attack Configurations & Tasks

### Task 0: AS-REP Roasting (Privilege Escalation & Data Extraction)

#### Description & Mechanics

In standard Active Directory setups, Kerberos pre-authentication is enforced by default. This security layer requires an account to encrypt a timestamp using its password hash before requesting a Ticket Granting Ticket (TGT), preventing offline guessing attacks.

However, if an administrator sets the `DONT_REQ_PREAUTH` flag on an account, any network actor can request an AS-REP authentication token from the Domain Controller without proving identity. This token contains a ticket segment encrypted with the user's master key, which can be harvested and targeted via brute-force attacks offline.

```
[ Attacker ] ──( 1. Requests AS-REP without Preauth )──> [ Domain Controller ]
[ Attacker ] <──( 2. Receives Encrypted AS-REP Token )─── [ Domain Controller ]
[ Attacker ] ──( 3. Offline Dictionary Attack )────────> Plaintext Password!

```

#### Operational Lifecycle Execution

1. **Target Identification:** Enumerate accounts within the domain target space to isolate objects matching the `DONT_REQ_PREAUTH` description flag using Impacket:
```bash
impacket-GetNPUsers -dc-ip 192.168.56.100 -request -format hashcat domain.local/

```


2. **Hash Harvesting:** Extract the valid `$krb5asrep$` token for the vulnerable user without providing authentication credentials.
3. **Offline Cracking Phase:** Route the raw cryptographic string directly into `hashcat` applying the `rockyou.txt` wordlist engine under specialized Kerberos profiles:
```bash
hashcat -m 18200 extracted_asrep.txt rockyou.txt

```


4. **Authenticated LDAP Query:** Leverage the newly recovered user credentials to authenticating directly back into the LDAP directory engine. Explicitly query standard and non-standard properties—specifically targeting the protected `comment` field—to retrieve the hidden administrative flag.

#### Deliverable Path

* **File Containing Extracted Flag:** `Active_directory/0x02-AD_Enumeration_attack/0-flag.txt`

---

## ⚙️ Coding & Workspace Standards

* **Editing Interfaces:** Modification of configuration variables, command paths, or documentation is handled using terminal interfaces (`vi`, `vim`, `emacs`).
* **POSIX Validation:** Every file and data string compiled across this workspace finishes with an explicit trailing newline character (`\n`) to prevent pipeline evaluation truncation errors.

---

## ⚠️ Defensive Architecture Highlight

> [!IMPORTANT]
> To defend enterprise domains against AS-REP Roasting vectors, system administrators must enforce strict account configurations:
> 1. **Audit Pre-Authentication:** Periodically audit the directory database to ensure no user accounts have the `Do not require Kerberos preauthentication` flag enabled.
> 2. **Enforce Password Complexity:** Implement strong, long password policies to ensure that even if an AS-REP token is exposed, it remains mathematically unfeasible to crack offline.
> 3. **Monitor Authentication Volume:** Track excessive, unauthenticated TGT requests pointing to single user profiles to quickly flag active roasting attempts.
> 
> 

---

## ⚠️ Disclaimer

> [!WARNING]
> This repository is maintained strictly for ethical hacking education, academic lab compliance, and approved penetration testing validation. Targeting corporate infrastructure or processing external network assets without clear, written organizational consent is strictly illegal.
