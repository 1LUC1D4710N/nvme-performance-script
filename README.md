# NVMe Registry Enhancement - ENABLE GUIDE

**Version: 6.4**

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
|--------|------|----------|--------------|---------|
| **PowerShell Script** | `enable-nvme.ps1` | [⬇️ Download PS1](1.%20NVMe%20Performance%20Enable/enable-nvme.ps1) | Creates System Restore Point, adds all 4 Class IDs, guides restart | Microsoft Tech Community, Windows Forums, Reddit, PC Gamer, Tom's Hardware, TechPowerUp, NotebookCheck |
| **Registry File** | `enable-nvme.reg` | [⬇️ Download REG](1.%20NVMe%20Performance%20Enable/enable-nvme.reg) | Directly adds Class IDs 1176759950, 1853569164, 156965516, 735209102 | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |

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

# METHOD 1: POWERSHELL - ENABLE NVMe

## PowerShell - Adding NVMe Registry Entries

**Source Documentation:**
- **Class ID 1176759950:** Microsoft Tech Community (Official announcement, Dec 15, 2025)
- **Class ID 1853569164:** Windows Forums, Reddit r/windows, TechPowerUp (Community-discovered)
- **Class ID 156965516:** Deskmodder, Heise, Windows Forums (Community-discovered)
- **Class ID 735209102:** PC Gamer, Tom's Hardware, VideoCardz, NotebookCheck (Community-discovered)

**Importance Notes:**
- Script 1 is **officially supported by Microsoft** for Windows Server 2025
- Scripts 2-4 are **community-discovered, unsupported** for Windows 11 25H2 (use at own risk)
- All four scripts together enable the complete Native NVMe driver stack

### PowerShell Addition Script (Copy & Paste Ready)

