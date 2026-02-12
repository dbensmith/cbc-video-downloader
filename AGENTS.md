# Development Guidelines

This repository follows specific conventions and requirements to ensure maintainability and compatibility.

## 1. Commit Convention

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification (v1.0.0). Please adhere to the Angular convention:

### Format
```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

### Types
*   **feat**: A new feature
*   **fix**: A bug fix
*   **docs**: Documentation only changes
*   **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
*   **refactor**: A code change that neither fixes a bug nor adds a feature
*   **perf**: A code change that improves performance
*   **test**: Adding missing tests or correcting existing tests
*   **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
*   **ci**: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
*   **chore**: Other changes that don't modify src or test files
*   **revert**: Reverts a previous commit

### Example
```
feat(downloader): add support for parallel downloads
```

## 2. Environment Requirements

Ensure your development environment meets the following requirements:
*   **PowerShell**: Version 7.0 or higher
*   **Pester**: Version 5.0 or higher

You can verify your environment by running the following PowerShell script:

```powershell
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Error "PowerShell 7+ is required. Current version: $($PSVersionTable.PSVersion)"
} else {
    Write-Host "PowerShell version $($PSVersionTable.PSVersion) is compatible." -ForegroundColor Green
}

if (Get-Module -ListAvailable -Name Pester | Where-Object { $_.Version.Major -ge 5 }) {
    Write-Host "Pester 5+ is installed." -ForegroundColor Green
} else {
    Write-Warning "Pester 5+ is not installed or not found. Please install it using: Install-Module -Name Pester -Force"
}
```

## 3. Cross-Platform Compatibility

While the initial codebase may have Windows-specific elements, future development should prioritize cross-platform compatibility (Windows, Linux, macOS) where feasible.

### Guidelines
*   Use `Join-Path` or forward slashes `/` for file paths instead of hardcoding backslashes `\`.
*   Avoid hardcoding file extensions like `.exe` unless necessary for Windows-specific executables. Use conditional logic based on `$IsWindows`, `$IsLinux`, or `$IsMacOS`.
*   Test scripts on both Windows and Linux environments if possible.
*   Use .NET types available in .NET Core/Standard to ensure broad compatibility.
