@echo off
setlocal enabledelayedexpansion

set "currentDir=%~dp0"
set "rootDir=%currentDir%.."
set "betaFlag=%~1"
echo Starting MAW Updater (291223.01)
echo.

:: Define GitHub URLs
set "githubRootURL=https://raw.githubusercontent.com/tfurci/MuteActiveWindow"
:: Check if the beta flag is used and set the GitHub branch accordingly
if /i "%betaFlag%"=="-beta" (
    set "githubBranch=/beta"
) else (
    set "githubBranch=/main"
)


:: Define file paths
set "aesScriptPath=%rootDir%\Scripts\AutoEnableStartup.bat"
set "mainScriptPath=%rootDir%\MuteActiveWindow.ahk"
set "mawMuterPath=%rootDir%\maw-muter.exe"

:: Check for curl installation
where curl >nul 2>&1 || (
    echo Auto-update cannot be performed because curl is not installed.
    choice /C YN /M "Do you want to open GitHub repository for manual update? [Y/N]: "
    if not errorlevel 2 start https://github.com/tfurci/muteactivewindow
    exit
)

:: List of unnecessary files to be deleted
set "filesToDelete=Scripts\BatUpdater.bat"

set /a deletedFilesCount=0
echo Deleting unnecessary files...
for %%f in (%filesToDelete%) do (
    if exist "%rootDir%\%%f" (
        del "%rootDir%\%%f"
        echo Deleted %%f
        set /a deletedFilesCount+=1
    )
)
if !deletedFilesCount! equ 0 (
    echo No unnecessary files removed.
)
echo.


:: Update scripts
call :updateScript "%aesScriptPath%" "%githubRootURL%%githubBranch%/MuteActiveWindow/Scripts/AutoEnableStartup.bat"
echo.
call :updateScript "%mainScriptPath%" "%githubRootURL%%githubBranch%/MuteActiveWindow/MuteActiveWindow.ahk"
echo.
call :updateScript "%mawMuterPath%" "https://github.com/tfurci/maw-muter/releases/latest/download/maw-muter.exe"
echo.

:: Run the main script
if exist "%mainScriptPath%" (
    echo Running MuteActiveWindow...
    start "" /b "%mainScriptPath%"
    echo.
) else (
    echo MuteActiveWindow.ahk not found.
    echo.
)
pause
exit

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
