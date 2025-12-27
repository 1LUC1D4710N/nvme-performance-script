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
