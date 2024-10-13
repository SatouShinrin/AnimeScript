@echo off
set "ffmpeg_path=C:\Tools\bin\ffmpeg.exe"
set "scxvid_path=C:\Tools\bin\SCXvid.exe"

:: Check ffmpeg folder
if not exist "%ffmpeg_path%" (
    echo There is no ffmpeg, please install or update it!
    pause
    exit /b
)

:: Check SCXvid folder
if not exist "%scxvid_path%" (
    echo There is no SCXvid, please install or update it!
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select a video file for keyframes.
    pause
    exit /b
)

echo Script by Shinrin
echo Creating Keyframes, please wait...
set "video=%~1"
set "video2=%~n1"
"%ffmpeg_path%" -i "%video%" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | "%scxvid_path%" "%video2%_keyframes.txt"
echo Done
