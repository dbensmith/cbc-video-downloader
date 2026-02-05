#Requires -Version 7.0
<#
CBC Video batch download script
Simple script to download an imported list of CBC video links via yt-dlp
#>

[CmdletBinding()]
param (
    [Parameter(mandatory=$false)][String]$URLList
)

Write-Output "$PSSCriptRoot"

# Given a CBC Player link (capture from URL bar), download files and organize by date:
$VideoLinkFile = Get-Content (Get-Item $URLList)
$VideoLinkFile | ForEach-Object -Parallel {
    & "$($using:PSScriptRoot)\yt-dlp.exe" -o "%(series)s/%(tags.0)s/%(upload_date>%Y-%m-%d)s - %(title)s [%(id)s].%(ext)s" $_
} -ThrottleLimit 3