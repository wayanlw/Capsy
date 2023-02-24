; ------------------------------------------------------------------------------
;
;
; Version 0
;
;
; ------------------------------------------------------------------------------

#SingleInstance, Force

#Persistent
; SendMode Input ; with this the launcher keys will not work with the mouse section d: f: etc.  (w)
SetCapsLockState, AlwaysOff
; SetScrollLockState, AlwaysOff

CoordMode,Mouse,Screen
SetBatchLines -1

;-----------initializing autoexecution variables. Should be defined before the first hotkey
;Variables should eith be defined in autoexecution section or within a function
; starting up Command Mode for jk
commandMode=False

;window management function task bar height
taskbar_height:=35

;run or raise function - Programs Launched
prog_1:="C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
prog_2:="C:\Scoop\apps\freecommander\current\FreeCommander.exe"
prog_3:="C:\Program Files (x86)\SAP\FrontEnd\SapGui\saplogon.exe"
prog_4:="C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
prog_5:="C:\Program Files (x86)\Teams Installer\Teams.exe"
prog_6:="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"


;###################Start Mouse#####################
#UseHook ; without this the mouse movement will not work
MouseDelay = 0
Increment = 1
e::
d::
s::
f::
RShift::
    xVal=
    yVal=
    If GetKeyState("RShift","p") = 1
    {
        IncrementValue := Increment
        Loop,
        {
            ; lower increment value higher startup speed. Lower increment slower acceleration
            If (A_Index > IncrementValue * 2) and (IncrementValue < Increment * 9 )
                IncrementValue := IncrementValue * 2
            If GetKeyState("d", "P")
                yVal := IncrementValue
            Else If GetKeyState("e", "P")
                yVal := -IncrementValue
            If !yVal
                yVal := 0
            If GetKeyState("s", "P")
                xVal := -IncrementValue
            Else If GetKeyState("f", "P")
                xVal := IncrementValue
            If !xVal
                xVal := 0
            If GetKeyState(A_ThisHotKey, "P")
                MouseMove, %xVal%, %yVal%,%MouseDelay%,R
            Else
                Break
        }
        Send {RShift up}
    }
    else
    {
        Send % "{" . A_ThisHotKey . "}"
        Send, {RShift up}
        ; Send, {RALT up}
    }
return

#If GetKeyState("RShift","P") = 1

/* --------------------------- Mouse Button Clicks --------------------------
*/

l:: Send {RButton}
Insert:: Send {MButton}
':: SendInput ^{LButton}

SC027::
    SendInput {LButton Down}
    keywait, SC027, u
    SendInput {LButton UP}
return

; ------ Left side --------
v::Click, 1
x:: Click, 2

space::
    SendInput {LButton Down}
    keywait, space, u
    SendInput {LButton Up}
return

; ---------------------------- scroll up and down ------------------------------
r::
    While GetKeyState("r", "P")
    {
        Send {Wheelup}
        sleep 100
    }
return

w::
    While GetKeyState("w", "P")
    {
        Send {WheelDown}
        sleep 100
    }
return
; -------------------- move the mouse cursor to corners --------------------

q::MouseMove, (A_ScreenWidth / 6 ), (A_ScreenHeight / 6 )
t::MouseMove, (A_ScreenWidth / 6 * 5), (A_ScreenHeight / 6 * 1)
a::MouseMove, (A_ScreenWidth / 6 * 1), (A_ScreenHeight / 6 * 3)
c::MouseMove, (A_ScreenWidth / 2), (A_ScreenHeight / 2)
g::MouseMove, (A_ScreenWidth / 6 * 5), (A_ScreenHeight / 6 * 3)
z::MouseMove, (A_ScreenWidth / 6 * 1), (A_ScreenHeight / 6 * 5)
b::MouseMove, (A_ScreenWidth / 6 * 5), (A_ScreenHeight / 6 * 5)
#if

;###############End Mouse #########################################

; ---------------------------Extra mouse button mapping ---------------------
; this is commented because the this functionality is implmented with xmousebuttonControl
; XButton2::Send {Enter}
; XButton1::Send {Delete}


