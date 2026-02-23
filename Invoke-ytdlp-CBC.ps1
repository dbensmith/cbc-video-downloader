#Requires -Version 7.0
<#
CBC Video batch download script
Simple script to download an imported list of CBC video links via yt-dlp
#>

[CmdletBinding()]
param (
    [Parameter(mandatory=$false)]
    [ValidateScript({
        if (-not (Test-Path $_ -PathType Leaf)) {
            throw "File '$_' not found or is not a file."
        }
        return $true
    })]
    [String]$URLList = Join-Path $PSScriptRoot "URLList.txt"
)

Write-Output "$PSScriptRoot"

# Determine the executable name based on the platform
$ytDlpExe = if ($IsWindows) { "yt-dlp.exe" } else { "yt-dlp" }
$ytDlpPath = Join-Path $PSScriptRoot $ytDlpExe

# Given a CBC Player link (capture from URL bar), download files and organize by date:
Get-Content $URLList | ForEach-Object -Parallel {
    & $using:ytDlpPath -o "%(series)s/%(tags.0)s/%(upload_date>%Y-%m-%d)s - %(title)s [%(id)s].%(ext)s" $_
} -ThrottleLimit 3
