#Requires -Version 7.0
# Single CBC Video download script
# Provide the CBC video player URL and the script will download it for you and organize it into a folder

# Parameter to prompt for CBC video player URL
param (
    [Parameter(mandatory=$true)][string]$URL
)
Start-Process -NoNewWindow -FilePath $PSScriptRoot\yt-dlp.exe -ArgumentList "-o `"%(series)s/%(tags.0)s/%(upload_date>%Y-%m-%d)s - %(title)s [%(id)s].%(ext)s`" $URL"
