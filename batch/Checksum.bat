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

echo.
echo ~ Checksum via CLI - Please Wait ~
echo.

:: Checksum
for %%f in (%*) do (
    set "file=%%~f"

    :: Get file name and size
    set "filename=%%~nxf"

    :: Get checksums
    for /f "tokens=1" %%A in ('%rhash_path% --crc32 --simple --uppercase %%f') do (
        set "crc32=%%A"
    )

    for /f "tokens=1" %%A in ('%rhash_path% --md5 --simple --uppercase %%f') do (
        set "md5=%%A"
    )

    for /f "tokens=1" %%A in ('%rhash_path% --sha1 --simple --uppercase %%f') do (
        set "sha1=%%A"
    )

    for /f "tokens=1" %%A in ('%rhash_path% --ed2k --simple --uppercase %%f') do (
        set "ed2khash=%%A"
    )
    
    :: Output results with delayed expansion
    echo Checksum: !filename!
    echo CRC32: !crc32!
    echo MD5: !md5!
    echo SHA1: !sha1!
    echo ed2k: !ed2khash!
    echo.
)
pause>nul
