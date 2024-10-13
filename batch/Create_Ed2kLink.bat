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
    echo Please select at least one file.
    pause
    exit /b
)

:: Send files to cmd
for %%f in (%*) do (
    set "file=%%~f"

    :: Get file name and size
    for %%a in ("!file!") do (
        set "filename=%%~nxa"
        set "filesize=%%~za"
    )

    for /f "tokens=1" %%A in ('%rhash_path% --ed2k --simple --uppercase "!file!"') do (
    set ed2khash=%%A
    )
    echo ed2k://^|file^|!filename!^|!filesize!^|!ed2khash!^|/
)
pause>nul
exit /b
