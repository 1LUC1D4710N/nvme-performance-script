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
| **PowerShell Script** | `disable-nvme.ps1` | [⬇️ Download PS1](disable-nvme.ps1) | Removes the 4 Class ID values only (keeps registry key structure intact) | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |
| **Registry File** | `disable-nvme.reg` | [⬇️ Download REG](disable-nvme.reg) | Removes Class IDs 1176759950, 1853569164, 156965516, 735209102 values | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |

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

**[✅ Go Back to Enable Guide](../1.%20NVMe%20Performance%20Enable/enable-nvme.md)**

---

## Need Complete Registry Cleanup?

**Want to delete the ENTIRE registry key?** → Continue to the Cleanup guide

**[🔥 Go to Cleanup Guide](../3.%20NVMe%20Performance%20Cleanup/cleanup-nvme.md)**

The Cleanup guide performs a complete deletion of the entire registry key path - the most aggressive cleanup option. Use this if you want a fresh start with no registry remnants.