; Mouse Buttons as Scroll Up and Down
; XButton2::
;     While GetKeyState("XButton2", "P")
;     {
;         Send {Wheelup}
;         sleep 100
;     }
; return

; XButton1::
;     While GetKeyState("XButton1", "P")
;     {
;         Send {WheelDown}
;         sleep 100
;     }
; return

Capslock & LButton::click,2

WheelLeft::WheelLeft
WheelRight::WheelRight

/* ------------------------------- Excel area -------------------------------
*/

#IfWinActive ahk_class XLMAIN
    WheelLeft::SendInput, !{PgUp}
    WheelRight::SendInput, !{PgDn}

    ;---------------- dependants -------------
    `::,
    Capslock & 1::SendInput ^[
    Capslock & 2::SendInput {F5}{Enter}
    Capslock & 3::SendInput {=}
    Capslock & 4::SendInput {F4}

    ;-----------------pasting ----------------

    +!v::SendInput ^!v{v}{Enter} ; paste values
    ^!f::SendInput ^!v{f}{Enter} ; paste formulas
    ^!t::SendInput ^!v{t}{Enter} ; paste formatting
    ^!z::SendInput ^!v{l}		;paste links

    ;--------Conditional formating ------------
    ; ^!s::SendInput ^{space}^{-}
    ; ^!d::SendInput +{space}^{-}
    ; ^!x::SendInput !H{L}{c}{s}{Enter}

    ;-------- Control up/down
    Capslock & u::SendInput ^{Up}
    Capslock & o::SendInput ^{Down}

    ;-------- switch sheets
    Capslock & [::SendInput ^{pgup}
    Capslock & ]::SendInput ^{pgDn}

    !,::SendInput ^{pgup}
    !.::SendInput ^{pgDn}

    ;------- Copy formula right / down
    Capslock & b::SendInput ^d
    Capslock & t::SendInput ^r
    ; Capslock & g::SendInput {Blind}{Control Down}{Shift Down}
    ; Capslock & g up::SendInput {Blind}{Control up}{Shift up}

    ;------- F2 key
    Capslock & g::SendInput {F2}

    ;------- Arithmatic operators
    Capslock & F1::SendInput {-}
    Capslock & F2::SendInput {+}
    Capslock & F3::SendInput {*}
    Capslock & F4::SendInput {/}

    ; ---------------------------- alt Enter in excel ------------------------------
    Capslock & Enter::
        If GetKeyState("space","p") = 1
        {
            SendInput,{Home}!{Enter}{Up}
        }
        Else
        {
            SendInput,{End}!{Enter}
        }
    return

#IfWinActive

; ------------------------------------------------------------------------------
;                                Capslock Toggle
; ------------------------------------------------------------------------------

#Capslock::
    If GetKeyState("CapsLock", "T") = 1
        SetCapsLockState, AlwaysOff
    Else
        SetCapsLockState, AlwaysOn
return

; ------------------------------------------------------------------------------
;                                   Main Keys
; ------------------------------------------------------------------------------

Capslock & q::SendInput {Esc}
;Capslock & w::Launcher
Capslock & e::SendInput ^z ; This has repetitive press. Sould be a comfortable place.
Capslock & r::SendInput ^y ; redo
;Capslock & t:: The Word Key --> single press = copy word | double press = delete word | long press = select word
Capslock & y::SendInput {Blind}{Home} ;with space for contrl+End
Capslock & u::SendInput {Blind}{pgUp}
Capslock & i::SendInput {Blind}{Up}
Capslock & o::SendInput {Blind}{pgDn}
Capslock & p::SendInput {Blind}{End}
; Capslock & [::SendInput {{}{}}{Left} ; Sorround in []
; Capslock & ]::SendInput []{Left}     ; Sorround in {}
Capslock & \::SendInput |

;Capslock & a:: SendInput ^x ; single press = Save | Double press = Save as
Capslock & s:: SendInput ^x
Capslock & d:: SendInput ^c
Capslock & f:: SendInput ^v
;Capslock & g:: selecet & copy / delete line
Capslock & h::SendInput {Blind}^{Left}
Capslock & j::SendInput {Blind}{Left}
Capslock & k::SendInput {Blind}{Down}
Capslock & l::SendInput {Blind}{Right}
Capslock & SC027::SendInput {Blind}^{right}
;Capslock & ':: --> Sorround with ""

Capslock & z::AltTab
;Capslock & x:: SendInput ^x ; single press = find| long press = find selection
Capslock & c::SendInput {Enter}
Capslock & v::SendInput {Delete}
Capslock & b::SendInput {Blind}{BS}
Capslock & n::SendInput {Blind}{BS}
Capslock & m::SendInput {Blind}^{BS}
Capslock & ,::SendInput {Delete}
Capslock & .::SendInput ^{Delete}
Capslock & /::SendInput {Enter}

; ------------------------------- Special Keys ---------------------------------

Capslock & alt::SendInput {Blind}{Alt}
Capslock & space::return
Capslock & BS::SendInput {Blind}^{BS}
#space::Send,{space}{left}

Capslock & Tab::SendInput {Blind}{Shift Down}
Capslock & Tab up::SendInput {Blind}{Shift up}


; using alt+u/o to control+tab and control+shift+tab
!o::SendInput ^{Tab}
!u::SendInput ^+{Tab}

; ------------------------------use jk as the escape ---------------------------

;; --------------swap Ctrl | Win | Alt keys ----------------------------------
;LAlt::LControl
;Lwin::LAlt
;LControl::LWin

; --------------------- Control Key -----------------------
RAlt::RControl

; ;;---- this is the ideal case. However, randomly sends ";" key when try to do "cntrl+right" shortcut.
; *SC027::
;     Send {Blind}{Ctrl Down}
;     cDown := A_TickCount
; Return

; *SC027 up::
;     If ((A_TickCount-cDown)<200)  ; Modify press time as needed (milliseconds)
;         Send {Blind}{Ctrl Up}{SC027}
;     Else
;         Send {Blind}{Ctrl Up}
; Return
; ;
; ;making ' single press as ' and long press as control
; *'::
;     Send {Blind}{Ctrl Down}
;     cDown := A_TickCount
; Return

; *' up::
;     If ((A_TickCount-cDown)<200)  ; Modify press time as needed (milliseconds)
;         Send {Blind}{Ctrl Up}'
;     Else
;         Send {Blind}{Ctrl Up}
; Return

; --------------------------- Close windows and tab ----------------------------

!+q::SendInput !{F4}
!q::SendInput ^w
;!+k::WinMinimize, A

; ---------------------------- windows placement --------------------------- */

CoordMode,Screen
; this is the internet copied version of windows move
; !x::
;     WinGet, window, ID, A
;     ; InputBox, width, Resize, Width:, , 140, 130
;     ; InputBox, height, Resize, Height:, , 140, 130
;     WinMove, ahk_id %window%, , 2 , 2, A_ScreenWidth-5, A_ScreenHeight-30
;     ; WinGetPos,,, sizeX, sizeY
;     ; WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
; return

ww_PlaceWindow(x_pos,y_pos,width,height){
	global taskbar_height ; to use a global variable inside a function keyword "global" should be used
    WinGet, window, ID, A
    ; WinHide, ahk_id %window%
    WinRestore, ahk_id %window%
    WinMove, ahk_id %window%, ,x_pos, y_pos , width, height-taskbar_height
    ; Winshow, ahk_id %window%
	return
}

#if (%commandMode%=True) ; if command mode is on activate the commands
!+1::ww_PlaceWindow(2,2,A_ScreenWidth-4, A_ScreenHeight)
!+2::ww_PlaceWindow(A_ScreenWidth,2,A_ScreenWidth-4, A_ScreenHeight)
!+e::ww_PlaceWindow(2,2,A_ScreenWidth/2-4, A_ScreenHeight)
!+r::ww_PlaceWindow(A_ScreenWidth/2+2,2,A_ScreenWidth/2-4, A_ScreenHeight)
#if


; !+a::wp_WinPreviouslyActive(A_ScreenWidth/2,A_ScreenHeight)
; !+d::wp_WinPreviouslyActive(A_ScreenWidth,A_ScreenHeight)
!+a::altertab(A_ScreenWidth/2,A_ScreenHeight)
!+d::altertab(A_ScreenWidth,A_ScreenHeight)



wp_WinPreviouslyActive(width,height)
{
	; place the active window
    ww_PlaceWindow(width+2,2,width-4, height)

	; get the hwind (ahk_id) of the Active Window
    active := WinActive("A")

    WinGet, win, List

    ; Find the active window.
    ; (Might not be win1 if there are always-on-top windows?)
    Loop, %win%
        if (win%A_Index% = active)
    {
        if (A_Index < win)
            N := A_Index+1
        ; hack for PSPad: +1 seems to get the document (child!) window, so do +2
        ifWinActive, ahk_class TfPSPad
            N += 1
        break
    }

    ; Use WinExist to set Last Found Window (for consistency with WinActive())
    ; return WinExist("ahk_id " . win%N%)
    WinExist("ahk_id " . win%N%)
    WinActivate
    ; ww_PlaceWindow(2,2,width/2-4, height)
    ww_PlaceWindow(2,2,width-4, height)

    ; ----- ww: Uncomment the below section if you want to reactivate the previously active window
    ; WinExist("ahk_id " . win%active%)
    ; WinActivate, ahk_id %active%
}

altertab(width,height)
{
	ww_PlaceWindow(width+2,2,width-4, height)
	Sleep, 150
	send, {AltDown}{Tab}{AltUp}
	Sleep, 150
	ww_PlaceWindow(2,2,width-4, height)
}


; ------------------------------- Line Editing ---------------------------------

Capslock & Enter::
    If GetKeyState("space","p") = 1
    {
        Send,{Home}{Home}{Enter}{Up}
    }
    Else
    {
        Send,{End}{End}{Enter}
    }
return

Capslock & Home::SendInput {Home}{Home}+{End}+{End}^c{End}{Enter}^v{Up}{End} ;duplicate the line up and go to the end of the duplicated
Capslock & End::SendInput {Home}{Home}+{End}+{End}^c{End}{Enter}^v ; duplicate line down and go to the end of the duplicated line
Capslock & PgDn::SendInput {End}{space}{Delete}{End} ; bring the below line to the current line
Capslock & PgUp::SendInput {Home}{Home}{BackSpace}{space}{End} ; Take the current line to the line above

; --------------------------------- F keys ---------------------------------*/

Capslock & F1:: SendInput {AppsKey}
; Capslock & F2:: --------------
; Capslock & F3:: --------------
; Capslock & F4:: --------------
; Capslock & F5:: --------------
; Capslock & F6:: --------------
; Capslock & F7:: --------------
; Capslock & F8:: --------------
; Capslock & F9:: --------------
; Capslock & F10:: --------------
capslock & F11::
	; activate/deactivate command mode
    if (%commandMode% = True){
		commandMode = False
        ToolTip ,Command Mode %commandMode%!
		sleep 1000
		ToolTip
	}
	else{
		commandMode = True
        ToolTip ,Command Mode %commandMode%!
		sleep 1000
		ToolTip
	}
return
CapsLock & F10::MsgBox, %commandMode%
#if (%commandMode%=True) ; if command mode is on activate the commands
	:?*:jk::
		sendInput {Esc}
	return
	; :?*:jj::
	; 	sendInput {Enter}
	; return
#IF

Capslock & F12:: ;window always on top
    if (%top% = True)
    {
        WinSet, AlwaysOnTop, toggle, A
        ToolTip ,%AlwayOnTopWindow% `r NOT on top!
        Sleep, 1500
        ToolTip
        AlwayOnTopWindow = ""
        top = False
    }
    Else
    {
        WinGetTitle, AlwayOnTopWindow, A ; A stands for Active Window
        WinSet, AlwaysOnTop, toggle, A
        ToolTip , %AlwayOnTopWindow% `r stays on top!
        Sleep, 1500
        ToolTip
        top = True
    }
return

; ------------------------------- Number keys ------------------------------

; Capslock & `:: SendInput --------------
Capslock & 1:: SendInput {AppsKey}
Capslock & 2:: SendInput {F2}
Capslock & 3:: =
;Capslock & 4:: Excel F4
Capslock & 5:: SendInput {Blind}^{Home}
Capslock & 6:: SendInput {Blind}^{End}
Capslock & 7:: SendInput {PgUp}
Capslock & 8:: SendInput {PgDn}
;Capslock & 9:: Sorround with paranthesis or (
;Capslock & 0:: Sorround with ""
Capslock & -:: _
Capslock & =:: +


; ------------------------------------------------------------------------------
;                               Special Functions
; ------------------------------------------------------------------------------

; ----- SinglePress=copy word|DoublePress=delete word|longPress=select word ----

Capslock & t::
    keywait, t, t 0.5
    if errorlevel{
        ;long press to select word
        SendInput, ^{Left}+^{Right}
    }
    else{
        keywait,t
        keywait, t, d ,t 0.15
        if errorlevel
            ; single press to copy word
        SendInput, ^{Left}+^{Right}^c
        else{
            ; double press to delet word
            SendInput, ^{Left}+^{Right}^{Del}
            return
        }
    }
    keywait,t
return

; ---------------- Single Press = Save| Double Press = Save As -----------------
Capslock & a::
    keywait, a
    keywait, a, d ,t 0.2
    if errorlevel
    {
        SendInput ^s ; save
    }
    else
    {
        IfWinActive, ahk_class XLMAIN
        {
            SendInput {f12} ; save as in excel
            return
        }
        SendInput ^+s ; save as
    }
return


; ---- single press=delete Line |double press=copy Line | hold=Select Line -----
Capslock & g::
    keywait, g, t 0.5
    if errorlevel{
        ;long press to select line
        SendInput, {Home}{Home}+{End}+{End}
    }
    else{
        keywait,g
        keywait, g, d ,t 0.15
        if errorlevel
            ; single press to delete line
        Send, {Home}{Home}+{End}+{End}{Del}
        else{
            ; double press to copy line
            Send, {Home}{Home}+{End}+{End}^c
            return
        }
    }
    keywait,g
return


; ------------- Single Press = Find | Long Press = Find Selected ---------------
capslock & x::
    keywait, x, t 0.5
    if errorlevel{
        ;short press to copy
        OldClipboard := Clipboard
        Clipboard := ""
        Send ^c
        ClipWait, 1
        Clipboard = %Clipboard%
		Send ^f
        Send ^v
		Sleep 500
		Send {Enter}
        Clipboard := OldClipboard
        OldClipboard := ""
        ; Send, ^c
        return
    }
    else{
        ;short press to copy
        sendinput, ^f
        return
    }
    keywait,x
return


; ------------------------------------------------------------------------------
;                            Sorround the Selection
; ------------------------------------------------------------------------------

Capslock & 9::  ; Sourround in ()
    If GetKeyState("Space","p") = 1
    {
        OldClipboard := Clipboard
        Clipboard := ""
        Send ^c
        ClipWait, 1
        Clipboard = (%Clipboard%)
        Send ^v
        Sleep 500
        Clipboard := OldClipboard
        OldClipboard := ""
        ; Send, ^c
    }
    Else
    {
        Send (){left}
    }
return

Capslock & 0::  ; Sourround in ''
    If GetKeyState("Space","p") = 1
    {
        OldClipboard := Clipboard
        Clipboard := ""
        Send ^c
        ClipWait, 1
        Clipboard = '%Clipboard%'
        Send ^v
        Sleep 500
        Clipboard := OldClipboard
        OldClipboard := ""
        ; Send, ^c
    }
    Else
    {
        Send ''{left}
    }
return


Capslock & '::  ; Sourround in ""
    If GetKeyState("Space","p") = 1
    {
        OldClipboard := Clipboard
        Clipboard := ""
        Send ^c
        ClipWait, 1
        Clipboard = "%Clipboard%"
        Send ^v
        Sleep 200
        Clipboard := OldClipboard
        OldClipboard := ""
        ; Send, ^c
        return
    }
    else
    {
        SendInput ""{left}
        return
    }
return

Capslock & [::  ; Sourround in []
    If GetKeyState("Space","p") = 1
    {
        OldClipboard := Clipboard
        Clipboard := ""
        Send ^c
        ClipWait, 1
        Clipboard = [%Clipboard%]
        Send ^v
        Sleep 200
        Clipboard := OldClipboard
        OldClipboard := ""
        ; Send, ^c
        return
    }
    else
    {
        SendInput []{left}
        return
    }
return

Capslock & ]::  ; Sourround in {}
    If GetKeyState("Space","p") = 1
    {
        OldClipboard := Clipboard
        Clipboard := ""
        Send ^c
        ClipWait, 1
        Clipboard = {%Clipboard%}
        Send ^v
        Sleep 200
        Clipboard := OldClipboard
        OldClipboard := ""
        ; Send, ^c
        return
    }
    else
    {
        SendInput {{}{}}{left}
        return
    }
return

; ------------------------------- Num lock keys --------------------------------
+^!Space:: SendInput {Numpad0}
+^!m:: SendInput {Numpad1}
+^!,:: SendInput {Numpad2}
+^!.:: SendInput {Numpad3}
+^!j:: SendInput {Numpad4}
+^!k:: SendInput {Numpad5}
+^!l:: SendInput {Numpad6}
+^!u:: SendInput {Numpad7}
+^!i:: SendInput {Numpad8}
+^!o:: SendInput {Numpad9}
+^!p:: SendInput {*}
+^![:: SendInput {/}
+^!':: SendInput {-}
+^!SC027:: SendInput {+}
+^!/:: SendInput {Enter}
+^!n:: SendInput {BS}
+^!BS:: SendInput {BS}
+^!Enter:: SendInput {Enter}
+^!h:: SendInput {=}

; ------------------------------- Numberpad keys --------------------------------
Capslock & Numpad8:: SendInput {Blind}{Up}
Capslock & Numpad4:: SendInput {Blind}{Left}
Capslock & Numpad5:: SendInput {Blind}{Down}
Capslock & Numpad6:: SendInput {Blind}{Right}

Capslock & NumpadDiv:: SendInput {Blind}^{up}
Capslock & Numpad7:: SendInput {Blind}^{Left}
Capslock & Numpad2:: SendInput {Blind}^{Down}
Capslock & Numpad9:: SendInput {Blind}^{Right}

Capslock & Numpad1:: SendInput {Blind}{BS}
Capslock & Numpad3:: SendInput {Blind}{Del}

Capslock & Numpad0::SendInput {F2}

Capslock & NumpadAdd:: SendInput {Blind}{=}
Capslock & NumpadEnter:: SendInput {Blind}^{Enter}

Capslock & NumLock:: SendInput {Esc}


; ------------------------------------------------------------------------------
;                                   Launcher
; ------------------------------------------------------------------------------

Capslock & w::

    Input Key, L2 T2 ; L2 to limit the input to 2 keys. T2 , wait for 2 seconds. Whichever occurs first
    ;----------------------Delete all
    if Key=fa
    {
        SendInput ^a{delete}
        return
    }
    ;----------------------Delete to Start
    else if key=fs
    {
        SendInput, +{Home}+{Home}{delete}
        return
    }
    ;----------------------Delete to End
    else if key=fe
    {
        SendInput, +{End}+{End}{delete}
        return
    }

    ;-----------------------copy all
    else if key=da
    {
        SendInput, ^a^c
        return
    }
    ;-----------------------copy to start
    else if key=ds
    {
        SendInput, +{Home}+{Home}^c
        return
    }
    ;-----------------------copy to End
    else if key=df
    {
        SendInput, +{End}+{End}^c
        return
    }

    ;----------------------- cut all
    else if key=va
    {
        SendInput, ^a^x
        return
    }
    ;----------------------- cut word
    else if key=vw
    {
        SendInput, ^{right}+^{left}^x
        return
    }
    ;----------------------- cut line
    else if key=vv
    {
        SendInput, {Home}{Home}+{End}+{End}^x
        return
    }
    ;----------------------- cut to start
    else if key=vs
    {
        SendInput, +{Home}+{Home}^x
        return
    }
    ;----------------------- cut to End
    else if key=vd
    {
        SendInput, +{End}+{End}^x
        return
    }

    ;----------------------- Select all
    else if key=sa
    {
        SendInput, ^a
        return
    }
    ;----------------------- Select to start

    else if key=ss
    {
        SendInput, +{Home}+{Home}
        return
    }
    ;----------------------- Select to End
    else if key=se
    {
        SendInput, +{End}+{End}
        return
    }

    ;----------------------- Select word

    else if key=sw
    {
        SendInput, ^{right}+^{left}
        return
    }
; ----------------------------Excel Rows | Cols
    else if key=dc
    {
        SendInput, ^{space}^{-}
        return
    }

    else if key=dr
    {
        SendInput, +{space}^{-}
        return
    }
    else if key=ec
    {
        SendInput, ^{space}
        sleep 100
        SendInput, !H{I}{C}
        return
    }

    else if key=er
    {
        SendInput,+{space}
        sleep 100
        SendInput, !H{I}{R}
        return
    }

return

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


; ------------------------------------------------------------------------------
;                               Search Functions
; ------------------------------------------------------------------------------

; ------------------------------ Youtube Search --------------------------------

#y::
    InputBox, Search, Youtube Search, , , 400, 100
    if not ErrorLevel ; when cancel is not pressed
    {
        ; run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://www.youtube.com/results?search_query="%Search%"
        run https://www.youtube.com/results?search_query=%Search%
    }
return

; ----------------------- Youtube Search Selected Words ------------------------


#+y::
    OldClipboard:= Clipboard
    Clipboard:= ""
    Send, ^c ;copies selected text
    ClipWait, 1

    ; Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://www.youtube.com/results?search_query="%clipboard%"
    Run https://www.youtube.com/results?search_query=%clipboard%
    Sleep 500 ; at 200 the content was getting copied to the current clipbarod
    Clipboard:= OldClipboard
    Send, ^c ;copies selected text
return

; ------------------------------- Google Search --------------------------------

#s::
    InputBox, Search, Google Search, , , 400, 100
    if not ErrorLevel ; when cancel is not pressed
    {
        ; run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe http://www.google.com/search?q=%Search%&num=100&source=lnms&filter=0
        run http://www.google.com/search?q=%Search%&num=100&source=lnms&filter=0
    }
return

; ------------------------ Google Search Selected Word -------------------------

#+s::
    OldClipboard:= Clipboard
    Clipboard:= ""
    SendInput, ^c ;copies selected text
    ClipWait, 1
    ; Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe http://www.google.com/search?q=%Clipboard%&num=100&source=lnms&filter=0
    Run http://www.google.com/search?q=%Clipboard%&num=100&source=lnms&filter=0
    Sleep 500
    Clipboard:= OldClipboard
    OldClipboard:=""
    ;    MsgBox %OldClipboard%
    Send, ^c ;copies selected text
return


; ------------------------------------------------------------------------------
;                Drag Windows with CapsLock + Right Mouse Button
; ------------------------------------------------------------------------------

Capslock & RButton::
    CoordMode, Mouse ; Switch to screen/absolute coordinates.
    MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
    WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
    WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
    if EWD_WinState = 0 ; Only if the window isn't maximized
        SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
    GetKeyState, EWD_LButtonState, RButton, P
    if EWD_LButtonState = U ; Button has been released, so drag is complete.
    {
        SetTimer, EWD_WatchMouse, off
        return
    }
    GetKeyState, EWD_EscapeState, Escape, P
    if EWD_EscapeState = D ; Escape has been pressed, so drag is cancelled.
    {
        SetTimer, EWD_WatchMouse, off
        WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
        return
    }
    ; Otherwise, reposition the window to match the change in mouse coordinates
    ; caused by the user having dragged the mouse:
    CoordMode, Mouse
    MouseGetPos, EWD_MouseX, EWD_MouseY
    WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
    SetWinDelay, -1 ; Makes the below move faster/smoother.
    WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
    WinActivate, ahk_id %EWD_MouseWin%
    EWD_MouseStartX := EWD_MouseX ; Update for the next timer-call to this subroutine.
    EWD_MouseStartY := EWD_MouseY ;bring the window to the front(foreground)
return

; ------------------------------------------------------------------------------
;                            Gather text to notepad
; ------------------------------------------------------------------------------

^!c::
    OldClipboard := ClipboardAll
    Clipboard = ;clears the Clipboard
    Send, ^c
    ClipWait 0 ;pause for Clipboard data
    If ErrorLevel
    {
        MsgBox, No text selected!
    }

    IfWinNotExist, *Untitled - Notepad
    {
        Run, Notepad
        WinWaitActive, Untitled - Notepad
        Control, EditPaste, % Clipboard . chr(13) . chr(10) . chr(13) . chr(10) , , Untitled - Notepad
        return
    }

    ; Control, EditPaste used rather than ControlSend for much greater speed of execution

    Control, EditPaste, % Clipboard . chr(13) . chr(10) . chr(13) . chr(10) , , *Untitled - Notepad
    Clipboard := OldClipboard
return

; ------------------------------------------------------------------------------
;                      Gather text to any preselected app
; ------------------------------------------------------------------------------

+!c::  ; alt+shift+c to copy to the selected window

    If !WinTag
    {
        MsgBox, , Capsy CopyToApp, You pressed the combination of CopyToApp. First, tag a target window in NotePad
        , WordPad or a GUI edit field.`r`r 1
        . Activate window`n 2
        . Press Ctrl+Win+Shift+Z
        return
    }

    OldClipboard:= ClipboardAll
    ; Clipboard:= ""
    sleep 500
    Send, ^c ;copies selected text
    ClipWait,1
    If ErrorLevel
    {
        MsgBox, , Capsy CopyToApp, No text selected!
        return
    }
    IfWinExist, %winTitlePart%
    {
        ;Save the currently active window title
        WinGetTitle, actWin, A

        ; If OneNote is not active, activate it now
        IfWinNotActive, %winTitlePart%
            WinActivate, %winTitlePart%

        ; Check again, if ON active then paste else error
        IfWinActive, %winTitlePart%
        {
            Send, ^v`r`r ; Use sendplay to avoid unexpected interactions with Win key
            ; Switch window back to previously active
            WinActivate, %actWin%
        }
        sleep 500
    }
    Else
    {
        MsgBox, Window < "%winTitlePart%" > does not Exist!
    }
    Clipboard := OldClipboard
return

^#+z:: ;Ctrl+win+shift+z tag a window as a copy destination
    ; Click, %A_CaretX%, %A_CaretY%
    MouseGetPos, , , WinTag, Control
    WinGetTitle, winTitlePart, ahk_id %WinTag%
    MsgBox, , Capsy CopyToApp, " %winTitlePart% " is tagged as the destination window!`r - Press < Alt+Shift+C > to copy selection to this app.`r - Press < Ctrl+Win+Shift+R > to reset.
return

^#+r:: ;Ctrl+win+shift+r tag a window as a reset destination
    WinActivate, ahk_id %WinTag%
    MsgBox, , Capsy CopyToApp, CopyToApp windows is reset!, 3
    WinTag:=""
return

; ------------------------------------------------------------------------------
;                                 Exit or Suspend
; ------------------------------------------------------------------------------

; >+q::Suspend

>^q::
    MsgBox, , Capsy, Existing Capsy
ExitApp
