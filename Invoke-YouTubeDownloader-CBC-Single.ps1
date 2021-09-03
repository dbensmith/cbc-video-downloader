# Single CBC Video download script
# Provide the CBC Media ID (pulled from CBC video player URL) and the script will download it for you

# Parameter help description
param (
    [Parameter(mandatory=$true)][string]$CBCmediaID
    )
    $DownloadLinkDAI = (curl https://www.cbc.ca/bistro/order?mediaId=$CBCmediaID | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty assetDescriptors | Where-Object -Property loader -EQ DAILoader | Select-Object -Property Key).Key
Write-Output "$DownloadLinkDAI"
Start-Process -FilePath (Get-Item ".\youtube-dl.exe") -ArgumentList $DownloadLinkDAI -Wait -Verbose