```powershell
# NVMe Native Driver Registry Enhancement - ADDITION
# Run as Administrator
# Creates System Restore Point and applies all registry changes
# Source: Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware, NotebookCheck

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "NVMe Registry Enhancement - ADDITION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'" -ForegroundColor Red
    Exit 1
}

Write-Host "✓ Running as Administrator" -ForegroundColor Green
Write-Host ""

# Step 1: Create System Restore Point
Write-Host "[STEP 1/6] Creating System Restore Point..." -ForegroundColor Yellow
try {
    Checkpoint-Computer -Description "NVMe-Before-Registry-Changes" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
    Write-Host "✓ Restore Point Created Successfully" -ForegroundColor Green
} catch {
    Write-Host "⚠ Warning: Could not create restore point automatically" -ForegroundColor Yellow
    Write-Host "   Error: $_" -ForegroundColor Yellow
    Write-Host "   Continue anyway? (Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -ne "Y" -and $response -ne "y") {
        Write-Host "Script cancelled by user" -ForegroundColor Red
        Exit 1
    }
}

Write-Host ""

# Step 2: Add Registry Entry 1 (Official - Microsoft Server 2025)
Write-Host "[STEP 2/6] Adding Class ID 1176759950 (Microsoft Official)..." -ForegroundColor Yellow
Write-Host "   Source: Microsoft Tech Community (Official)" -ForegroundColor Gray
Write-Host "   Purpose: Primary Native NVMe feature (Windows Server 2025)" -ForegroundColor Gray
try {
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1176759950 /t REG_DWORD /d 1 /f | Out-Null
    Write-Host "✓ Class ID 1176759950 added successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to add Class ID 1176759950" -ForegroundColor Red
    Write-Host "   Error: $_" -ForegroundColor Red
    Exit 1
}

Write-Host ""

# Step 3: Add Registry Entry 2 (Community - Windows 11)
Write-Host "[STEP 3/6] Adding Class ID 1853569164 (Community-Discovered)..." -ForegroundColor Yellow
Write-Host "   Source: Windows Forums, Reddit, TechPowerUp (Unsupported)" -ForegroundColor Gray
Write-Host "   Purpose: NVMe Enhancement Component 1 (Windows 11 25H2)" -ForegroundColor Gray
try {
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1853569164 /t REG_DWORD /d 1 /f | Out-Null
    Write-Host "✓ Class ID 1853569164 added successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to add Class ID 1853569164" -ForegroundColor Red
    Write-Host "   Error: $_" -ForegroundColor Red
    Exit 1
}

Write-Host ""

# Step 4: Add Registry Entry 3 (Community - Windows 11)
Write-Host "[STEP 4/6] Adding Class ID 156965516 (Community-Discovered)..." -ForegroundColor Yellow
Write-Host "   Source: Deskmodder, Heise, Windows Forums (Unsupported)" -ForegroundColor Gray
Write-Host "   Purpose: NVMe Enhancement Component 2 (Windows 11 25H2)" -ForegroundColor Gray
try {
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 156965516 /t REG_DWORD /d 1 /f | Out-Null
    Write-Host "✓ Class ID 156965516 added successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to add Class ID 156965516" -ForegroundColor Red
    Write-Host "   Error: $_" -ForegroundColor Red
    Exit 1
}

Write-Host ""

# Step 5: Add Registry Entry 4 (Community - Windows 11)
Write-Host "[STEP 5/6] Adding Class ID 735209102 (Community-Discovered)..." -ForegroundColor Yellow
Write-Host "   Source: PC Gamer, Tom's Hardware, NotebookCheck, VideoCardz (Unsupported)" -ForegroundColor Gray
Write-Host "   Purpose: NVMe Enhancement Component 3 - KEY (Windows 11 25H2)" -ForegroundColor Gray
try {
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 735209102 /t REG_DWORD /d 1 /f | Out-Null
    Write-Host "✓ Class ID 735209102 added successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to add Class ID 735209102" -ForegroundColor Red
    Write-Host "   Error: $_" -ForegroundColor Red
    Exit 1
}

Write-Host ""

# Step 6: Summary and Restart Prompt
Write-Host "[STEP 6/6] Verification and Restart" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ ALL REGISTRY ENTRIES ADDED" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  • System Restore Point: Created ✓" -ForegroundColor Green
Write-Host "  • Class ID 1176759950: Added ✓ (Microsoft Official)" -ForegroundColor Green
Write-Host "  • Class ID 1853569164: Added ✓ (Community)" -ForegroundColor Green
Write-Host "  • Class ID 156965516:  Added ✓ (Community)" -ForegroundColor Green
Write-Host "  • Class ID 735209102:  Added ✓ (Community)" -ForegroundColor Green
Write-Host ""
Write-Host "⚠ IMPORTANT: You MUST restart your system for changes to take effect!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Restart your computer NOW"
Write-Host "  2. After restart, open Device Manager (devmgmt.msc)"
Write-Host "  3. Check 'Storage disks' - NVMe devices should appear there"
Write-Host "  4. Right-click NVMe device → Properties → Driver"
Write-Host "  5. Verify driver is 'nvmedisk.sys'"
Write-Host ""
Write-Host "To Restart Now, press 'R' and Enter:" -ForegroundColor Yellow
$restart = Read-Host "Restart? (R/N)"
if ($restart -eq "R" -or $restart -eq "r") {
    Write-Host "Restarting in 10 seconds..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    Restart-Computer -Force
} else {
    Write-Host "Remember to restart manually to apply changes!" -ForegroundColor Yellow
}
```

---

# METHOD 2: REGISTRY FILE (.REG) - ENABLE NVMe

## Registry File - Adding NVMe Registry Entries

**Source Documentation:**
- **Class ID 1176759950:** Microsoft Tech Community (Official)
- **Class ID 1853569164:** Windows Forums, Reddit, TechPowerUp (Community)
- **Class ID 156965516:** Deskmodder, Heise, Windows Forums (Community)
- **Class ID 735209102:** PC Gamer, Tom's Hardware, NotebookCheck, VideoCardz (Community)

**Importance of Restore Point:**
Before importing this .REG file, ensure you've created a System Restore Point (see instructions at top of this guide). This allows you to instantly restore if issues occur.

### Step 1: Create the .REG File for Addition

1. **Open Notepad** (Win+R, type `notepad`, press Enter)

