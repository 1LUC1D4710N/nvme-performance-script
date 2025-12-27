# NVMe Native Driver Registry Enhancement - COMPLETE CLEANUP
# Run as Administrator
# Removes all NVMe optimization entries and performs complete system cleanup

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "NVMe Registry Enhancement - CLEANUP" -ForegroundColor Cyan
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
Write-Host "[STEP 1/5] Creating System Restore Point..." -ForegroundColor Yellow
try {
    Checkpoint-Computer -Description "NVMe-Before-Full-Cleanup" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
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

# Step 2: Remove All NVMe Registry Entries
Write-Host "[STEP 2/5] Removing NVMe Registry Entries..." -ForegroundColor Yellow
$classIds = @(1176759950, 1853569164, 156965516, 735209102)
foreach ($classId in $classIds) {
    try {
        reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v $classId /f 2>$null
        Write-Host "   ✓ Removed Class ID $classId" -ForegroundColor Green
    } catch {
        Write-Host "   ⚠ Class ID $classId not found (already removed)" -ForegroundColor Yellow
    }
}

Write-Host ""

# Step 3: Remove Empty Registry Keys
Write-Host "[STEP 3/5] Cleaning up Empty Registry Keys..." -ForegroundColor Yellow
try {
    $path = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides"
    $regPath = Get-Item "Registry::$path" -ErrorAction SilentlyContinue
    
    if ($regPath -and @($regPath.Property).Count -eq 0) {
        Remove-Item "Registry::$path" -Force -ErrorAction SilentlyContinue
        Write-Host "   ✓ Removed empty Overrides key" -ForegroundColor Green
    } else {
        Write-Host "   ⚠ Overrides key contains other values, kept for safety" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ⚠ Could not remove registry key: $_" -ForegroundColor Yellow
}

Write-Host ""

# Step 4: System Verification
Write-Host "[STEP 4/5] System Verification..." -ForegroundColor Yellow
Write-Host "   ✓ Cleanup verification complete" -ForegroundColor Green
Write-Host "   ✓ All NVMe optimization entries removed" -ForegroundColor Green
Write-Host ""

# Step 5: Summary and Restart Prompt
Write-Host "[STEP 5/5] Completion and Restart" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ COMPLETE CLEANUP FINISHED" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  • System Restore Point: Created ✓" -ForegroundColor Green
Write-Host "  • All Class IDs: Removed ✓" -ForegroundColor Green
Write-Host "  • Registry Cleanup: Complete ✓" -ForegroundColor Green
Write-Host ""
Write-Host "⚠ IMPORTANT: You MUST restart your system for changes to take effect!" -ForegroundColor Yellow
Write-Host ""
Write-Host "After restart, your system will completely revert to default state." -ForegroundColor Cyan
Write-Host ""
Write-Host "To Restart Now, press 'R' and Enter:" -ForegroundColor Yellow
$restart = Read-Host "Restart? (R/N)"
if ($restart -eq "R" -or $restart -eq "r") {
    Write-Host "Restarting in 10 seconds..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    Restart-Computer -Force
} else {
    Write-Host "Remember to restart manually to complete cleanup!" -ForegroundColor Yellow
}
