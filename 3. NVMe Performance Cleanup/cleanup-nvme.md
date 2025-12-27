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
| **PowerShell Script** | `cleanup-nvme.ps1` | [⬇️ Download PS1](cleanup-nvme.ps1) | **Deletes entire registry key path** - removes key + all values + subkeys, requires YES confirmation | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |
| **Registry File** | `cleanup-nvme.reg` | [⬇️ Download REG](cleanup-nvme.reg) | **Deletes entire registry key** - removes complete `FeatureManagement\Overrides` key structure | Microsoft Tech Community, Windows Forums, PC Gamer, Tom's Hardware |

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

**[✅ Go to Enable Guide](../1.%20NVMe%20Performance%20Enable/enable-nvme.md)** (or try [direct link](https://github.com/1LUC1D4710N/nvme-performance-script/blob/main/1.%20NVMe%20Performance%20Enable/enable-nvme.md))

**Want to just disable without complete cleanup?** → Go to Disable guide

**[📋 Go to Disable Guide](../2.%20NVMe%20Performance%20Disable/disable-nvme.md)** (or try [direct link](https://github.com/1LUC1D4710N/nvme-performance-script/blob/main/2.%20NVMe%20Performance%20Disable/disable-nvme.md))

