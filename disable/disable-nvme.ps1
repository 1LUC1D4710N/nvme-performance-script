# NVMe Native Driver Registry Enhancement - REMOVAL
# Run as Administrator
# Creates System Restore Point and removes all registry changes

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

# Step 1: Create System Restore Point
Write-Host "[STEP 1/6] Creating System Restore Point..." -ForegroundColor Yellow
try {
    Checkpoint-Computer -Description "NVMe-Before-Removal" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
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

# Step 2: Remove Registry Entry 1
Write-Host "[STEP 2/6] Removing Class ID 1176759950..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1176759950 /f 2>$null
    Write-Host "✓ Class ID 1176759950 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 1176759950 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 3: Remove Registry Entry 2
Write-Host "[STEP 3/6] Removing Class ID 1853569164..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 1853569164 /f 2>$null
    Write-Host "✓ Class ID 1853569164 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 1853569164 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 4: Remove Registry Entry 3
Write-Host "[STEP 4/6] Removing Class ID 156965516..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 156965516 /f 2>$null
    Write-Host "✓ Class ID 156965516 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 156965516 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 5: Remove Registry Entry 4
Write-Host "[STEP 5/6] Removing Class ID 735209102..." -ForegroundColor Yellow
try {
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 735209102 /f 2>$null
    Write-Host "✓ Class ID 735209102 removed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Class ID 735209102 not found or already removed" -ForegroundColor Yellow
}

Write-Host ""

# Step 6: Summary and Restart Prompt
Write-Host "[STEP 6/6] Verification and Restart" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ ALL REGISTRY ENTRIES REMOVED" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "⚠ IMPORTANT: You MUST restart your system for changes to take effect!" -ForegroundColor Yellow
Write-Host ""
Write-Host "After restart, your system will use the default StorNVMe.sys driver." -ForegroundColor Cyan
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
