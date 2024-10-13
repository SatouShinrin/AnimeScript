@echo off
setlocal enabledelayedexpansion

set "rhash_path=C:\Tools\bin\rhash.exe"
set "crcmanip_path=C:\Tools\bin\crcmanip\crcmanip.exe"

if not exist "%rhash_path%" (
    echo rhash not found! Please check the path.
    pause
    exit /b
)

if not exist "%crcmanip_path%" (
    echo crcmanip not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select at least one file.
    pause
    exit /b
)

:: Create new_crc directory if it doesn't exist
if not exist "new_crc" (
    mkdir "new_crc"
)

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
    :input
    echo.
    echo Filename: !filename!
    echo The CRC32 of this file is: !crc32!
    echo.
set /p "input=Input your 8 hex characters (a-f, A-F or 0-9): "

rem Check stringlength
if not "!input:~8,1!"=="" (
    echo Too long, just 8 letters or numbers
    CLS
    goto input
)
if "!input:~7,1!"=="" (
    echo Too short, need to be exact to 8 letters or numbers.
    goto input
)

rem Check valid characters
set "valid=abcdefABCDEF0123456789"
set "invalid="
for /L %%i in (0,1,7) do (
    set "char=!input:~%%i,1!"
    echo !valid! | findstr /C:"!char!" >nul || set "invalid=1"
)

if defined invalid (
    echo.
    echo Invalid character detected. Please input only hex characters. Try Again?
    pause
    CLS
    goto input
)

:: Create the output file in the new_crc folder
set "output_file=new_crc\!filename!"
%crcmanip_path% -p !file! "!output_file!" !input!
exit /b 1