2. **Copy and paste the entire content below:**

```
Windows Registry Editor Version 5.00

; NVMe Native Driver Registry Enhancement - ADDITION
; Source: Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware
; Created restore point before applying? YES - PROCEED / NO - CANCEL THIS
; 
; Class ID 1176759950: Official Microsoft (Windows Server 2025)
; Class ID 1853569164: Community-discovered (Windows 11 25H2)
; Class ID 156965516: Community-discovered (Windows 11 25H2)
; Class ID 735209102: Community-discovered (Windows 11 25H2)

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides]
"1176759950"=dword:00000001
"1853569164"=dword:00000001
"156965516"=dword:00000001
"735209102"=dword:00000001
```

3. **Save the file:**
   - Click File → Save As
   - Name: `enable-nvme.reg`
   - Save as type: `All Files (*.*)`
   - Location: Desktop (for easy access)
   - Click Save

### Step 2: Apply the .REG File

1. **Navigate to Desktop** where you saved `enable-nvme.reg`
2. **Right-click the file** → Select "Merge"
3. **Click "Yes"** when prompted: "Are you sure you want to add the information in [path] to the registry?"
4. **Click "OK"** when confirmation appears: "The keys and values have been successfully added to the registry"
5. **Restart your computer**

---

# VERIFY SUCCESS

## Verification Steps

1. **Open Device Manager:** Press `Win+X`, select "Device Manager" or press `Win+R`, type `devmgmt.msc`, press Enter
2. **Expand "Storage disks"** - You should see your NVMe device(s)
3. **Right-click your NVMe drive** → Select "Properties"
4. **Click the "Driver" tab**
5. **Check the Driver file name:**
   - ✅ Should show: `nvmedisk.sys` (Native NVMe driver - SUCCESS)
   - ❌ If showing: `StorNVMe.sys` (SCSI emulation driver - Changes not applied)

## Performance Notes

- Native NVMe driver may show different performance metrics in monitoring tools
- Some SMART monitoring utilities may need updates to read NVMe SMART data via native driver
- Most gaming and workload performance will see improvement or remain similar
- Thermal management may be more aggressive with native driver

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

**[📋 Go to Disable Guide](disable-nvme.md)**

The Disable guide covers how to safely remove NVMe enhancements if you experience issues or want to revert to the default SCSI driver stack.

# NVMe Registry Enhancement - DISABLE GUIDE

## 📋 What This Guide Covers

This guide helps you **safely disable** the Native NVMe driver enhancements you previously enabled. Use this if:

✅ **When to use:**
- You experience issues with the Native NVMe driver
- You want to revert to the default SCSI driver stack
- You need to troubleshoot system instability
- Performance issues appeared after enabling NVMe
- Your SMART monitoring tool isn't working properly

✅ **What you get:**
- **Removes the 4 Class ID values** (1176759950, 1853569164, 156965516, 735209102)
- Registry key structure remains (empty but present)
- Return to default `StorNVMe.sys` (SCSI emulation driver)
- System Restore option for instant rollback
- Clear verification steps
- Easy to re-enable later if needed

---

## 📥 QUICK DOWNLOAD

Choose your preferred method:

| Method | File | Download | What It Does | Sources |
|--------|------|----------|--------------|---------|
| **PowerShell Script** | `disable-nvme.ps1` | [⬇️ Download PS1](2.%20NVMe%20Performance%20Disable/disable-nvme.ps1) | Removes the 4 Class ID values only (keeps registry key structure intact) | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |
| **Registry File** | `disable-nvme.reg` | [⬇️ Download REG](2.%20NVMe%20Performance%20Disable/disable-nvme.reg) | Removes Class IDs 1176759950, 1853569164, 156965516, 735209102 values | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |

**Class IDs Removed:**
- ✅ **1176759950** - Primary Native NVMe
- ✅ **1853569164** - Enhancement 1
- ✅ **156965516** - Enhancement 2
- ✅ **735209102** - Enhancement 3 KEY

**Reverts to:** `StorNVMe.sys` (Default SCSI emulation driver)

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

