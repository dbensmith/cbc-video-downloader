# cbc-video-downloader
Download MP4 videos from CBC by parsing a given CBC video URL. Tested on Tokyo 2020 Olympics content.

Built on PowerShell and designed to run on Windows systems.

# How to use this
* Clone this repo locally into a folder of your choice
* If not installed, download and install PowerShell 7 from the Microsoft Store or from the [Microsoft GitHub](https://github.com/PowerShell/PowerShell)
* Download the [Windows binary of FFmpeg](https://ffmpeg.org/download.html#build-windows) and extract it to the same folder
* Download the [Windows binary of youtube-dl](https://yt-dl.org/latest/youtube-dl.exe) and copy it to the same folder
* Populate VideoLinks.txt with a list of CBC Video links you want to retrieve, one per line
  * Example: https://www.cbc.ca/player/play/1921255491594
* Open PowerShell v7 and navigate to the directory where you put the above files
* Run ```./Invoke-YouTubeDownloader-CBC.ps1``` and watch it go

# Credit
* The makers of [youtube-dl](https://github.com/ytdl-org/youtube-dl)
* The makers of [ffmpeg](https://www.ffmpeg.org/)
* The [CBC](https://www.cbc.ca/) for their excellent coverage of sporting events
