#========================================
# CLIPBOARD HOUND SCRIPT
#========================================
#
# DESCRIPTION:
#   Comprehensive forensic analysis and security hardening tool for Windows clipboard and screen capture functionality.
#   Searches for clipboard-related artifacts, identifies sensitive data exposure risks, and applies security controls.
#
# FUNCTIONALITY:
#   1. Scans %LOCALAPPDATA%\Packages for clipboard-related files (*.dat, *ScreenClip)
#   2. Identifies and reports files containing "clipboard" or "ScreenClip" references
#   3. Disables clipboard history via registry (HKCU\Software\Microsoft\Clipboard → EnableClipboardHistory = 0)
#   4. Blocks screen clipping via registry (HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ScreenClipBlock → BlockScreenClip = 1)
#
# USAGE:
#   .\clipboard_hound.ps1
#
# REQUIREMENTS:
#   - Windows 10/11 (tested on 20H2 and later)
#   - PowerShell 5.0 or higher
#   - Administrator privileges (required for registry modifications)
#
# OUTPUT:
#   - Console output with detailed findings and status messages
#   - Count of clipboard-related files found
#   - Registry modification status and confirmation
#   - Comprehensive error reporting with specific error messages
#
# SECURITY CONSIDERATIONS:
#   - This script modifies Windows registry settings
#   - Ensure proper authorization before execution
#   - Review all changes before applying to production systems
#   - Consider testing in non-production environment first
#
# AUTHOR:     poslogica
# DATE:       2025
# VERSION:    1.0
#
#========================================

$path = "$env:LOCALAPPDATA\Packages"
Write-Output "Searching for clipboard-related files in: $path"
$foundCount = 0

try {
    Get-ChildItem -Path $path -Recurse -Include *.dat, *ScreenClip -ErrorAction Stop | ForEach-Object {
        try {
            $content = Get-Content -Path $_.FullName -ErrorAction Stop
            # Case-insensitive matching for 'clipboard' or 'ScreenClip' keywords
            if ($content -match 'clipboard' -or $content -match 'ScreenClip') {
                Write-Output "Found in file: $($_.FullName)"
                $foundCount++
                # Decide here what you want to do with the found content
            }
        } catch {
            # Handle file read errors (e.g., access denied, file locked, corrupted data)
            Write-Output "Could not read file: $($_.FullName) - Error: $($_.Exception.Message)"
        }
    }
} catch {
    # Handle directory search errors (e.g., path doesn't exist, access denied)
    Write-Output "Error searching directory: $path - Error: $($_.Exception.Message)"
}

Write-Output "Clipboard search completed. Total items found: $foundCount"


# Disable clipboard history:
$EnableClipboardHistoryRegistryPath = "HKCU:\Software\Microsoft\Clipboard"
$EnableClipboardHistoryRegistryName = "EnableClipboardHistory"
try {
    Write-Output "Disabling clipboard history by setting registry key."
    Write-Output "Registry Path: $EnableClipboardHistoryRegistryPath"
    Write-Output "Registry Name: $EnableClipboardHistoryRegistryName"
    Set-ItemProperty -Path $EnableClipboardHistoryRegistryPath -Name $EnableClipboardHistoryRegistryName -Value 0 -Type DWord -ErrorAction Stop -Force
    Write-Output "Successfully disabled clipboard history."
}
catch {
    # Handle registry operation errors (e.g., registry path doesn't exist, access denied)
    Write-Output "Failed to disable clipboard history. Error: $($_.Exception.Message)"
}


# Block screen clipping, set the following registry key:
$BlockScreenClipRegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ScreenClipBlock"
$BlockScreenClipRegistryName = "BlockScreenClip"
try {
    Write-Output "Blocking screen clipping by setting registry key."
    Write-Output "Registry Path: $BlockScreenClipRegistryPath"
    Write-Output "Registry Name: $BlockScreenClipRegistryName"
    Set-ItemProperty -Path $BlockScreenClipRegistryPath -Name $BlockScreenClipRegistryName -Value 1 -Type DWord -ErrorAction Stop -Force
    Write-Output "Successfully blocked screen clipping."
}
catch {
    # Handle registry operation errors (e.g., registry path doesn't exist, access denied)
    Write-Output "Failed to block screen clipping. Error: $($_.Exception.Message)"
}

Write-Output "`n========== Script Execution Summary =========="
Write-Output "Clipboard search completed. Total items found: $foundCount"
Write-Output "Registry modifications applied."
Write-Output "=============================================="