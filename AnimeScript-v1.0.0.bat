@echo off
REM Various URLs/Paths
set install_dir=C:\Tools
set sendto_path=%userprofile%\AppData\Roaming\Microsoft\Windows\SendTo
set bin_url=https://raw.githubusercontent.com/SatouShinrin/AnimeScript/main/bin
set avdump_url=https://raw.githubusercontent.com/SatouShinrin/AnimeScript/main/bin/Avdump3
set crcmanip_url=https://raw.githubusercontent.com/SatouShinrin/AnimeScript/main/bin/crcmanip
set batch_url=https://raw.githubusercontent.com/SatouShinrin/AnimeScript/main/batch
set vbs_url=https://raw.githubusercontent.com/SatouShinrin/AnimeScript/main/batch/vbs
set icon_url=https://raw.githubusercontent.com/SatouShinrin/AnimeScript/main/icon
set context_menu_url=https://raw.githubusercontent.com/SatouShinrin/AutoScript/main/menu

REM List of files to download
set bin= ^
ffmpeg.exe ^
ffprobe.exe ^
rhash.exe ^
scxvid.exe

set batch= ^
Add_CRC.bat ^
Checksum.bat ^
Create_Ed2kLink.bat ^
Create_Keyframes.bat ^
Dump_Anime.bat ^
Create_Chapters.bat

set icon= ^
dump_icon.ico ^
ed2klink_icon.ico ^
anidb_icon.ico ^
hash_icon.ico ^
chapter_icon.ico ^
keyframe_icon.ico

set avdump= ^
AVD3AniDBModule.dll ^
AVDump3CL.dll ^
AVDump3CL.exe ^
AVDump3CL.runtimeconfig.json ^
AVDump3Lib.dll ^
AVDump3NativeLib.dll ^
AVDump3NativeLib-aarch64.so ^
AVDump3NativeLib-x64.so ^
AVDump3UI.dll ^
BXmlLib.dll ^
ExtKnot.StringInvariants.dll ^
Ionic.Zlib.Core.dll ^
MediaInfo.dll ^
MediaInfo-aarch64.so ^
MediaInfo-x64.so ^
Microsoft.CodeAnalysis.CSharp.dll ^
Microsoft.CodeAnalysis.CSharp.Scripting.dll ^
Microsoft.CodeAnalysis.dll ^
Microsoft.CodeAnalysis.Scripting.dll ^
Microsoft.Extensions.DependencyInjection.Abstractions.dll ^
Microsoft.Extensions.DependencyInjection.dll ^
Microsoft.Extensions.Logging.Abstractions.dll ^
Microsoft.Extensions.Logging.dll ^
Microsoft.Extensions.Options.dll ^
Microsoft.Extensions.Primitives.dll ^
Newtonsoft.Json.dll ^
Serilog.dll ^
Serilog.Extensions.Logging.dll

set crc_mod= ^
crcmanip.exe ^
libgcc_s_sjlj-1.dll ^
libpng16-16.dll ^
libstdc++-6.dll ^
libwinpthread-1.dll

set vbs= ^
Add_CRC.vbs ^
Create_Chapters.vbs

set context_menu= ^
Add.reg ^
Remove.reg

echo #################################################
echo #						#
echo # 		Shinrin's Scripts		#
echo #						#
echo #################################################
echo.

if not exist "%install_dir%" md "%install_dir%" 
if not exist "%install_dir%\bin" md "%install_dir%\bin" 
if not exist "%install_dir%\bin\Avdump3" md "%install_dir%\bin\Avdump3" 
if not exist "%install_dir%\bin\crcmanip" md "%install_dir%\bin\crcmanip" 
if not exist "%install_dir%\batch" md "%install_dir%\batch"
if not exist "%install_dir%\batch\vbs" md "%install_dir%\batch\vbs"
if not exist "%install_dir%\icon" md "%install_dir%\icon"
echo.

set /p overwrite="Do you want to overwrite or update all existing files? (y/n): "
echo.

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo #################################################
REM echo #						#
echo #						#
echo # 		Shinrin's Scripts		#
REM echo #						#
echo #						#
echo #################################################
echo.

