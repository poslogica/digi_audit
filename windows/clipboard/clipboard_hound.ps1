# Clipboard Hound Script
# This script searches for clipboard-related files in the user's local app data packages directory.

$path = "$env:LOCALAPPDATA\Packages"
write-Output "Searching for clipboard-related files in: $path"

Get-ChildItem -Path $path -Recurse -Include .dat, *ScreenClip -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        $content = Get-Content -Path $_.FullName -ErrorAction Stop
        if ($content -match 'clipboard' -or $content -match 'ScreenClip') {
            Write-Output "Found in file: $($_.FullName)"
            # Decide here what you want to do with the found content
        }
    } catch {
        <#Do this if a terminating exception happens#>
        write-Output "Could not read file: $($_.FullName) - Error: $($_.Exception.Message)"
    }
}


# Disable clipboard history:
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Value 0 -Type DWord -ErrorAction Stop
}
catch {
    <#Do this if a terminating exception happens#>
    Write-Output "Failed to disable clipboard history. Error: $($_.Exception.Message)"
}


# Block screen clipping, set the following registry key:
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ScreenClipBlock" -Name "BlockScreenClip" -Value 1 -Type DWord -ErrorAction Stop
}
catch {
    <#Do this if a terminating exception happens#>
    Write-Output "Failed to block screen clipping. Error: $($_.Exception.Message)"
}