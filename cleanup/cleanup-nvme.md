# NVMe Registry Enhancement - CLEANUP GUIDE

## Overview

This guide provides comprehensive cleanup instructions for NVMe registry optimization files and system configuration after enabling, testing, or disabling native NVMe drivers.

**Use this guide to:**
- ✅ Remove NVMe optimization entries from registry
- ✅ Clean up temporary files and registry debris
- ✅ Reset system to completely default state
- ✅ Remove all traces of NVMe modifications

---

## 📥 QUICK DOWNLOAD

Choose your preferred method:

| Method | File | What It Does |
|--------|------|-------|
| **PowerShell Script** | `cleanup-nvme.ps1` | Complete system cleanup, removes all NVMe registry entries and temporary files |
| **Registry File** | `cleanup-nvme.reg` | Complete registry cleanup, removes all Class IDs |

---

## CRITICAL PREREQUISITE: Create System Restore Point

**⚠️ BEFORE APPLYING ANY CHANGES - DO THIS FIRST:**

### Creating a System Restore Point (Windows 11/Server 2025)

**Method 1: GUI (Easiest)**
1. Press `Win+R`, type `rstrui.exe`, press Enter
2. Click "Create a restore point..."
3. Select your system drive (usually C:)
4. Click "Create..." button
5. Name it: `NVMe-Before-Full-Cleanup` or similar
6. Click "Create"
7. Wait for completion (1-2 minutes)
8. Click "Close"

**Method 2: PowerShell (Automated)**
```powershell
# Run as Administrator
Checkpoint-Computer -Description "NVMe-Before-Full-Cleanup" -RestorePointType "MODIFY_SETTINGS"
Write-Host "System Restore Point Created Successfully"
```

---

## Complete Cleanup Checklist

**File System Cleanup:**
- ☐ Remove downloaded .ps1 scripts
- ☐ Remove downloaded .reg files
- ☐ Remove temporary NVMe optimization files
- ☐ Clear Windows Event Viewer logs (Optional)

**Registry Cleanup:**
- ☐ Remove all Class ID entries (1176759950, 1853569164, 156965516, 735209102)
- ☐ Remove FeatureManagement\Overrides registry key if empty
- ☐ Verify registry is clean

**System Reset:**
- ☐ Revert to default SCSI emulation driver (StorNVMe.sys)
- ☐ Restart system
- ☐ Verify default driver is active

---

## Next Steps

**Want to enable NVMe again?** → Go back to [Enable Guide](../enable/enable-nvme.md)

**Having issues?** → Restore from System Restore Point or refer to [Disable Guide](../disable/disable-nvme.md)