# METHOD 1: POWERSHELL - DISABLE NVMe

## PowerShell - Removing NVMe Registry Entries

**When to Use:** If you experience issues or want to revert to SCSI driver stack

**Important:** You can restore instantly using the Restore Point created earlier, OR use this removal script

### PowerShell Removal Script (Copy & Paste Ready)

```powershell
# NVMe Native Driver Registry Enhancement - REMOVAL
# Run as Administrator
# Removes all NVMe registry entries and offers restore point option

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "NVMe Registry Enhancement - REMOVAL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'" -ForegroundColor Red
    Exit 1
}

Write-Host "✓ Running as Administrator" -ForegroundColor Green
Write-Host ""
Write-Host "⚠ WARNING: This will remove NVMe registry entries!" -ForegroundColor Yellow
Write-Host "Are you sure you want to continue? (Y/N)" -ForegroundColor Yellow
$confirmation = Read-Host
if ($confirmation -ne "Y" -and $confirmation -ne "y") {
    Write-Host "Removal cancelled by user" -ForegroundColor Yellow
    Exit 0
}

Write-Host ""

# Step 1: Remove Registry Entry 1
Write-Host "[STEP 1/5] Removing Class ID 1176759950..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1176759950 /f 2>$null | Out-Null
    Write-Host "✓ Class ID 1176759950 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 1176759950 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 2: Remove Registry Entry 2
Write-Host "[STEP 2/5] Removing Class ID 1853569164..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1853569164 /f 2>$null | Out-Null
    Write-Host "✓ Class ID 1853569164 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 1853569164 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 3: Remove Registry Entry 3
Write-Host "[STEP 3/5] Removing Class ID 156965516..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 156965516 /f 2>$null | Out-Null
    Write-Host "✓ Class ID 156965516 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 156965516 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 4: Remove Registry Entry 4
Write-Host "[STEP 4/5] Removing Class ID 735209102..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 735209102 /f 2>$null | Out-Null
    Write-Host "✓ Class ID 735209102 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 735209102 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 5: Summary and Restart
Write-Host "[STEP 5/5] Completion" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ ALL REGISTRY ENTRIES REMOVED" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "  • Restart your computer for changes to take effect"
Write-Host "  • System will revert to using StornVme.sys driver (SCSI stack)"
Write-Host ""
Write-Host "Alternative: Use System Restore to instantly revert to previous state" -ForegroundColor Cyan
Write-Host "  1. Press Win+R, type 'rstrui.exe', press Enter"
Write-Host "  2. Select 'NVMe-Before-Registry-Changes' restore point"
Write-Host "  3. Click 'Restore' and restart"
Write-Host ""
Write-Host "Restart now? (R/N)" -ForegroundColor Yellow
$restart = Read-Host
if ($restart -eq "R" -or $restart -eq "r") {
    Write-Host "Restarting in 10 seconds..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    Restart-Computer -Force
} else {
    Write-Host "Remember to restart manually to apply changes!" -ForegroundColor Yellow
}
```

---

# METHOD 2: REGISTRY FILE (.REG) - DISABLE NVMe

## Registry File - Removing NVMe Registry Entries

**When to Use:** If you experience issues or want to revert

### Step 1: Create the .REG File for Removal

1. **Open Notepad** (Win+R, type `notepad`, press Enter)

2. **Copy and paste the entire content below:**

```
Windows Registry Editor Version 5.00

; NVMe Native Driver Registry Enhancement - REMOVAL
; This file removes all NVMe registry entries
; Source: Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware
; 
; The "-" prefix before the value removes it from registry
; Alternative: Use System Restore Point for instant rollback

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides]
"1176759950"=-
"1853569164"=-
"156965516"=-
"735209102"=-
```

3. **Save the file:**
   - Click File → Save As
   - Name: `disable-nvme.reg`
   - Save as type: `All Files (*.*)`
   - Location: Desktop
   - Click Save

### Step 2: Apply the Removal .REG File

