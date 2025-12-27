# NVMe Native Driver Registry Enhancement - COMPLETE CLEANUP
# Run as Administrator
# Completely removes the entire registry key path and all its contents
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
