@echo off
:menu

set "rootFolder=%~dp0"
set "scriptFolder=%rootFolder%..\"
set "configFolder=%scriptFolder%Config"

cls
echo ========================
echo  MuteActiveWindow Configurator
echo ========================
echo  1. Change Keybind
echo  2. Change Muting Method
echo  3. Enable Maw-Muter.ahk method
echo  4. Option 4
echo  5. Option 5
echo  0. Exit
echo ========================
set /p choice=Enter your choice (0-5): 

if "%choice%"=="1" (
    goto runupdatehotkey
) else if "%choice%"=="2" (
    goto test2
) else if "%choice%"=="3" (
    goto runmawmuterahkenabler
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

:runmawmuterahkenabler
cls
echo ========================
echo  Enable MAW-MUTER.ahk
echo ========================

set "filename1=%scriptFolder%MuteActiveWindow.ahk"
set "outfile=%scriptFolder%tempFile.ahk"
set "search1=;MAWAHK(exeName)"
set "replace1=MAWAHK(exeName)"
set "search2=;MAWAHK(uwpprocess)"
set "replace2=MAWAHK(uwpprocess)"
set "search3=;#Include"
set "replace3=#Include"

rem Check if maw-muter.ahk exists in the script folder
if not exist "%scriptFolder%maw-muter.ahk" (
    echo maw-muter.ahk not found in the script folder.
    pause
    goto menu
)

rem Read the first line of SelectMutingMethod.txt in the config folder
set "MuteconfigFile=%configFolder%\SelectMutingMethod.txt"
if not exist "%MuteconfigFile%" (
    echo SelectMutingMethod.txt not found in the config folder.
    pause
    goto menu
)

set /p mutingMethod=<"%MuteconfigFile%"

rem Check if the muting method is set to 3 (assuming it's a numeric value)
if "%mutingMethod%" neq "3" (
    echo Muting method is not set to 3 in SelectMutingMethod.txt.
    pause
    goto menu
)

rem Perform the search and replace operations
powershell -Command "& {(Get-Content '%filename1%' -Raw) -replace [regex]::Escape('%search1%'), '%replace1%' -replace [regex]::Escape('%search2%'), '%replace2%' -replace [regex]::Escape('%search3%'), '%replace3%' | Set-Content '%filename1%'}"

echo. maw-muter.ahk muting method enabled
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
