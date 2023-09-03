#Persistent
SetTitleMatchMode, 2

F1::
    ; Get the process name (EXE) of the active window
    WinGet, processName, ProcessName, A

    ; Check if the active window's process is ApplicationFrameHost.exe
    if (processName = "ApplicationFrameHost.exe") {
        ; Get the title of the active window (topbar text)
        WinGetActiveTitle, title

        ; Run the svcl.exe command to mute/unmute the application without waiting
        RunWait, svcl.exe /Switch "%title%", , Hide
    }
return
