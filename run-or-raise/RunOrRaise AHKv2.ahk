#SingleInstance Force


prog_1:="C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
prog_2:="C:\Users\auwwaya\scoop\apps\freecommander\current\FreeCommander.exe"
prog_3:="C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
prog_4:="C:\Users\auwwaya\AppData\Local\Microsoft\WindowsApps\ms-teams.exe"
prog_5:="C:\Program Files (x86)\SAP\FrontEnd\SapGui\saplogon.exe"
prog_6:="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
prog_7:="C:\Users\auwwaya\scoop\apps\keepassxc\current\KeePassXC.exe"

; ------------------------------------------------------------------------------
;                               Run or Raise
; ------------------------------------------------------------------------------
#WinActivateForce ; Prevent task bar buttons from flashing when different windows are activated quickly one after the other.
#1::OpenOrShowAppBasedOnExeName(prog_1)
#2::OpenOrShowAppBasedOnExeName(prog_2)
#3::OpenOrShowAppBasedOnExeName(prog_3)
#4::OpenOrShowAppBasedOnExeName(prog_4)
#5::OpenOrShowAppBasedOnExeName(prog_5)
+!f::OpenOrShowAppBasedOnExeName(prog_6)
^!k::OpenOrShowAppBasedOnExeName(prog_7)

OpenOrShowAppBasedOnExeName(AppAddress)
{
    AppExeName := SubStr(AppAddress, (InStr(AppAddress, "\", false, -2) + 1)<1 ? (InStr(AppAddress, "\", false, -2) + 1)-1 : (InStr(AppAddress, "\", false, -2) + 1))
    if WinExist("ahk_exe " AppExeName) ; if window currently exist
    {
        if WinActive() ; if the window is active
        {
            ActiveProcess := WinGetProcessName("A")
            OpenWindowsAmount := WinGetCount("ahk_exe " ActiveProcess)

            if (OpenWindowsAmount = 1) ; If only one Window exist, do nothing
                Return
            Else ; if there are multiple windows prewsent cycle between the windows
            {
                FullTitle := WinGetTitle("A")
                AppTitle := SubStr(FullTitle, (InStr(FullTitle, " ", false, -2) + 1)<1 ? (InStr(FullTitle, " ", false, -2) + 1)-1 : (InStr(FullTitle, " ", false, -2) + 1))
                SetTitleMatchMode(2)
                oWindowsWithSameTitleList := WinGetList(AppTitle,,,)
                aWindowsWithSameTitleList := Array()
                WindowsWithSameTitleList := oWindowsWithSameTitleList.Length
                For v in oWindowsWithSameTitleList
                {   aWindowsWithSameTitleList.Push(v)
                }
                if (aWindowsWithSameTitleList.Length > 1) ; If several Window of same type (title checking) exist
                {
                    WinActivate("ahk_id " aWindowsWithSameTitleList[aWindowsWithSameTitleList.Length])	; Activate next Window
                }
            }
            Return
        }
        else ; if the window exists,but not active --> activate the window
        {
            WinActivate()

			;;; uncomment this section to bring the window to the main screen (if required)
			; WinGet, window, ID, A
			; WinMove, ahk_id %window%, , 2 , 2, A_ScreenWidth-5, A_ScreenHeight-30

            Return
        }
    }
    else ; if program doesnt exist try to run it
    {
		try
		{
		    Run AppAddress
		}
		catch Error as err
		{
            MsgBox("File " AppExeName " Not Found")
            Return
        }
        else
        {
            ErrorLevel := !WinWait("ahk_exe " AppExeName)
            WinActivate("ahk_exe " AppExeName)

			;;; uncomment this section to brings the window to the main screen (if required)
			; WinGet, window, ID, A
			; WinMove, ahk_id %window%, , 2 , 2, A_ScreenWidth-5, A_ScreenHeight-30

            Return
        }
    }
}
