# Single CBC Video download script
# Provide the CBC Media ID (pulled from CBC video player URL) and the script will download it for you

# Parameter to prompt for CBC Media ID
param (
    [Parameter(mandatory=$true)][string]$CBCmediaID
)

# Retrieve the video download link
$DownloadLinkDAI = (curl https://www.cbc.ca/bistro/order?mediaId=$CBCmediaID | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty assetDescriptors | Where-Object -Property loader -EQ DAILoader | Select-Object -Property Key).Key
Write-Output "Download link: $DownloadLinkDAI"

# Download the video
Start-Process -FilePath (Get-Item ".\youtube-dl.exe") -ArgumentList $DownloadLinkDAI -Wait -Verbose
