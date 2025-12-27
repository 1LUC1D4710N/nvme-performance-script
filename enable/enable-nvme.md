# NVMe Registry Enhancement - ENABLE GUIDE

## 🚀 Quick Overview

This guide enables the **Native NVMe driver stack** on Windows 11/Server 2025, potentially improving NVMe SSD performance and responsiveness. The Native NVMe driver (`nvmedisk.sys`) provides direct hardware access compared to the default SCSI emulation driver (`StorNVMe.sys`).

**What you'll get:**
- ✅ Native NVMe driver implementation (direct hardware access)
- ✅ Potential performance improvements for NVMe SSDs
- ✅ Better thermal management and responsiveness
- ✅ Support for advanced NVMe features
- ✅ System Restore Point for instant rollback if needed

---

## 📥 QUICK DOWNLOAD

Choose your preferred method:

| Method | File | Download | What It Does | Sources |
|--------|------|----------|--------------|----------|
| **PowerShell Script** | `enable-nvme.ps1` | [⬇️ Download PS1](enable-nvme.ps1) | Creates System Restore Point, adds all 4 Class IDs, guides restart | Microsoft Tech Community, Windows Forums, Reddit, PC Gamer, Tom's Hardware, TechPowerUp, NotebookCheck |
| **Registry File** | `enable-nvme.reg` | [⬇️ Download REG](enable-nvme.reg) | Directly adds Class IDs 1176759950, 1853569164, 156965516, 735209102 | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |

**Class IDs Added:**
- ✅ **1176759950** - Primary Native NVMe (Microsoft Official)
- ✅ **1853569164** - Enhancement 1 (Community)
- ✅ **156965516** - Enhancement 2 (Community)
- ✅ **735209102** - Enhancement 3 KEY (Community)

Both files are pre-configured and ready to use. Download one, save to Desktop, and run as Administrator.

---

## CRITICAL PREREQUISITE: Create System Restore Point

**⚠️ BEFORE APPLYING ANY CHANGES - DO THIS FIRST:**

Before applying any of the scripts below, you **MUST** create a System Restore Point. This allows you to roll back all changes instantly if something goes wrong.

### Creating a System Restore Point (Windows 11/Server 2025)

**Method 1: GUI (Easiest)**
1. Press `Win+R`, type `rstrui.exe`, press Enter
2. Click "Create a restore point..."
3. Select your system drive (usually C:)
4. Click "Create..." button
5. Name it: `NVMe-Before-Registry-Changes` or similar
6. Click "Create"
7. Wait for completion (1-2 minutes)
8. Click "Close"

**Method 2: PowerShell (Automated)**
```powershell
# Run as Administrator - Creates restore point automatically
Checkpoint-Computer -Description "NVMe-Before-Registry-Changes" -RestorePointType "MODIFY_SETTINGS"
Write-Host "System Restore Point Created Successfully"
```

**Method 3: Command Prompt (Alternative)**
```cmd
wmic.exe /namespace:\\root\default path SystemRestore Call CreateRestorePoint "NVMe-Before-Registry-Changes", 12, 7
```

**Why This Matters:**
If the scripts cause any issues (boot failure, driver conflicts, BitLocker activation), you can instantly restore your system to this exact point without needing to reinstall Windows or recover from backup.

---

## Registry Path (Location for All Scripts)
```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides
```

---

# CLASS ID REFERENCE

| Class ID | Name | Source | Official? | For Windows |
|----------|------|--------|-----------|-------------|
| 1176759950 | Primary Native NVMe | Microsoft Tech Community | ✅ YES | Server 2025 |
| 1853569164 | Enhancement 1 | Windows Forums, Reddit | ❌ NO | 11 25H2 |
| 156965516 | Enhancement 2 | Deskmodder, Heise | ❌ NO | 11 25H2 |
| 735209102 | Enhancement 3 (KEY) | PC Gamer, Tom's Hardware | ❌ NO | 11 25H2 |

---

## Next Steps

**Everything working well?** → Continue to the Disable guide for removal instructions when needed

**[📖 Go to Disable Guide](../disable/disable-nvme.md)**

The Disable guide covers how to safely remove NVMe enhancements if you experience issues or want to revert to the default SCSI driver stack.
