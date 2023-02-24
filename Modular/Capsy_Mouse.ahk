; Modularizing the capsy script. Moved out the mouse functions in to this script

#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

CoordMode,Mouse,Screen
SetBatchLines -1

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

; ---------------------------Extra mouse button mapping ---------------------
; this is commented because the this functionality is implmented with xmousebuttonControl
XButton2::Send {Enter}
XButton1::Send {Delete}

Capslock & LButton::click,2

WheelLeft::WheelLeft
WheelRight::WheelRight

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