@echo off
echo.
echo ===============================
echo        System Information
echo ===============================
echo.
echo Current Time: %TIME%
echo.
echo Operating System: %OS%
echo.
echo Processor: %PROCESSOR_IDENTIFIER%
echo.
pause

:menu
cls
echo ===========================
echo        Mat's Terminal
echo ===========================

echo 1. Stop a Program
echo 2. Start a Program
echo 3. Create Command
echo 4. Online Devices
echo 5. Networks Near Me
echo 6. Command Tweener
echo 7. Command Spoofer
echo 8. Exit Terminal
echo 9. Termsploit
echo ===========================
set /p choice="Enter your choice: "

if "%choice%"=="1" goto stop
if "%choice%"=="2" goto start
if "%choice%"=="3" goto create
if "%choice%"=="4" goto online_devices
if "%choice%"=="5" goto networks_near_me
if "%choice%"=="6" goto command_tweener
if "%choice%"=="7" goto command_spoofer
if "%choice%"=="8" goto exit
if "%choice%"=="9" goto termsploit

:: Check for custom commands
for /f "tokens=1,2 delims=:" %%a in ('findstr /b /c:"if %choice%==" custom_commands.txt') do (
    if "%choice%"=="%%a" goto %%b
)

goto menu

:stop
set /p process="Enter the process name to stop: "
taskkill /IM "%process%" /F
echo %process% has been stopped.
pause
goto menu

:start
set /p app="Enter the application to start: "
start "" "%app%"
echo %app% has been started.
pause
goto menu

:create
set /p title="Enter the command title: "
set /p code="Enter the batch code: "
echo %code% > "%title%.bat"
echo Command %title% created.
if not exist custom_commands.txt (
    echo if %%choice%%==9 goto %title% > custom_commands.txt
) else (
    findstr /b /c:"if %%choice%%==9 goto %title%" custom_commands.txt >nul || (
        echo if %%choice%%==9 goto %title% >> custom_commands.txt
    )
)
echo :%title% >> custom_commands.txt
echo %code% >> custom_commands.txt
echo pause >> custom_commands.txt
echo goto menu >> custom_commands.txt
echo Custom command %title% added to menu.
pause
goto menu

:online_devices
echo Listing online devices...
arp -a
pause
goto menu

:networks_near_me
echo Listing networks near you...
netsh wlan show networks
pause
goto menu

:command_tweener
set /p title="Enter the command title to edit: "

:: Check if the command exists
findstr /b /c:"if %%choice%%==9 goto %title%" custom_commands.txt >nul
if errorlevel 1 (
    echo Command %title% not found.
    pause
    goto menu
)

:: Read current code
for /f "tokens=*" %%i in ('findstr /r "^:%title%$" custom_commands.txt') do set "old_code_start=%%i"
set /p old_code="Enter new code (existing code is: %old_code_start%): "
echo %old_code% > "%title%.bat"
echo Command %title% updated.
pause
goto menu

:command_spoofer
set /p title="Enter the command title to edit: "

:: Check if the command exists
findstr /b /c:"if %%choice%%==9 goto %title%" custom_commands.txt >nul
if errorlevel 1 (
    echo Command %title% not found.
    pause
    goto menu
)

:: Read current code
setlocal enabledelayedexpansion
for /f "tokens=*" %%i in ('findstr /r "^:%title%$" custom_commands.txt') do (
    set "line=%%i"
    if defined line (
        set "current_code=!line:~0,-1!"
        set "current_code=!current_code!"
    )
)
endlocal

:: Ask for new code type
echo Current code is: %current_code%
set /p new_type="Enter the new code type (e.g., python, batch): "

:: Create a new file with the new code type
if "%new_type%"=="python" (
    echo print("This is a Python script") > "%title%.py"
) else if "%new_type%"=="batch" (
    echo @echo off > "%title%.bat"
    echo echo This is a Batch script >> "%title%.bat"
) else (
    echo Unsupported code type.
)

echo Command %title% updated to %new_type% code.
pause
goto menu

:termsploit
echo WARNING: You are about to execute the TermSploit module.
echo This option is intended for experimental and exploitative purposes.
echo Proceed with extreme caution.
pause
set /p exploit_code="Enter the code to execute: "
echo Executing: %exploit_code%
%exploit_code%
pause
goto menu

:exit
exit






 
