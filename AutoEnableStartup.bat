@echo off

:: Define the source and destination paths
set "ScriptDir=%~dp0"
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
if exist "%StartupFolder%\%ShortcutName%" (
    echo The shortcut "%ShortcutName%" already exists in the startup folder.
    pause
    exit /b
)

:: Create a symbolic link (shortcut) to the script in the startup folder
mklink "%StartupFolder%\%ShortcutName%" "%ScriptDir%%ScriptName%"

echo The shortcut "%ShortcutName%" has been successfully created in the startup folder.
pause
