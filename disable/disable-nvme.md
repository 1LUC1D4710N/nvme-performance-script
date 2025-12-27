# NVMe Registry Enhancement - DISABLE GUIDE

## Overview

This guide safely removes the native NVMe driver optimizations and reverts to the default SCSI emulation driver (`StorNVMe.sys`) on Windows 11/Server 2025.

**Use this guide if:**
- ✅ You experience driver conflicts or performance issues
- ✅ You want to revert to default Windows driver stack
- ✅ You need to troubleshoot NVMe-related problems
- ✅ You're uninstalling NVMe optimizations

---

## 📥 QUICK DOWNLOAD

Choose your preferred method:

| Method | File | What It Does |
|--------|------|-------|
| **PowerShell Script** | `disable-nvme.ps1` | Creates Restore Point, removes all 4 Class IDs, reverts to default |
| **Registry File** | `disable-nvme.reg` | Directly removes Class IDs from registry |

Both files are pre-configured and ready to use.

---

## CRITICAL PREREQUISITE: Create System Restore Point

**⚠️ BEFORE APPLYING ANY CHANGES - DO THIS FIRST:**

### Creating a System Restore Point (Windows 11/Server 2025)

**Method 1: GUI (Easiest)**
1. Press `Win+R`, type `rstrui.exe`, press Enter
2. Click "Create a restore point..."
3. Select your system drive (usually C:)
4. Click "Create..." button
5. Name it: `NVMe-Before-Removal` or similar
6. Click "Create"
7. Wait for completion (1-2 minutes)
8. Click "Close"

**Method 2: PowerShell (Automated)**
```powershell
# Run as Administrator
Checkpoint-Computer -Description "NVMe-Before-Removal" -RestorePointType "MODIFY_SETTINGS"
Write-Host "System Restore Point Created Successfully"
```

---

## Registry Path
```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides
```

---

## CLASS ID REFERENCE (Being Removed)

| Class ID | Name | Status |
|----------|------|--------|
| 1176759950 | Primary Native NVMe | REMOVING |
| 1853569164 | Enhancement 1 | REMOVING |
| 156965516 | Enhancement 2 | REMOVING |
| 735209102 | Enhancement 3 (KEY) | REMOVING |

---

## Next Steps

**Need to enable again?** → Go back to [Enable Guide](../enable/enable-nvme.md)

**Everything working properly?** → Proceed to [Cleanup Guide](../cleanup/cleanup-nvme.md)