1. **Navigate to Desktop** where you saved `disable-nvme.reg`
2. **Right-click the file** → Select "Merge"
3. **Click "Yes"** when prompted
4. **Click "OK"** when confirmation appears
5. **Restart your computer**

---

# RECOVERY OPTIONS

## Fastest Rollback Option (Recommended)

**System Restore Point (Instant Recovery):**
1. Press `Win+R`, type `rstrui.exe`, press Enter
2. Select "NVMe-Before-Registry-Changes"
3. Click "Restore" and restart
4. This is **instant and guaranteed** to work

## After Disabling NVMe

Once disabled and restarted:
- System will revert to using `StorNVMe.sys` driver (SCSI emulation stack)
- NVMe devices will appear as generic SCSI devices in Device Manager
- Performance may be slightly reduced compared to native driver
- SMART data monitoring will work normally with standard tools

## Verification Steps

1. **Open Device Manager:** Press `Win+X`, select "Device Manager"
2. **Expand "Storage disks"**
3. **Right-click your NVMe drive** → Select "Properties"
4. **Click the "Driver" tab**
5. **Verify:**
   - ✅ Should show: `StorNVMe.sys` (SCSI emulation driver - Disabled successfully)
   - ❌ If showing: `nvmedisk.sys` (Native driver still active - Try again)

---

# SAFE BOOT NOTES

**If experiencing issues in Safe Mode:**
- Registry edits persist in Safe Boot mode (they don't get disabled)
- To fully disable NVMe enhancements in Safe Boot, use one of the removal methods above
- System Restore is the **fastest** way to recover:
  1. Boot to Safe Mode with Command Prompt
  2. Run restore in Safe Mode
  3. Guarantees clean revert

---

# CLASS ID REFERENCE

| Class ID | Name | Source | Official? | For Windows |
|----------|------|--------|-----------|-------------|
| 1176759950 | Primary Native NVMe | Microsoft Tech Community | ✅ YES | Server 2025 |
| 1853569164 | Enhancement 1 | Windows Forums, Reddit | ❌ NO | 11 25H2 |
| 156965516 | Enhancement 2 | Deskmodder, Heise | ❌ NO | 11 25H2 |
| 735209102 | Enhancement 3 (KEY) | PC Gamer, Tom's Hardware | ❌ NO | 11 25H2 |

---

## Navigation

**Changed your mind?** → Go back and enable NVMe instead

**[✅ Go Back to Enable Guide](README.md)**

---

## Need Complete Registry Cleanup?

**Want to delete the ENTIRE registry key?** → Continue to the Cleanup guide

**[🔥 Go to Cleanup Guide](cleanup-nvme.md)**

The Cleanup guide performs a complete deletion of the entire registry key path - the most aggressive cleanup option. Use this if you want a fresh start with no registry remnants.
# NVMe Registry Enhancement - CLEANUP GUIDE

## 🔥 NUCLEAR OPTION - COMPLETE REGISTRY CLEANUP

**This is the most aggressive cleanup method** - Complete deletion of the entire registry key path.

### When You Need This

Use the Cleanup guide if:

✅ **Advanced scenarios:**
- You want a **complete registry deletion** (not just value removal)
- Entire registry key path deleted: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides`
- Troubleshooting complex registry issues
- Preparing for migration or system optimization
- You need guaranteed complete removal with zero registry remnants
- Professional cleanup or system preparation

✅ **What you get:**
- **Complete deletion of entire registry key path**
- All values AND the key structure removed
- Nuclear-level cleanup (no partial entries remain)
- Fresh registry state
- Guaranteed removal of all modifications
- System Restore for instant rollback if needed

**⚠️ COMPARE:** 
- **Disable** = Removes the 4 Class ID values (key stays empty)
- **Cleanup** = Removes entire key + all subkeys (complete deletion)

**⚠️ WARNING:** This is irreversible without your System Restore Point - make sure it's created first!

---

## 📥 QUICK DOWNLOAD

Choose your preferred method:

| Method | File | Download | What It Does | Sources |
|--------|------|----------|--------------|---------|
| **PowerShell Script** | `cleanup-nvme.ps1` | [⬇️ Download PS1](3.%20NVMe%20Performance%20Cleanup/cleanup-nvme.ps1) | **Deletes entire registry key path** - removes key + all values + subkeys, requires YES confirmation | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |
| **Registry File** | `cleanup-nvme.reg` | [⬇️ Download REG](3.%20NVMe%20Performance%20Cleanup/cleanup-nvme.reg) | **Deletes entire registry key** - removes complete `FeatureManagement\Overrides` key structure | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |

**What Gets Deleted:**
- ✅ **Complete Key Path:** `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides`
- ✅ **All values** inside the key (1176759950, 1853569164, 156965516, 735209102)
- ✅ **All subkeys** and related registry entries

**Most Aggressive Cleanup:** This is the nuclear option - zero registry remnants remain

Both files are pre-configured and ready to use. Download one, save to Desktop, and run as Administrator. **Requires confirmation.**

---

## ⚠️ DETAILED CLEANUP INSTRUCTIONS

**WARNING: This guide covers complete deletion of the entire registry key path. This is the most aggressive cleanup method.**

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

# METHOD 1: POWERSHELL - COMPLETE CLEANUP

## PowerShell - Complete Registry Cleanup (Nuclear Option)

**When to Use:** If you want to completely delete the entire registry key path and all its contents (most aggressive cleanup)

**⚠️ WARNING:** This removes the ENTIRE key, not just individual values. This is irreversible without restoring from your System Restore Point.

### PowerShell Complete Cleanup Script (Copy & Paste Ready)

```powershell
# NVMe Native Driver Registry Enhancement - COMPLETE CLEANUP
# Run as Administrator
# Completely removes the entire registry key and all its contents
# THIS IS THE NUCLEAR OPTION - use only if you want total cleanup

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "NVMe Registry Enhancement - COMPLETE CLEANUP" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'" -ForegroundColor Red
    Exit 1
}

