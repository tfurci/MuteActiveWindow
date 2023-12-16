@echo off
if "%~1"=="admin" goto gotAdmin

:: Check for administrative permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Administrative privileges are required to run this script.
    :prompt
    choice /C YN /M "Do you want to run this script as an administrator? [Y/N]: "
    if errorlevel 2 (
        echo Script execution cancelled.
        pause
        exit /B
    )
    if errorlevel 1 (
        goto UACPrompt
    )
) else ( 
    goto gotAdmin 
)


:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~0", "admin", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

set "ScriptDir=%~dp0..\"    :: Navigate up one directory
set "ScriptName=MuteActiveWindow.ahk"
set "ShortcutName=MuteActiveWindow.lnk"
set "StartupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Check if the script file exists in the source directory
if not exist "%ScriptDir%%ScriptName%" (
    echo The script file "%ScriptName%" does not exist in this directory.
    pause
    exit /b
)

:: Check if the shortcut already exists in the startup folder
if exist "%StartupFolder%%ShortcutName%" (
    del "%StartupFolder%%ShortcutName%"
    echo The existing shortcut "%ShortcutName%" has been deleted so a new one can be created.
)

:: Create a symbolic link (shortcut) to the script in the startup folder
mklink "%StartupFolder%%ShortcutName%" "%ScriptDir%%ScriptName%"

echo The shortcut "%ShortcutName%" has been successfully created in the startup folder.
pause