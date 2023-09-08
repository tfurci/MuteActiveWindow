F2::
    WindowUWP := WinExist("A")
    ControlGetFocus, FocusedControl, ahk_id %WindowUWP%
    ControlGet, Hwnd, Hwnd,, %FocusedControl%, ahk_id %WindowUWP%
    WinGet, uwpprocess, processname, ahk_id %Hwnd%
    WinGet, Pid, Pid, ahk_id %Hwnd%
    MsgBox %uwpprocess%
return