for %%a in (%bin%) do (
     if exist "%install_dir%\bin\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %bin_url%/%%a "%install_dir%\bin\%%a" && echo Overwrote %%a
     if exist "%install_dir%\bin\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
     if not exist "%install_dir%\bin\%%a" powershell Start-BitsTransfer %bin_url%/%%a "%install_dir%\bin\%%a" && echo Completed transfer %%a from repository.
)

for %%a in (%batch%) do (
    if exist "%install_dir%\batch\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %batch_url%/%%a "%install_dir%\batch\%%a" && echo Overwrote %%a
    if exist "%install_dir%\batch\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
    if not exist "%install_dir%\batch\%%a" powershell Start-BitsTransfer %batch_url%/%%a "%install_dir%\batch\%%a" && echo Completed transfer %%a from repository.
)

for %%a in (%vbs%) do (
    if exist "%install_dir%\batch\vbs\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %vbs_url%/%%a "%install_dir%\batch\vbs\%%a" && echo Overwrote %%a
    if exist "%install_dir%\batch\vbs\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
    if not exist "%install_dir%\batch\vbs\%%a" powershell Start-BitsTransfer %vbs_url%/%%a "%install_dir%\batch\vbs\%%a" && echo Completed transfer %%a from repository.
)

for %%a in (%icon%) do (
    if exist "%install_dir%\icon\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %icon_url%/%%a "%install_dir%\icon\%%a" && echo Overwrote %%a
    if exist "%install_dir%\icon\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
    if not exist "%install_dir%\icon\%%a" powershell Start-BitsTransfer %icon_url%/%%a "%install_dir%\icon\%%a" && echo Completed transfer %%a from repository.
)

for %%a in (%context_menu%) do (
     if exist "%install_dir%\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %context_menu_url%/%%a "%install_dir%\%%a" && echo Overwrote %%a context menu
     if exist "%install_dir%\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
     if not exist "%install_dir%\%%a" powershell Start-BitsTransfer %context_menu_url%/%%a "%install_dir%\%%a" && echo Completed transfer %%a context menu from repository.
)

for %%a in (%crc_mod%) do (
     if exist "%install_dir%\bin\crcmanip\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %crcmanip_url%/%%a "%install_dir%\bin\crcmanip\%%a" && echo Overwrote %%a
     if exist "%install_dir%\bin\crcmanip\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
     if not exist "%install_dir%\bin\crcmanip\%%a" powershell Start-BitsTransfer %crcmanip_url%/%%a "%install_dir%\bin\crcmanip\%%a" && echo Completed transfer %%a from repository.
)

echo.
echo Transfering Avdump from repository, please wait a few seconds. DO NOT TURN OFF THIS CMD
for %%a in (%avdump%) do (
     if exist "%install_dir%\bin\Avdump3\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %avdump_url%/%%a "%install_dir%\bin\Avdump3\%%a" && echo Overwrote %%a
     if exist "%install_dir%\bin\Avdump3\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
     if not exist "%install_dir%\bin\Avdump3\%%a" powershell Start-BitsTransfer %avdump_url%/%%a "%install_dir%\bin\Avdump3\%%a" && echo Completed transfer %%a from repository.
)

CLS
echo.
echo.
echo.
set /p choice="Do you want to add the Batch files to the SendTo folder? (y/n): "
echo.

if "%choice%"=="y" (
    :same
    for %%a in (%batch%) do (
        if exist "%sendto_path%\%%a" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %batch_url%/%%a "%sendto_path%\%%a" && echo Overwrote %%a
        if exist "%sendto_path%\%%a" if /I "%overwrite%"=="n" echo Skipped %%a
        if not exist "%sendto_path%\%%a" powershell Start-BitsTransfer %batch_url%/%%a "%sendto_path%/%%a" && echo Completed transfer %%a from repository.
   )
   goto end
) else if "%choice%"=="Y" (
    goto same
)
) else (
    echo Please go to the path C:\Tools and open the Add.reg file.
    echo.
    echo If you want to remove it after adding, open the Remove.reg file.
)
:end
echo.
echo Finished! ~ Script by Shinrin - Have fun!
echo.
pause


