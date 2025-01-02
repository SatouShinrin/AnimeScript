@echo off
setlocal enabledelayedexpansion
:: Script by Shinrin

:: Check if no file was selected
if "%~1"=="" (
    echo Please input timestamp .ass file.
    exit /b 1
)

:: Setup files
set "input_file=%~1"
set output_txt=%~n1_temp.txt
set output_file=%~n1.xml

:: Validate files
if exist "%output_txt%" (
    del "%output_txt%"
)

if exist "%output_file%" (
    del "%output_file%"
)

:: Generate Chapter's Header
set doctype="^<^!-- ^<^!DOCTYPE Chapters SYSTEM "matroskachapters.dtd"^> --^>"
set "doctype=!doctype:~1,-1!"

echo ^<?xml version="1.0" encoding="UTF-8"?^> >> "%output_txt%"
echo ^!doctype! >> "%output_txt%"
echo ^<Chapters^> >> "%output_txt%"
echo   ^<EditionEntry^> >> "%output_txt%"
echo     ^<EditionFlagHidden^>0^</EditionFlagHidden^> >> "%output_txt%"
echo     ^<EditionFlagDefault^>0^</EditionFlagDefault^> >> "%output_txt%"
echo     ^<EditionUID^>%random%%random%^</EditionUID^> >> "%output_txt%"

:: Read file
for /f "delims=" %%A in ('findstr /b /c:"Comment:" /c:"Dialogue:" "%input_file%"') do (
    set line=%%A

    :: Split fields
    set field=0
    set field3=
    set field6=
    set field10=

    for %%B in (!line!) do (
        set /a field+=1
        if !field! equ 3 set field3=%%B
        if !field! equ 6 set field6=%%B
    )

    :: Last field
    set "remaining_line=!line!"
    set "remaining_line=!remaining_line:*,,=!"
    set field10=!remaining_line!

    if /i "!field6!"=="Chapter" if defined field3 if defined field6 if defined field10 (
	:: Random uid
    	set /a uid1=!random!
	set /a uid2=!random!

	echo     ^<ChapterAtom^> >> "%output_txt%"
 	echo       ^<ChapterUID^>!uid1!!uid2!^</ChapterUID^> >> "%output_txt%"
	echo       ^<ChapterTimeStart^>!field3!0000000^</ChapterTimeStart^> >> "%output_txt%"
	echo     ^<ChapterFlagHidden^>0^</ChapterFlagHidden^> >> "%output_txt%"
	echo     ^<ChapterFlagEnabled^>1^</ChapterFlagEnabled^> >> "%output_txt%"
	echo       ^<ChapterDisplay^> >> "%output_txt%"
	echo         ^<ChapterString^>!field10!^</ChapterString^> >> "%output_txt%"
	echo         ^<ChapterLanguage^>und^</ChapterLanguage^> >> "%output_txt%"
	echo         ^<ChapLanguageIETF^>und^</ChapLanguageIETF^> >> "%output_txt%"
	echo       ^</ChapterDisplay^> >> "%output_txt%"
	echo     ^</ChapterAtom^> >> "%output_txt%"
    ) 
)
echo   ^</EditionEntry^> >> "%output_txt%"
echo ^</Chapters^> >> "%output_txt%"

:: Change Extension
ren "%output_txt%" "%output_file%"
exit /b 0
