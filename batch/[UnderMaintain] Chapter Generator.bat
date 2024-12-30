@echo off
setlocal enabledelayedexpansion

:: Kiểm tra xem có tham số đầu vào (file) không
if "%~1"=="" (
    echo Vui long keo file vao script!
    pause
    exit /b
)

:: Lấy tên file đầu vào từ tham số đầu tiên
set "input_file=%~1"
set "output_file=output.txt"

:: Kiểm tra xem tệp input có tồn tại không
if not exist "%input_file%" (
    echo Tệp %input_file% không tồn tại.
    pause
    exit /b
)

:: Xóa tệp output nếu đã tồn tại
if exist "%output_file%" del "%output_file%"

:: Đọc tất cả các dòng trong file và thay dấu "," thành " - ", rồi trích ra trường 3, 4, 6, 10
for /f "delims=" %%A in ('findstr /b /c:"Comment:" /c:"Dialogue:" "%input_file%"') do (
    set line=%%A

    :: Tách dòng thành các trường, không thay dấu phẩy đầu dòng
    set field=0
    set field3=
    set field4=
    set field6=
    set field10=

    for %%B in (!line!) do (
        set /a field+=1
        if !field! equ 3 set field3=%%B
        if !field! equ 4 set field4=%%B
        if !field! equ 6 set field6=%%B
    )

    :: Xử lý trường 10: lấy phần còn lại của dòng sau khi tách các trường 1 đến 9
    set "remaining_line=!line!"
    set "remaining_line=!remaining_line:*,,=!"

    :: Gán giá trị trường 10 là phần còn lại sau dấu phẩy thứ 9
    set field10=!remaining_line!

    :: Kiểm tra nếu trường 6 chứa "Chapter" và các trường khác có giá trị
    if /i "!field6!"=="Chapter" if defined field3 if defined field4 if defined field6 if defined field10 (
        :: In kết quả với dấu " - "
        echo !field3! - !field4! - !field6! - !field10! >> "%output_file%"
    )
)

echo Đã xuất xong vào file "%output_file%"
pause
