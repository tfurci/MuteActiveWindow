@echo off

set "rootFolder=%~dp0"
set "scriptFolder=%rootFolder%..\"
set "configFolder=%scriptFolder%Config"

set "mawMuterPath=%scriptFolder%\maw-muter.exe"
set "mawmuterahkPath=%scriptFolder%\maw-muter.ahk"

where powershell >nul 2>&1
if %errorlevel% neq 0 (
    echo Configurator cannot be run because PowerShell is not installed.
    choice /C YN /M "Do you want to open GitHub repository for manual update? [Y/N]: "
    if not errorlevel 2 start https://github.com/tfurci/muteactivewindow
    exit
)

set "argumentFlag=%~1"
if /i "%argumentFlag%"=="-3" (
    goto runmawmuterahkenabler
) else (
    echo Command line argument is not valid.
)

:menu
set "choice="
cls
echo ========================
echo  MuteActiveWindow Configurator
echo ========================
echo  1. Change Keybind
echo  2. Change Muting Method
echo  3. Enable Maw-Muter.ahk method
echo  4. Force restart MuteActiveWindow
echo  5. Enable/Disable Beta Updates
echo  0. Exit
echo ========================
set /p choice=Enter your choice (0-5): 

if "%choice%"=="1" (
    set "choice="
    goto runupdatehotkey
) else if "%choice%"=="2" (
    set "choice="
    goto runmutingmethodchanger
) else if "%choice%"=="3" (
    set "choice="
    goto runmawmuterahkenabler
) else if "%choice%"=="4" (
    set "choice="
    goto forcerestartmaw
) else if "%choice%"=="5" (
    set "choice="
    goto enabledisablebetaupdates
) else if "%choice%"=="0" (
    echo Exiting...
    exit /b 0
) else (
    set "choice="
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

REM Check if user input is not empty
if not "%newHotkey%"=="" (
    REM Clear existing Hotkey.txt by creating an empty file
    type nul > "%hotkeyFile%"

    REM Write the new hotkey to Hotkey.txt
    (echo(%newHotkey%) > "%hotkeyFile%"

    echo Hotkey has been updated to: %newHotkey%
    start "" "%scriptFolder%\MuteActiveWindow.ahk"
) else (
    echo No changes made to the hotkey.
)
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
set "search4=;ahkmethod"
set "replace4=ahkmethod"

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
powershell -Command "& {(Get-Content '%filename1%' -Raw) -replace [regex]::Escape('%search1%'), '%replace1%' -replace [regex]::Escape('%search2%'), '%replace2%' -replace [regex]::Escape('%search3%'), '%replace3%' -replace [regex]::Escape('%search4%'), '%replace4%' | Set-Content '%filename1%'}"

start "" "%scriptFolder%\MuteActiveWindow.ahk"
echo. maw-muter.ahk muting method enabled
pause
if /i "%argumentFlag%"=="-3" (
    exit /b 0
) else (
    goto menu
)

:runmutingmethodchanger

cls
rem Set the path for the MutingConfigFile
set "MutingConfigFile=%configFolder%\SelectMutingMethod.txt"

rem Get the current method number from the text file
set /P currentMethod=<"%MutingConfigFile%"
set "currentMethodName="
if "%currentMethod%"=="2" (
    set "currentMethodName=svcl.exe"
) else if "%currentMethod%"=="1" (
    set "currentMethodName=maw-muter.exe"
) else if "%currentMethod%"=="3" (
    set "currentMethodName=maw-muter.ahk"
)

echo ========================
echo  Change muting method
echo ========================
echo.
echo Currently selected method: %currentMethodName%
echo.
echo Select Muting Method:
echo 1. maw-muter.ahk (newest, based of VA.ahk & mute_current_application's fix made by tfurci, fastest, built into .ahk)
echo 2. maw-muter.exe (default, open source, works for most apps)
echo 3. svcl.exe (Will open browser and automaticall donwload .zip file then just extract it to script's root folder)
echo.
echo 4. Return to Menu
echo.

rem Prompt the user for their choice
set /p choice="Enter your choice (1-4): "

rem Validate the user input and set the selectedMethod variable accordingly
if "%choice%"=="1" (
    set "selectedMethod=3"
    call :updateScript "%mawmuterahkPath%" "https://raw.githubusercontent.com/tfurci/maw-muter/main/maw-muter_AHK/maw-muter.ahk"
) else if "%choice%"=="2" (
    set "selectedMethod=1"
    call :updateScript "%mawMuterPath%" "https://github.com/tfurci/maw-muter/releases/latest/download/maw-muter.exe"
) else if "%choice%"=="3" (
    set "selectedMethod=2"
    explorer "https://www.nirsoft.net/utils/svcl-x64.zip"
    pause
) else if "%choice%"=="4" (
    set "choice="
    goto menu
) else (
    echo Invalid choice
    set "choice="
    goto menu
)

rem Use PowerShell to replace the content of the first line in the text file
powershell -Command "(Get-Content '%MutingConfigFile%') | ForEach-Object { if ($_.ReadCount -eq 1) { '%selectedMethod%' } else { $_ } } | Set-Content '%MutingConfigFile%'"

echo Muting method sucesfully changed.
if "%choice%"=="1" (
    goto runmawmuterahkenabler
)
start "" "%scriptFolder%\MuteActiveWindow.ahk"
pause
goto menu

:forcerestartmaw
rem Taskkill AutoHotkeyU64.exe asynchronously
start /b taskkill /f /im AutoHotkeyU64.exe >nul 2>&1

rem Run MuteActiveWindow.ahk
start "" "%scriptFolder%\MuteActiveWindow.ahk"
echo MuteActiveWindow force restarted!
pause
goto menu

:enabledisablebetaupdates
set "BetaConfigFile=%configFolder%\EnableBetaUpdates.txt"
cls
echo ========================
echo  Enable/Disable beta updates
echo ========================
echo.
echo Select Beta Update Option:
echo 1. Enable BETA updates
echo 2. Disable BETA updates
echo.

rem Display if beta updates are enabled
set /P betaStatus=<"%BetaConfigFile%"
set "betaStatusName="
if "%betaStatus%"=="1" (
    set "betaStatusName=Enabled"
) else if "%betaStatus%"=="0" (
    set "betaStatusName=Disabled"
) else (
    set "betaStatusName=Unknown"
)

echo Beta updates currently: %betaStatusName%
echo.

rem Prompt the user for their choice
set /p choice="Enter your choice (1-2): "


rem Validate the user input and set the selectedMethod variable accordingly
if "%choice%"=="1" (
    set "betachoice=1"
) else if "%choice%"=="2" (
    set "betachoice=0"
) else (
    echo Invalid choice
    exit /b 1
)

rem Use PowerShell to replace the content of the first line in the text file
powershell -Command "(Get-Content '%BetaConfigFile%') | ForEach-Object { if ($_.ReadCount -eq 1) { '%betachoice%' } else { $_ } } | Set-Content '%BetaConfigFile%'"

if "%choice%"=="1" (
    echo Beta updates enabled!
) else if "%choice%"=="2" (
    echo Beta updates disabled!
)
start "" "%scriptFolder%\MuteActiveWindow.ahk"
pause
goto menu

:updateScript
set "localPath=%~1"
set "url=%~2"
echo Updating %~nx1...

curl -L -k -o "%localPath%.temp" "%url%"
fc "%localPath%.temp" "%localPath%" > nul
if errorlevel 1 (
    move /y "%localPath%.temp" "%localPath%" > nul
    echo Updated %~nx1.
) else (
    del "%localPath%.temp"
    echo %~nx1 is already up to date.
)
goto :eof