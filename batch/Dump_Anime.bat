@echo off
setlocal

set "avdump3_path=C:\Tools\bin\Avdump3\Avdump3CL.exe"
set "username=Your_AniDB_Username"
set "api_key=Your_AniDB_API_Key"

:: Check if avdump3 exists
if not exist "%avdump3_path%" (
    echo Avdump3CL not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select a video file for extraction.
    pause
    exit /b
)

:: Check if the username is still set to the default value
if "%username%"=="Your_AniDB_Username" (
    echo Wait, your AniDB username is not available. You cannot use this script.
    pause
    goto end
)

:: Check if the API key is still set to the default value
if "%api_key%"=="Your_AniDB_API_Key" (
    echo Wait, your AniDB API key is not available. You cannot use this script.
    pause
    goto end
)

:: Get the input file and its directory and name
set "file=%~1"

%avdump3_path% --Auth="%username%:%api_key%" "%file%"
pause
:end
exit /b
