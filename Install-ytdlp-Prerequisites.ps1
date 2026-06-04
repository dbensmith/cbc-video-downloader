#Requires -Version 7.0
# Define your install path
[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)][String]$DestinationPath = "$PSScriptRoot"
)

# Disable progress bar to improve download speeds with Invoke-WebRequest
$ProgressPreference = 'SilentlyContinue'

If (!(Test-Path -LiteralPath $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory -Force
}

# Install YouTube Downloader (nightly build)
function Install-ytdlp {
    param($DestinationPath)
    $GitHubOrgRepo = "yt-dlp/yt-dlp-nightly-builds"
    $GitHubFile = "yt-dlp.exe"
    $OutFile = Join-Path $DestinationPath $GitHubFile

    if (Test-Path -LiteralPath $OutFile) {
        Write-Output "$GitHubFile already exists at $OutFile. Skipping download."
        return
    }

    Invoke-WebRequest -Uri "https://github.com/$GitHubOrgRepo/releases/latest/download/$GitHubFile" -OutFile $OutFile
    Write-Output "Downloaded $GitHubFile to $OutFile."
}

# Install ffmpeg (x64)
function Install-ffmpeg {
    param($DestinationPath)
    $GitHubOrgRepo = "BtbN/FFmpeg-Builds"
    $GitHubRelease = "ffmpeg-master-latest-win64-gpl"
    $GitHubFile = "$GitHubRelease.zip"
    $OutFile = Join-Path $DestinationPath $GitHubFile
    $FilesToExtract = @("ffmpeg.exe", "ffplay.exe", "ffprobe.exe")

    # Check if all required binaries already exist
    $missingFiles = $FilesToExtract.Where({ -not (Test-Path -LiteralPath (Join-Path $DestinationPath $_)) })

    if (-not $missingFiles) {
        Write-Output "All FFmpeg binaries already exist in $DestinationPath. Skipping download and extraction."
        return
    }

    Invoke-WebRequest -Uri "https://github.com/$GitHubOrgRepo/releases/latest/download/$GitHubFile" -OutFile $OutFile
    if (Test-Path -LiteralPath $OutFile) {
        # Load the .NET assembly for compression
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        # Open the zip file
        $Zip = [System.IO.Compression.ZipFile]::OpenRead($OutFile)

        # Extract the specified files
        $EntriesHash = $null
        foreach ($File in $FilesToExtract) {
            $EntryPath = "$GitHubRelease/bin/$File"
            $Entry = $Zip.GetEntry($EntryPath)
            if (-not $Entry) {
                if (-not $EntriesHash) {
                    $EntriesHash = @{}
                    foreach ($ZipEntry in $Zip.Entries) {
                        if (-not $EntriesHash.ContainsKey($ZipEntry.FullName)) {
                            $EntriesHash[$ZipEntry.FullName] = $ZipEntry
                        }
                    }
                }
                $Entry = $EntriesHash[$EntryPath]
            }
            if ($Entry) {
                $TargetPath = Join-Path $DestinationPath $File
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($Entry, $TargetPath, $true)
                Write-Output "Extracted $File to $TargetPath."
            } else {
                Write-Output "$File not found in $OutFile."
            }
        }
        # Close the zip file
        $Zip.Dispose()
        Remove-Item $OutFile -Force
    }
}

# Run the defined functions in parallel
$ytdlpDef = ${function:Install-ytdlp}.ToString()
$ffmpegDef = ${function:Install-ffmpeg}.ToString()

"ytdlp", "ffmpeg" | ForEach-Object -Parallel {
    $DestinationPath = $using:DestinationPath
    $ProgressPreference = 'SilentlyContinue'
    if ($_ -eq "ytdlp") {
        $sb = [scriptblock]::Create($using:ytdlpDef)
        & $sb $DestinationPath
    }
    else {
        $sb = [scriptblock]::Create($using:ffmpegDef)
        & $sb $DestinationPath
    }
}
