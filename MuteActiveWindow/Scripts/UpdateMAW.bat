@echo off
setlocal enabledelayedexpansion

set "currentDir=%~dp0"
set "rootDir=%currentDir%.."

:: Define a list of unnecessary files to be deleted
set "filesToDelete=Scripts\BatUpdater.bat"

where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Auto-update cannot be performed because curl is not installed.
    choice /C YN /M "Do you want to open github repository to manually update MAW? [Y/N]: "
    if errorlevel 2 (
        exit
    )
    if errorlevel 1 (
        start https://github.com/tfurci/muteactivewindow
        exit
    )
) else (
    echo Starting MAW Updater script.......
)

echo.
:: Loop through each file in the list
for %%f in (%filesToDelete%) do (
    echo Removing unnecessary files...
    if exist "%rootDir%\%%f" (
        del "%rootDir%\%%f"
        echo Deleted %%f
    ) else (
        echo %%f not found.
    )
)
echo.

set "betaFlag=%~1"
if /i "%betaFlag%"=="-beta" (
    set "githubAESScriptURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/beta/MuteActiveWindow/Scripts/AutoEnableStartup.bat"
) else (
    set "githubAESScriptURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/Scripts/AutoEnableStartup.bat"
)
:: Specify the full path to the local main script file
set "localAESScriptPath=%rootDir%\Scripts\AutoEnableStartup.bat"

:: Ensure that the local "Scripts" directory exists
md "%rootDir%" 2>nul

:: Download and update the main script from GitHub
curl -k -o "%localAESScriptPath%.temp" "%githubAESScriptURL%"

:: Compare the content of the downloaded main script file with the local file
fc "%localAESScriptPath%.temp" "%localAESScriptPath%" > nul

if errorlevel 1 (
    echo.
    echo AutoEnableStartup script downloaded and updated.
    move /y "%localAESScriptPath%.temp" "%localAESScriptPath%" > nul
    echo.
) else (
    echo.
    echo AutoEnableStartup script is already on the latest version.
    del "%localAESScriptPath%.temp"
    echo.
)

set "betaFlag=%~1"
if /i "%betaFlag%"=="-beta" (
    set "githubMainScriptURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/beta/MuteActiveWindow/MuteActiveWindow.ahk"
) else (
    set "githubMainScriptURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow/main/MuteActiveWindow/MuteActiveWindow.ahk"
)

:: Specify the full path to the local main script file
set "localMainScriptPath=%rootDir%\MuteActiveWindow.ahk"

:: Ensure that the local "Scripts" directory exists
md "%rootDir%" 2>nul

:: Download and update the main script from GitHub
curl -k -o "%localMainScriptPath%.temp" "%githubMainScriptURL%"

:: Compare the content of the downloaded main script file with the local file
fc "%localMainScriptPath%.temp" "%localMainScriptPath%" > nul

if errorlevel 1 (
    echo.
    echo Main script downloaded and updated.
    move /y "%localMainScriptPath%.temp" "%localMainScriptPath%" > nul
    echo.
) else (
    echo.
    echo Main script is already on the latest version.
    del "%localMainScriptPath%.temp"
    echo.
)

:: Specify the full path to the maw-muter.exe file
set "localMawMuterPath=%rootDir%\maw-muter.exe"

:: Specify the URL for the latest version of maw-muter.exe on GitHub
set "githubMawMuterURL=https://github.com/tfurci/maw-muter/releases/latest/download/maw-muter.exe"

:: Check if maw-muter.exe exists in the scripts directory
if exist "%localMawMuterPath%" (
    echo Updating maw-muter.exe...
    curl -L -o "%localMawMuterPath%.temp" "%githubMawMuterURL%"
    
    :: Compare the content of the downloaded maw-muter.exe file with the local file
    fc "%localMawMuterPath%.temp" "%localMawMuterPath%" > nul
	echo.
    if errorlevel 1 (
        move /y "%localMawMuterPath%.temp" "%localMawMuterPath%" > nul
        echo maw-muter.exe updated successfully.
    ) else (
        echo maw-muter.exe is already on the latest version.
        del "%localMawMuterPath%.temp"
    )
) else (
    echo maw-muter.exe does not exist in the scripts directory.
)
echo.

:: Combine the path and script name to create the full path to the script
set "scriptPath=%rootDir%/MuteActiveWindow.ahk"

:: Check if the script file exists
if exist "%scriptPath%" (
    echo Running MuteActiveWindow...
    start "" /b "%scriptPath%"
) else (
    echo The script %scriptName% does not exist in the previous folder. Or is not named MuteActiveWindow.ahk
)

pause
