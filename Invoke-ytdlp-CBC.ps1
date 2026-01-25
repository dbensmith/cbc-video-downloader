<#
CBC Video batch download script
Simple script to download an imported list of CBC video links via yt-dlp
#>
#Requires -Version 7

[CmdletBinding()]
param (
    [Parameter(mandatory=$false)][String]$URLList
)

Write-Output "$PSSCriptRoot"

# Given a CBC Player link (capture from URL bar), download files and organize by date:
$VideoLinkFile = Get-Content (Get-Item $URLList)
$VideoLinkFile | ForEach-Object -Parallel {
    Start-Process -FilePath "$($using:PSScriptRoot)\yt-dlp.exe" -ArgumentList "-o `"%(series)s/%(tags.0)s/%(upload_date>%Y-%m-%d)s - %(title)s [%(id)s].%(ext)s`" $_" -Wait
} -ThrottleLimit 3