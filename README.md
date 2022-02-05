# cbc-video-downloader
Parses a list of given CBC video URLs and downloads the video files as MP4. Downloads run in parallel but are throttled to three videos at a time to respect CBC's bandwidth.

A separate script takes a single CBC media ID as input and downloads a single file.

Tested to work on (most) video content from the Tokyo 2020 Olympics and the Beijing 2022 Olympics.

## Prerequisites
* PowerShell 7: install from the Microsoft Store or [PowerShell on GitHub](https://github.com/PowerShell/PowerShell)
* A copy of the [Windows binary of FFmpeg](https://ffmpeg.org/download.html#build-windows)
* A copy of the [Windows binary of youtube-dl](https://yt-dl.org/latest/youtube-dl.exe) 

## How to use this
#### Preparation
* Clone this repo into a local folder of your choice.
* Extract these three FFmpeg binaries into the same folder as the repo:
  * ```ffmpeg.exe```
  * ```ffplay.exe```
  * ```ffprobe.exe```
* Copy ```youtube-dl.exe``` into the same folder as the repo.

#### Using [Invoke-YouTubeDownloader-CBC.ps1](https://github.com/dbensmith/cbc-video-downloader/blob/4421de21b3c6629241dd36281cd345ecb219b7b3/Invoke-YouTubeDownloader-CBC.ps1)
* Populate ```VideoLinks.txt``` with a list of CBC Video links you want to retrieve, one per line.
  * Example: https://www.cbc.ca/player/play/1234567891011
* Open PowerShell 7 and navigate to your working directory.
* Run ```./Invoke-YouTubeDownloader-CBC.ps1``` and watch it go.

#### Using [Invoke-YouTubeDownloader-CBC-Single.ps1](https://github.com/dbensmith/cbc-video-downloader/blob/4421de21b3c6629241dd36281cd345ecb219b7b3/Invoke-YouTubeDownloader-CBC-Single.ps1)
* Run ```./Invoke-YouTubeDownloader-CBC-Single.ps1```. The script will prompt for a single CBC Media ID.
  * You can find the 13-digit Media ID from the end of the CBC player URL of the video you wish to retrieve.
  * Example: for video link https://www.cbc.ca/player/play/1234567891011, the CBC Media ID is ```1234567891011```.

## Considerations
* PowerShell 7 is required to support parallel threads in the ForEach-Object loop. If you prefer PS 5.1, replace this syntax with ```foreach ($_ in $CBCmediaID)``` instead. You will lose parallel downloads, but won't have to install PowerShell 7 (although you should anyway).
* These scripts will only function when the working directory is the folder containing the script and binaries.
* Some CBC video content - typically longer recordings - are presented only as HLS in m3u8 format. This parser/downloader cannot handle them and downloads will fail.

## Credits
* The makers of [youtube-dl](https://github.com/ytdl-org/youtube-dl)
* The makers of [FFmpeg](https://www.ffmpeg.org/)
* The [CBC](https://www.cbc.ca/) for their excellent coverage of sporting events
