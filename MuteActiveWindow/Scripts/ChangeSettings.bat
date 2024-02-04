@echo off
:menu

set "rootFolder=%~dp0"
set "scriptFolder=%rootFolder%..\"
set "configFolder=%scriptFolder%Config"

cls
echo ========================
echo  MuteActiveWindow config
echo ========================
echo  1. Change Keybind
echo  2. Change Muting Method
echo  3. Option 3
echo  4. Option 4
echo  5. Option 5
echo  0. Exit
echo ========================
set /p choice=Enter your choice (0-5): 

if "%choice%"=="1" (
    goto runupdatehotkey
) else if "%choice%"=="2" (
    goto runupdatemutingmethod
) else if "%choice%"=="3" (
    goto test3
) else if "%choice%"=="4" (
    goto test4
) else if "%choice%"=="5" (
    goto test5
) else if "%choice%"=="0" (
    echo Exiting...
    exit /b 0
) else (
    echo Invalid choice. Please enter a valid option.
    pause
    goto menu
)

:runupdatehotkey
cls
echo ========================
echo  Update Hotkey
echo ========================
set "hotkeyFile=%configFolder%\Hotkey.txt"

if exist "%hotkeyFile%" (
    set /p currentHotkey=<"%hotkeyFile%" > nul
    echo Current Hotkey: & for /f "usebackq delims=" %%a in ("%hotkeyFile%") do echo %%a
) else (
    echo Hotkey file not found.
)
echo.
echo For combined keybind: + is SHIFT, ! is ALT, # is WIN, ^ is CTRL
echo so SHIFT+F1 would be: +F1
echo.
set /p newHotkey=Enter the new hotkey:

REM Clear existing Hotkey.txt by creating an empty file
type nul > "%hotkeyFile%"

REM Write the new hotkey to Hotkey.txt
(echo(%newHotkey%) > "%hotkeyFile%"

echo Hotkey has been updated to: %newHotkey%
pause
goto menu

:runupdatemutingmethod
rem Test 2 code here
echo Running script for Option 2
rem Add your script/command for Option 2 here
pause
goto menu

:test3
rem Test 3 code here
echo Running script for Option 3
rem Add your script/command for Option 3 here
pause
goto menu

:test4
rem Test 4 code here
echo Running script for Option 4
rem Add your script/command for Option 4 here
pause
goto menu

:test5
rem Test 5 code here
echo Running script for Option 5
rem Add your script/command for Option 5 here
pause
goto menu
