<#
CBC Video batch download script
Simple script to download an imported list of CBC video links via YT Downloader
#>
#Requires -Version 7

# Given a CBC Player link (capture from URL bar), use the following script to tease out the actual download link:
$VideoLinkFile = Get-Content (Get-Item ".\VideoLinks.txt")
$CBCmediaID = $VideoLinkFile -replace "https://www.cbc.ca/player/play/"
$CBCmediaID | ForEach-Object -Parallel {
    Write-Output "Downloading ID: $_"
    $DownloadLinkDAI = (curl https://www.cbc.ca/bistro/order?mediaId=$_ | ConvertFrom-Json | Select-Object -ExpandProperty Items | Select-Object -ExpandProperty assetDescriptors | Where-Object -Property loader -EQ DAILoader | Select-Object -Property Key).Key
    Write-Output $DownloadLinkDAI
    Start-Process -FilePath (Get-Item ".\youtube-dl.exe") -ArgumentList $DownloadLinkDAI -Wait -Verbose    
} -ThrottleLimit 3