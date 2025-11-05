# Digi Audit

A collection of Windows diagnostic and auditing scripts for system analysis and security assessment.

## Contents

### Windows

- **clipboard/** - Clipboard-related forensics and auditing scripts
  - `clipboard_hound.ps1` - Searches for clipboard-related files and configurations in the system

## Features

### Clipboard Hound

This PowerShell script searches for clipboard-related files in the user's local app data packages directory and identifies screen clipping configurations.

**Usage:**

```powershell
.\windows\clipboard\clipboard_hound.ps1
```

**What it does:**

- Searches `%LOCALAPPDATA%\Packages` for clipboard and screen clip related files
- Identifies `.dat` files and files containing "ScreenClip" references
- Reports files containing "clipboard" or "ScreenClip" keywords
- Handles file read errors gracefully with error messages

**Registry Keys:**

- `HKCU\Software\Microsoft\Clipboard` - Clipboard history settings
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ScreenClipBlock` - Screen clipping control

## Requirements

- Windows 10/11
- PowerShell 5.0 or higher
- Administrator privileges (for some operations)

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

## Author

poslogica
