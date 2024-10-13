@echo off
setlocal enabledelayedexpansion
set "rhash_path=C:\Tools\bin\rhash.exe"

if not exist "%rhash_path%" (
    echo rhash not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select at least one video file for conversion.
    pause
    exit /b
)

set "filename=%~1"

:: Checksum
for %%f in (%*) do (
    set "file=%%~f"

    :: Get file name and size
    set "filename=%%~nxf"

    :: Get checksums
    for /f "tokens=1" %%A in ('%rhash_path% --crc32 --simple --uppercase %%f') do (
        set "crc32=%%A"
    )
)
echo %filename% | findstr /c:"%crc32%" >nul
if %errorlevel% equ 0 (
    exit /b 1
)

for %%F in ("%filename%") do (
    set "name=%%~nF"
    set "ext=%%~xF"
)

set "newfilename=!name! [!crc32!]!ext!"
rename "%filename%" "!newfilename!"
exit /b 1