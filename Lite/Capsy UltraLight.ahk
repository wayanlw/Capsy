#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff

; ------------------------------ Suspend | Exit --------------------------------

>!q::Suspend

>^q::
    MsgBox, , Capsy, Existing Capsy UL
ExitApp

; ------------------------------------------------------------------------------
;                                Capslock Toggle
; ------------------------------------------------------------------------------

#Capslock::
    If GetKeyState("CapsLock", "T") = 1
        SetCapsLockState, AlwaysOff
    Else
        SetCapsLockState, AlwaysOn
Return




; --------------------------------- Main Keys ----------------------------------

Capslock & q::SendInput {Esc}
; Capslock & w::SendInput Launcher
Capslock & e::SendInput ^z ; This has repetitive press. Sould be a comfortable place.
Capslock & r::SendInput ^y ; redo
Capslock & t::SendInput ^{Right}+^{Left}
Capslock & y::SendInput {Blind}{Home}
Capslock & u::SendInput {Blind}{pgUp}
Capslock & i::SendInput {Blind}{Up}
Capslock & o::SendInput {Blind}{pgDn}
Capslock & p::SendInput {Blind}{End}
Capslock & [::SendInput {{}{}}{Left}
Capslock & ]::SendInput []{Left}
Capslock & \::SendInput |

Capslock & a::SendInput ^s
Capslock & s::SendInput ^x
Capslock & d::SendInput ^c
Capslock & f::SendInput ^v
Capslock & g::SendInput {Home}{Home}+{End}+{End}
Capslock & h::SendInput {Blind}^{Left}
Capslock & j::SendInput {Blind}{Left}
Capslock & k::SendInput {Blind}{Down}
Capslock & l::SendInput {Blind}{Right}
Capslock & SC027::SendInput {Blind}^{right}
Capslock & ':: SendInput ""{Left}

Capslock & z::AltTab
Capslock & x:: SendInput ^f
Capslock & c::SendInput {Enter}
Capslock & v:: SendInput {Delete}
Capslock & b:: SendInput {Home}{Home}+{End}+{End}{Del}
Capslock & n::SendInput {Blind}{BS}
Capslock & m::SendInput ^{Delete}
Capslock & ,::SendInput {Delete}
Capslock & .::SendInput {Blind}^{BS}
Capslock & /::SendInput {enter}

; ------------------------------- Special keys ---------------------------------

XButton2::send {Enter}
XButton1::send {Delete}
WheelLeft::WheelLeft
WheelRight::WheelRight

!+q::SendInput !{F4}
!q::SendInput ^w

Capslock & Tab::SendInput {Blind}{shift down}
Capslock & Tab up::SendInput {Blind}{shift up}

Capslock & alt::SendInput {Blind}{Alt}
Capslock & space::SendInput {Enter}
Capslock & enter::Send,{End}{enter}


Capslock & up::SendInput {Home}{Home}+{End}+{End}^c{End}{Enter}^v{up}{End}
Capslock & Down::SendInput {Home}{Home}+{End}+{End}^c{End}{Enter}^v
Capslock & Right::SendInput {End}{space}{Delete}{End}
Capslock & Left::SendInput {Home}{Home}{BackSpace}{space}{end}
; Capslock & Down::SendInput {Home}{Home}+{End}+{End}^c{End}{Enter}^v
; Capslock & Down::SendInput {Home}{Home}+{End}+{End}^c{End}{Enter}^v

; -------------------------------- Number Row ----------------------------------

Capslock & 1:: SendInput {AppsKey}
Capslock & 2:: SendInput {F2}
Capslock & 3:: =
Capslock & 4:: SendInput {Blind}^{Home}
Capslock & 5:: SendInput {Blind}^{End}
Capslock & 6:: SenDinput {LButton}
; Capslock & 7:: -------------
; Capslock & 8:: -------------
Capslock & 9:: send (){left}
Capslock & 0:: send ''{left}
; Capslock & -:: --------
; Capslock & =:: --------

; ---------------------------------- Fn keys -----------------------------------

Capslock & F1:: SendInput {AppsKey}
Capslock & F2:: WinSet, AlwaysOnTop, toggle, A
Capslock & F3::
    SendInput ^c
    run http://www.duckduckgo.com/
Return
; Capslock & F4:: --------------
; Capslock & F5:: --------------
; Capslock & F6:: --------------
; Capslock & F7:: --------------
; Capslock & F8:: --------------
; Capslock & F9:: --------------
; Capslock & F10:: --------------
; Capslock & F11:: --------------


; ------------------------------------------------------------------------------
;                                   Launcher
; ------------------------------------------------------------------------------
Capslock & w::
    Input Key, L2 T2 ; L3 to limit the input to 3 eys. T5 , wait for 5 seconds
    ;----------------------Delete all
    if Key=fa
    {
        SendInput ^a{delete}
        return
    }
    ;----------------------Delete to Start
    else if key=fs
    {
        SendInput, +{Home}{delete}
        return
    }
    ;----------------------Delete to End
    else if key=fe
    {
        SendInput, +{End}{delete}
        return
    }
    ;----------------------- Delet word
    else if key=fw
    {
        SendInput, ^{right}+^{Left}{delete}
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
        SendInput, +{Home}^c
        return
    }
    ;-----------------------copy to end
    else if key=de
    {
        SendInput, +{End}^c
        return
    }
    ;----------------------- copy word
    else if key=dw
    {
        SendInput, ^{right}+^{left}^c
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
        SendInput, {Home}+{End}^x
        return
    }
    ;----------------------- cut to start
    else if key=vs
    {
        SendInput, +{Home}^x
        return
    }
    ;----------------------- cut to end
    else if key=ve
    {
        SendInput, +{End}^x
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
        SendInput, +{home}+{home}
        return
    }
    ;----------------------- Select to end
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
    ;----------------------- Select word
    ; using Capslock + G
return

