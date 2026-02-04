# cbc-video-downloader

Parses a list of given CBC video URLs and downloads the video files as MP4. Downloads run in parallel but are throttled to three videos at a time to respect CBC's bandwidth.

A separate script takes a single CBC media ID as input and downloads a single file.

Tested to work on (most) video content from the Tokyo 2020 Olympics, the Beijing 2022 Olympics, and the Paris 2024 Olympics.

## Prerequisites

* Microsoft Windows
* PowerShell 7.0 or higher; install from the Microsoft Store, WinGet (`winget install Microsoft.PowerShell`), or [PowerShell on GitHub](https://github.com/PowerShell/PowerShell).
* The [Windows binary of FFmpeg](https://ffmpeg.org/download.html#build-windows).
* The [Windows binary of yt-dlp](https://github.com/yt-dlp/yt-dlp/releases/).

## How to use this

### Preparation

You can install FFmpeg and yt-dlp using the script provided or do it yourself.

#### Automatic

Use [Install-ytdlp-Prerequisites.ps1](/Install-ytdlp-Prerequisites.ps1):

* Clone this repo into a local directory of your choice.
* Open `pwsh.exe` and navigate to the repo directory.
* Run `./Install-ytdlp-Prerequisites.ps1`. The script will retrieve FFmpeg and yt-dlp binaries for you and place them in the working directory.

#### Manual

* Download FFmpeg and yt-dlp (see Prerequisites for links).
* Extract these three FFmpeg binaries into the same directory as the repo:
  * `ffmpeg.exe`
  * `ffplay.exe`
  * `ffprobe.exe`
* Copy `yt-dlp.exe` into the same directory as the repo.

### Downloading a single video

Use [Invoke-ytdlp-CBC-Single.ps1](/Invoke-ytdlp-CBC-Single.ps1):

* Open `pwsh.exe` and navigate to the repo directory.
* Run `./Invoke-ytdlp-CBC-Single.ps1`. The script will prompt for a link. Provide it and continue.
  * Example: video link `https://www.cbc.ca/player/play/1234567891011`.

### Downloading multiple videos

Use [Invoke-ytdlp-CBC.ps1](/Invoke-ytdlp-CBC.ps1):

* Populate `URLList.txt` with a list of CBC Video links you want to retrieve, one per line.
  * Example: `https://www.cbc.ca/player/play/1234567891011`
* Open `pwsh.exe` and navigate to the repo directory.
* Run `./Invoke-ytdlp-CBC.ps1` and watch it go.

## Considerations

* PowerShell 7 or higher is required to support parallel threads in the ForEach-Object loop.
* These scripts are only designed to work when their working directory contains the scripts, text file, and binaries.
* Some CBC video content - typically longer recordings - are presented only as HLS in m3u8 format. Links in this format may fail to download.

## Credits

* The makers of [yt-dlp](https://github.com/yt-dlp/yt-dlp)
* The makers of [FFmpeg](https://www.ffmpeg.org/)
* The [CBC](https://www.cbc.ca/) for their excellent coverage of sporting events
