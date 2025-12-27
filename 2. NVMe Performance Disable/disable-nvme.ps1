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
