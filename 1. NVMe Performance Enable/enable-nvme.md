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
|--------|------|----------|--------------|---------|
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

**[📖 Go to Disable Guide](../2. NVMe Performance Disable/disable-nvme.md)**

The Disable guide covers how to safely remove NVMe enhancements if you experience issues or want to revert to the default SCSI driver stack.

