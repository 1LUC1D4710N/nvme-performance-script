# NVMe Performance Script

Comprehensive Windows PowerShell and Registry scripts to optimize NVMe SSD performance on Windows 11 and Windows Server 2025 using the native NVMe driver stack.

## Project Structure

### Enable NVMe Performance
- **enable-nvme.md** - Complete guide for enabling native NVMe driver
- **enable-nvme.ps1** - PowerShell script for automated setup
- **enable-nvme.reg** - Registry file for direct import

### Disable NVMe Performance  
- **disable-nvme.md** - Guide for reverting to default driver
- **disable-nvme.ps1** - PowerShell script for removal
- **disable-nvme.reg** - Registry file for disabling

### Cleanup NVMe Performance
- **cleanup-nvme.md** - Complete cleanup documentation
- **cleanup-nvme.ps1** - PowerShell cleanup script
- **cleanup-nvme.reg** - Registry cleanup file

## Features

✅ Native NVMe driver implementation (direct hardware access)
✅ Potential performance improvements for NVMe SSDs
✅ Better thermal management and responsiveness
✅ Support for advanced NVMe features
✅ System Restore Point creation for instant rollback

## Quick Start

1. Create a System Restore Point before making any changes
2. Choose your preferred method (PowerShell script or Registry file)
3. Run with Administrator privileges
4. Restart your computer
5. Verify the native NVMe driver (nvmedisk.sys) is installed

## Supported Systems

- Windows 11 (25H2)
- Windows Server 2025

## Important Notes

⚠️ Always create a System Restore Point before applying changes
⚠️ Run scripts/files as Administrator
⚠️ Restart required for changes to take effect
⚠️ Community-discovered tweaks used at your own risk

## License

This project is provided as-is for educational and optimization purposes.
