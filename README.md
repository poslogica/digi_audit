# Digi Audit

A collection of Windows diagnostic and auditing scripts for system analysis and security assessment.

## Contents

### Windows

- **clipboard/** - Clipboard-related forensics and auditing scripts
  - `clipboard_hound.ps1` - Searches for clipboard-related files and configurations in the system

## Features

### Clipboard Hound

Comprehensive forensic analysis and security hardening tool for Windows clipboard and screen capture functionality. Searches for clipboard-related artifacts, identifies sensitive data exposure risks, and applies security controls.

**Version:** 1.0

**Usage:**

```powershell
.\windows\clipboard\clipboard_hound.ps1
```

**What it does:**

- Scans `%LOCALAPPDATA%\Packages` for clipboard-related files (`*.dat`, `*ScreenClip`)
- Identifies and reports files containing "clipboard" or "ScreenClip" keywords
- Counts and displays total clipboard-related files found
- **Disables clipboard history** via registry (`HKCU\Software\Microsoft\Clipboard` → `EnableClipboardHistory = 0`)
- **Blocks screen clipping** via registry (`HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ScreenClipBlock` → `BlockScreenClip = 1`)
- Handles file read errors gracefully with detailed error messages
- Provides comprehensive execution summary with status confirmation

**Registry Keys Modified:**

- `HKCU\Software\Microsoft\Clipboard\EnableClipboardHistory` - Disables clipboard history (set to 0)
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ScreenClipBlock\BlockScreenClip` - Blocks screen clipping (set to 1)

**Output:**

- Console output with detailed findings for each clipboard-related file found
- Count of total clipboard-related files discovered
- Registry modification status and confirmation messages
- Specific error messages for troubleshooting file read failures
- Execution summary with clear formatting

## Requirements

- Windows 10/11 (tested on 20H2 and later)
- PowerShell 5.0 or higher
- **Administrator privileges required** (for registry modifications and accessing protected files)

## License

MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Disclaimer

This software is provided for educational and authorized security testing purposes only. Users are responsible for ensuring they have proper authorization before running these scripts on any system. Unauthorized access to computer systems is illegal. The authors are not responsible for any misuse or damage caused by this software.

## Known Considerations

- System files (like `User.dat`) may be locked by Windows processes and cannot be read while in use
- Run in Safe Mode if you need to read all system files without locks
- Registry modifications require administrator privileges
- Test in non-production environment before deploying to production systems

## Credits

- Inspired by: [YouTube Tutorial](https://www.youtube.com/watch?v=x8GA1GnEl3o)

## Author

poslogica