Write-Host "✓ Running as Administrator" -ForegroundColor Green
Write-Host ""
Write-Host "⚠ WARNING: This will DELETE THE ENTIRE registry key path!" -ForegroundColor Yellow
Write-Host "This removes the complete FeatureManagement\Overrides key and all its values." -ForegroundColor Yellow
Write-Host ""
Write-Host "Registry Path to be deleted:" -ForegroundColor Yellow
Write-Host "  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" -ForegroundColor Red
Write-Host ""
Write-Host "Are you SURE you want to continue? (type 'YES' to confirm)" -ForegroundColor Yellow
$confirmation = Read-Host
if ($confirmation -ne "YES") {
    Write-Host "Cleanup cancelled by user" -ForegroundColor Yellow
    Exit 0
}

Write-Host ""
Write-Host "[STEP 1/3] Deleting entire registry key..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /f 2>$null | Out-Null
    Write-Host "✓ Registry key completely deleted" -ForegroundColor Green
} catch {
    Write-Host "⚠ Key not found or already deleted" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[STEP 2/3] Verification" -ForegroundColor Yellow

# Try to read to verify deletion
$path = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides"
$result = reg query $path 2>&1
if ($result -match "cannot find") {
    Write-Host "✓ Confirmed: Registry key has been completely removed" -ForegroundColor Green
} else {
    Write-Host "⚠ Warning: Key may still exist (requires restart to confirm)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[STEP 3/3] Completion" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ COMPLETE CLEANUP FINISHED" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  • Entire FeatureManagement\Overrides key: DELETED ✓" -ForegroundColor Green
Write-Host "  • All NVMe registry entries: REMOVED ✓" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "  • Restart your computer for changes to take effect"
Write-Host "  • System will revert to default Windows driver behavior"
Write-Host ""
Write-Host "Restart now? (R/N)" -ForegroundColor Yellow
$restart = Read-Host
if ($restart -eq "R" -or $restart -eq "r") {
    Write-Host "Restarting in 10 seconds..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    Restart-Computer -Force
} else {
    Write-Host "Remember to restart manually to apply changes!" -ForegroundColor Yellow
}
```

---

# METHOD 2: REGISTRY FILE (.REG) - COMPLETE CLEANUP

## Registry File - Complete Registry Cleanup (Nuclear Option)

**When to Use:** If you want to completely delete the entire registry key path and all its contents

**⚠️ WARNING:** This removes the ENTIRE key structure, not just individual values.

### Step 1: Create the .REG File for Complete Cleanup

1. **Open Notepad** (Win+R, type `notepad`, press Enter)

2. **Copy and paste the entire content below:**

```
Windows Registry Editor Version 5.00

; NVMe Native Driver Registry Enhancement - COMPLETE CLEANUP
; This file DELETES the entire registry key path
; WARNING: This is the nuclear option - removes everything under Overrides
; Source: Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware
; 
; This removes the complete key:
; HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides]
```

3. **Save the file:**
   - Click File → Save As
   - Name: `cleanup-nvme.reg`
   - Save as type: `All Files (*.*)`
   - Location: Desktop
   - Click Save

### Step 2: Apply the Complete Cleanup .REG File

1. **Navigate to Desktop** where you saved `cleanup-nvme.reg`
2. **Right-click the file** → Select "Merge"
3. **Click "Yes"** when prompted: "Are you sure you want to add the information in [path] to the registry?"
4. **Click "OK"** when confirmation appears
5. **Restart your computer**

---

# RECOVERY & ROLLBACK

## If Something Goes Wrong

**System Restore Point (Fastest Recovery):**
1. Press `Win+R`, type `rstrui.exe`, press Enter
2. Select "NVMe-Before-Registry-Changes"
3. Click "Restore" and restart
4. This **instantly reverts** all changes - guaranteed to work

**Note:** This is why the System Restore Point at the beginning is CRITICAL. It's your safety net for complete cleanup.

---

# AFTER CLEANUP

Once complete cleanup is applied and restarted:

## System Behavior
- All NVMe enhancements completely removed
- System returns to default Windows driver behavior
- Registry path will be recreated by Windows if needed (for other features)
- Clean slate - no remnants of previous modifications

## Verification
1. **Open Device Manager:** Press `Win+X`, select "Device Manager"
2. **Expand "Storage disks"**
3. **Check your NVMe drive** - Should be under SCSI devices
4. **Driver should be:** `StorNVMe.sys` (default SCSI emulation)

## Performance Impact
- May see a very slight performance difference
- System stability improved (if previous changes caused issues)
- Standard Windows monitoring tools work normally

---

# COMPARISON: CLEANUP VS DISABLE

| Option | What Gets Removed | Reversibility | Speed | Use Case |
|--------|------------------|---------------|-------|----------|
| **Disable NVMe** | Individual Class ID values | Easy - Disable script removes only entries | Fast | Turning off NVMe driver but keeping registry structure |
| **Complete Cleanup** | Entire registry key path | Full - Requires System Restore or manual restoration | Very Fast | Total cleanup, fresh start, troubleshooting |

---

# SAFE BOOT RECOVERY

**If you need to recover in Safe Mode:**
1. Boot to Safe Mode with Command Prompt
2. Press `Win+R`, type `rstrui.exe`, press Enter
3. Select "NVMe-Before-Registry-Changes"
4. Click "Restore" and restart
5. System fully restored

---

# CLASS ID REFERENCE

| Class ID | Name | Source | Official? | For Windows |
|----------|------|--------|-----------|-------------|
| 1176759950 | Primary Native NVMe | Microsoft Tech Community | ✅ YES | Server 2025 |
| 1853569164 | Enhancement 1 | Windows Forums, Reddit | ❌ NO | 11 25H2 |
| 156965516 | Enhancement 2 | Deskmodder, Heise | ❌ NO | 11 25H2 |
| 735209102 | Enhancement 3 (KEY) | PC Gamer, Tom's Hardware | ❌ NO | 11 25H2 |

---

## Navigation

**Need to enable NVMe instead?** → Go to Enable guide

**[✅ Go to Enable Guide](README.md)**

**Want to just disable without complete cleanup?** → Go to Disable guide

**[📋 Go to Disable Guide](disable-nvme.md)**
