# Define your install path
[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)][String]$DestinationPath = "$PSScriptRoot"
)

If (!(Test-Path $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory -Force
}

# Install YouTube Downloader (nightly build)
function Install-ytdlp {
    $GitHubOrgRepo = "yt-dlp/yt-dlp"
    $GitHubFile = "yt-dlp.exe"
    $OutFile = "$DestinationPath\$GitHubFile"
    Invoke-WebRequest -Uri https://github.com/$GitHubOrgRepo/releases/latest/download/$GitHubFile -OutFile $OutFile
    Write-Output "Downloaded $GitHubFile to $OutFile."
}

# Install ffmpeg (x64)
function Install-ffmpeg {
    $GitHubOrgRepo = "BtbN/FFmpeg-Builds"
    $GitHubRelease = "ffmpeg-master-latest-win64-gpl"
    $GitHubFile = "$GitHubRelease.zip"
    $OutFile = "$DestinationPath\$GitHubFile"
    $FilesToExtract = @("ffmpeg.exe", "ffplay.exe", "ffprobe.exe")
    Invoke-WebRequest -Uri https://github.com/$GitHubOrgRepo/releases/latest/download/$GitHubFile -OutFile $OutFile
    if (Test-Path $OutFile) {
        # Load the .NET assembly for compression
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        # Open the zip file
        $Zip = [System.IO.Compression.ZipFile]::OpenRead($OutFile)

        # Extract the specified files
        foreach ($File in $FilesToExtract) {
            $Entry = $Zip.GetEntry("$GitHubRelease/bin/$File")
            if (-not $Entry) {
                $Entry = $Zip.Entries | Where-Object { $_.FullName -eq "$GitHubRelease/bin/$File" }
            }
            if ($Entry) {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($Entry, "$DestinationPath\$File", $true)
                Write-Output "Extracted $File to $destinationPath\$File."
            } else {
                Write-Output "$File not found in $OutFile."
            }
        }
        # Close the zip file
        $Zip.Dispose()
        Remove-Item $OutFile -Force
    }
}

# Run the defined functions
Install-ytdlp
Install-ffmpeg
