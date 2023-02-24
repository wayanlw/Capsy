#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


;run or raise function - Programs Launched
prog_1:="C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
prog_2:="C:\Scoop\apps\freecommander\current\FreeCommander.exe"
prog_3:="C:\Program Files (x86)\SAP\FrontEnd\SapGui\saplogon.exe"
prog_4:="C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
prog_5:="C:\Program Files (x86)\Teams Installer\Teams.exe"
prog_6:="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"


; ------------------------------------------------------------------------------
;                               Run or Raise
; ------------------------------------------------------------------------------
#WinActivateForce ; Prevent task bar buttons from flashing when different windows are activated quickly one after the other.
#1::OpenOrShowAppBasedOnExeName(prog_1)
#2::OpenOrShowAppBasedOnExeName(prog_2)
#3::OpenOrShowAppBasedOnExeName(prog_3)
#4::OpenOrShowAppBasedOnExeName(prog_4)
#5::OpenOrShowAppBasedOnExeName(prog_5)
#+f::OpenOrShowAppBasedOnExeName(prog_6)

CoordMode,Screen
; AppAddress: The address to the .exe (Eg: "C:\Windows\System32\SnippingTool.exe")
OpenOrShowAppBasedOnExeName(AppAddress)
{
    AppExeName := SubStr(AppAddress, InStr(AppAddress, "\", false, -1) + 1)
    IfWinExist ahk_exe %AppExeName% ; if window currently exist
    {
        IfWinActive ; if the window is active
        {
            WinGet, ActiveProcess, ProcessName, A
            WinGet, OpenWindowsAmount, Count, ahk_exe %ActiveProcess%

            If OpenWindowsAmount = 1 ; If only one Window exist, do nothing
                Return
            Else ; if there are multiple windows prewsent cycle between the windows
            {
                WinGetTitle, FullTitle, A
                AppTitle := SubStr(FullTitle, InStr(FullTitle, " ", false, -1) + 1)
                SetTitleMatchMode, 2
                WinGet, WindowsWithSameTitleList, List, %AppTitle%
                If WindowsWithSameTitleList > 1 ; If several Window of same type (title checking) exist
                {
                    WinActivate, % "ahk_id " WindowsWithSameTitleList%WindowsWithSameTitleList%	; Activate next Window
                }
            }
            Return
        }
        else ; if the window exists,but not active --> activate the window
        {
            WinActivate

			;;; uncomment this section to bring the window to the main screen (if required)
			; WinGet, window, ID, A
			; WinMove, ahk_id %window%, , 2 , 2, A_ScreenWidth-5, A_ScreenHeight-30

            Return
        }
    }
    else ; if program doesnt exist try to run it
    {
        Run, %AppAddress%, UseErrorLevel
        If ErrorLevel
        {
            Msgbox, File %AppExeName% Not Found
            Return
        }
        else
        {
            WinWait, ahk_exe %AppExeName%
            WinActivate ahk_exe %AppExeName%

			;;; uncomment this section to brings the window to the main screen (if required)
			; WinGet, window, ID, A
			; WinMove, ahk_id %window%, , 2 , 2, A_ScreenWidth-5, A_ScreenHeight-30

            Return
        }
    }
}