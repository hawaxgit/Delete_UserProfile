# 🗑️ User Profile Deletion Tool

> **Enterprise IT Toolset** — Local user account deletion with profile cleanup for Windows environments.

---

## 📋 Overview

A lightweight Windows Batch script designed for **IT support teams** in corporate environments.  
It lists all local user profiles from `C:\Users`, lets you select a user by number, and deletes both the **Windows account** and the **profile folder** — with confirmation prompt and automatic logging.

---

## ℹ️ Script Info

| Field       | Details                                      |
|-------------|----------------------------------------------|
| **Author**  | Soroush @ Hawax                              |
| **Dept.**   | IT/OT AllRounder                             |
| **Version** | 2.0                                          |
| **Created** | 16.12.2025                                   |
| **Updated** | 19.03.2026                                   |
| **OS**      | Windows 10 / Windows 11                      |
| **Requires**| Administrator privileges                     |

---

## ✨ Features

- ✅ Lists all real user profiles from `C:\Users` (system folders excluded)
- ✅ Select user by number — no typing usernames manually
- ✅ Shows account details before deletion
- ✅ Double confirmation required (`JA` must be typed)
- ✅ Deletes both the **local Windows account** and the **profile folder**
- ✅ Blocks deletion of built-in system accounts (`Administrator`, `SYSTEM`, `Guest`, etc.)
- ✅ Automatic **logging** to `UserDeletion_Log.txt`
- ✅ Admin privilege check on startup

---

## 🚀 Usage

### Option 1 — Right-click
Right-click `Delete_UserProfile.bat` → **"Run as Administrator"**

### Option 2 — Command Prompt (as Admin)
```cmd
Delete_UserProfile.bat
```

---

## 🖥️ How It Works

```
  ============================================================
   Author  : Soroush @ Hawax
   Dept.   : IT/OT AllRounder  
   Version : 2.0
   Purpose : Local User Account Deletion Tool
   NOTE    : Must be run with Administrator privileges.
  ============================================================

  [OK] Administratorrechte erkannt.

  ============================================================
   Verfuegbare Benutzerprofile in C:\Users
  ============================================================

     [1]  MaxMustermann
     [2]  JSmith
     [3]  ITAdmin

  Nummer des zu loeschenden Benutzers eingeben (oder 0 zum Beenden): 1

  ============================================================
   BESTAETIGUNG
  ============================================================

   Ausgewaehlter Benutzer : MaxMustermann
   Profilpfad             : C:\Users\MaxMustermann

  [WARNUNG] Das lokale Konto und das Profil werden geloescht.
            Dieser Vorgang kann nicht rueckgaengig gemacht werden!

  Zum Bestaetigen JA eingeben: JA

  [ERFOLG] Benutzer "MaxMustermann" wurde erfolgreich geloescht.
```

---

## 📁 Files

```
📁 Repository
├── Delete_UserProfile.bat     ← Main script
├── UserDeletion_Log.txt       ← Auto-generated log (created on first run)
└── README.md
```

---

## 📝 Log File

Every deletion attempt is automatically logged to `UserDeletion_Log.txt` in the same folder as the script.

**Log format:**
```
[DD.MM.YYYY HH:MM:SS] [ERFOLG] Host: PC-NAME - Operator: ITAdmin - Benutzer: "MaxMustermann"
[DD.MM.YYYY HH:MM:SS] [FEHLER] Host: PC-NAME - Operator: ITAdmin - Benutzer: "DomainUser"
```

---

## 🛡️ Safety Features

| Protection | Details |
|---|---|
| **Admin check** | Script exits immediately if not run as Administrator |
| **System account block** | `Administrator`, `SYSTEM`, `Guest`, `Default`, `Public`, `All Users` cannot be deleted |
| **Confirmation required** | User must type `JA` exactly to confirm deletion |
| **Domain account warning** | Shows error if account is not a local account or is currently logged in |

---

## ⚠️ Important Notes

> **This action is irreversible.**  
> Once a user account and its profile folder are deleted, the data cannot be recovered without a backup.

- Only **local accounts** can be deleted with this tool. Domain accounts must be managed via Active Directory.
- The user **must not be currently logged in** at the time of deletion.
- Always ensure a **data backup** exists before deleting a profile.

---

## 📄 License

For internal IT use only 
