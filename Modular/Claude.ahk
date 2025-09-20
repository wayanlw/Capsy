;; ============================================================================
;;                        Modern AutoHotkey v2 Productivity Suite
;; ============================================================================

#SingleInstance Force
#WinActivateForce
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 60000
SendMode("Input")
SetCapsLockState("AlwaysOff")
CoordMode("Mouse", "Screen")

;; ============================================================================
;;                               Configuration
;; ============================================================================

class Config {
    static SearchTimeout := 2
    static TooltipDuration := 1000
    static LongPressDuration := 500
    static DoublePressTimeout := 200
    static DefaultBrowser := ""
    
    static Init() {
        ; Auto-detect default browser or use system default
        this.DefaultBrowser := this.GetDefaultBrowser()
    }
    
    static GetDefaultBrowser() {
        try {
            return RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice", "ProgId")
        } catch {
            return "https://"  ; Fallback to system default
        }
    }
}

;; ============================================================================
;;                               Mode Manager
;; ============================================================================

class ModeManager {
    static modes := Map(
        "command", false,
        "number", false
    )
    
    static Toggle(mode) {
        if !this.modes.Has(mode)
            return false
            
        this.modes[mode] := !this.modes[mode]
        this.ShowNotification(mode, this.modes[mode])
        return this.modes[mode]
    }
    
    static IsActive(mode) {
        return this.modes.Has(mode) ? this.modes[mode] : false
    }
    
    static ShowNotification(mode, state) {
        message := StrTitle(mode) . " Mode: " . (state ? "ON" : "OFF")
        ToolTip(message)
        SetTimer(() => ToolTip(), -Config.TooltipDuration)
    }
}

;; ============================================================================
;;                            Window Management
;; ============================================================================

class WindowManager {
    static PlaceWindow(x, y, width, height, winId := "A") {
        try {
            if (winId = "A")
                winId := WinGetID("A")
                
            ; Restore window if minimized/maximized
            WinRestore(winId)
            
            ; Move and resize window
            WinMove(x, y, width, height, winId)
            
            return true
        } catch Error as e {
            this.ShowError("Failed to place window: " . e.message)
            return false
        }
    }
    
    static MaximizeToMonitor(monitorNum) {
        try {
            MonitorGet(monitorNum, &left, &top, &right, &bottom)
            width := right - left
            height := bottom - top
            return this.PlaceWindow(left + 2, top + 2, width - 4, height)
        } catch {
            return false
        }
    }
    
    static SplitVertical(leftSide := true) {
        try {
            screenWidth := A_ScreenWidth
            screenHeight := A_ScreenHeight
            halfWidth := screenWidth // 2
            
            x := leftSide ? 2 : halfWidth + 2
            return this.PlaceWindow(x, 2, halfWidth - 4, screenHeight)
        } catch {
            return false
        }
    }
    
    static ToggleAlwaysOnTop() {
        static topWindows := Map()
        
        try {
            winId := WinGetID("A")
            winTitle := WinGetTitle("A")
            
            isOnTop := topWindows.Has(winId)
            WinSetAlwaysOnTop(!isOnTop, winId)
            
            if (!isOnTop) {
                topWindows[winId] := winTitle
                message := winTitle . "`nStays on top!"
            } else {
                topWindows.Delete(winId)
                message := winTitle . "`nNOT on top!"
            }
            
            ToolTip(message)
            SetTimer(() => ToolTip(), -1500)
            
        } catch Error as e {
            this.ShowError("Failed to toggle always on top: " . e.message)
        }
    }
    
    static AlterTab(width, height) {
        ; Place current window on right side
        currentWin := WinGetID("A")
        WinMove(width, 0, width, height, currentWin)
        
        ; Get next window and place on left
        windows := WinGetList()
        for winId in windows {
            if (winId != currentWin && WinExist(winId)) {
                try {
                    title := WinGetTitle(winId)
                    if (title) {
                        WinActivate(winId)
                        WinMove(0, 0, width, height, winId)
                        return
                    }
                } catch {
                    continue
                }
            }
        }
    }
    
    static ShowError(message) {
        ToolTip("Error: " . message)
        SetTimer(() => ToolTip(), -3000)
    }
}

;; ============================================================================
;;                             Text Utilities
;; ============================================================================

class TextUtils {
    static SurroundSelection(leftChar, rightChar) {
        if (GetKeyState("Space", "P")) {
            ; Surround selected text
            oldClip := ClipboardAll()
            A_Clipboard := ""
            Send("^c")
            
            if (ClipWait(1)) {
                A_Clipboard := leftChar . A_Clipboard . rightChar
                Send("^v")
                Sleep(200)
            }
            
            A_Clipboard := oldClip
        } else {
            ; Insert brackets with cursor in between
            Send(leftChar . rightChar . "{Left}")
        }
    }
    
    static DuplicateLine(direction := "down") {
        if (direction = "up") {
            Send("{Home}{Home}{Enter}{Up}")
        } else {
            Send("{End}{End}{Enter}")
        }
    }
    
    static SmartEnter() {
        if (GetKeyState("Space", "P")) {
            Send("{Home}{Home}{Enter}{Up}")
        } else {
            Send("{End}{End}{Enter}")
        }
    }
    
    static SelectLine() {
        Send("{Home}{Home}{Shift Down}{End}{End}{Shift Up}")
    }
    
    static CopyLine() {
        Send("{Home}{Home}{Shift Down}{End}{End}{Shift Up}^c")
    }
    
    static DeleteLine() {
        Send("{Home}{Home}{Shift Down}{End}{End}{Shift Up}{Delete}")
    }
    
    static JoinLines(direction := "down") {
        if (direction = "down") {
            Send("{End}{Space}{Delete}{End}")
        } else {
            Send("{Home}{Home}{BackSpace}{Space}{End}")
        }
    }
}

;; ============================================================================
;;                              Search Manager
;; ============================================================================

class SearchManager {
    static engines := Map(
        "google", "https://www.google.com/search?q={query}&num=100&source=lnms&filter=0",
        "youtube", "https://www.youtube.com/results?search_query={query}"
    )
    
    static Search(engine, query := "", useSelection := false) {
        if (!this.engines.Has(engine)) {
            ToolTip("Unknown search engine: " . engine)
            SetTimer(() => ToolTip(), -2000)
            return
        }
        
        searchQuery := ""
        
        if (useSelection) {
            searchQuery := this.GetSelectedText()
            if (!searchQuery) {
                ToolTip("No text selected!")
                SetTimer(() => ToolTip(), -2000)
                return
            }
        } else if (query = "") {
            ; Prompt user for search term
            result := InputBox("Enter search term:", StrTitle(engine) . " Search")
            if (result.Result = "Cancel")
                return
            searchQuery := result.Text
        } else {
            searchQuery := query
        }
        
        if (!searchQuery)
            return
            
        url := StrReplace(this.engines[engine], "{query}", searchQuery)
        
        try {
            Run(url)
        } catch Error as e {
            ToolTip("Failed to open browser: " . e.message)
            SetTimer(() => ToolTip(), -3000)
        }
    }
    
    static GetSelectedText() {
        oldClip := ClipboardAll()
        A_Clipboard := ""
        Send("^c")
        
        if (ClipWait(1)) {
            result := A_Clipboard
            A_Clipboard := oldClip
            return Trim(result)
        }
        
        A_Clipboard := oldClip
        return ""
    }
}

;; ============================================================================
;;                             Clipboard Manager
;; ============================================================================

class ClipboardManager {
    static targetWindow := ""
    static targetTitle := ""
    
    static GatherText() {
        oldClip := ClipboardAll()
        A_Clipboard := ""
        Send("^c")
        
        if (!ClipWait(1)) {
            ToolTip("No text selected!")
            SetTimer(() => ToolTip(), -2000)
            return
        }
        
        ; Try to find existing notepad window
        if (WinExist("*Untitled - Notepad")) {
            ControlSetText(A_Clipboard . "`r`n`r`n", "Edit1", "*Untitled - Notepad")
        } else {
            ; Create new notepad window
            Run("notepad.exe")
            if (WinWait("Untitled - Notepad", , 3)) {
                ControlSetText(A_Clipboard . "`r`n`r`n", "Edit1", "Untitled - Notepad")
            }
        }
        
        A_Clipboard := oldClip
    }
    
    static CopyToTaggedWindow() {
        if (!this.targetWindow) {
            ToolTip("No target window tagged! Use Ctrl+Win+Shift+Z to tag a window.")
            SetTimer(() => ToolTip(), -3000)
            return
        }
        
        text := SearchManager.GetSelectedText()
        if (!text) {
            ToolTip("No text selected!")
            SetTimer(() => ToolTip(), -2000)
            return
        }
        
        if (!WinExist(this.targetTitle)) {
            ToolTip("Tagged window no longer exists!")
            SetTimer(() => ToolTip(), -3000)
            this.ResetTarget()
            return
        }
        
        currentWin := WinGetTitle("A")
        WinActivate(this.targetTitle)
        
        if (WinWaitActive(this.targetTitle, , 2)) {
            Send("^v`r`r")
            WinActivate(currentWin)
        }
    }
    
    static TagWindow() {
        MouseGetPos(, , &winId)
        this.targetWindow := winId
        this.targetTitle := WinGetTitle(winId)
        
        ToolTip('"' . this.targetTitle . '" tagged as destination!`nUse Alt+Shift+C to copy to this window.')
        SetTimer(() => ToolTip(), -4000)
    }
    
    static ResetTarget() {
        this.targetWindow := ""
        this.targetTitle := ""
        ToolTip("Target window reset!")
        SetTimer(() => ToolTip(), -2000)
    }
}

;; ============================================================================
;;                             Hotkey Handlers
;; ============================================================================

class HotkeyHandler {
    static wordAction := ""
    static lineAction := ""
    static saveAction := ""
    static findAction := ""
    
    ; Smart word operations (single/double/long press)
    static HandleWordAction() {
        result := KeyWait("t", "T" . Config.LongPressDuration/1000)
        
        if (!result) {
            ; Long press - select word
            Send("^{Left}{Shift Down}^{Right}{Shift Up}")
        } else {
            KeyWait("t")
            result := KeyWait("t", "D T" . Config.DoublePressTimeout/1000)
            
            if (!result) {
                ; Single press - copy word
                Send("^{Left}{Shift Down}^{Right}{Shift Up}^c")
            } else {
                ; Double press - delete word
                Send("^{Left}{Shift Down}^{Right}{Shift Up}{Delete}")
            }
        }
        KeyWait("t")
    }
    
    ; Smart line operations
    static HandleLineAction() {
        result := KeyWait("g", "T" . Config.LongPressDuration/1000)
        
        if (!result) {
            ; Long press - select line
            TextUtils.SelectLine()
        } else {
            KeyWait("g")
            result := KeyWait("g", "D T" . Config.DoublePressTimeout/1000)
            
            if (!result) {
                ; Single press - delete line
                TextUtils.DeleteLine()
            } else {
                ; Double press - copy line
                TextUtils.CopyLine()
            }
        }
        KeyWait("g")
    }
    
    ; Smart save operations
    static HandleSaveAction() {
        KeyWait("a")
        result := KeyWait("a", "D T" . Config.DoublePressTimeout/1000)
        
        if (!result) {
            ; Single press - save
            Send("^s")
        } else {
            ; Double press - save as
            if (WinActive("ahk_class XLMAIN")) {
                Send("{F12}")
            } else {
                Send("^+s")
            }
        }
    }
    
    ; Smart find operations
    static HandleFindAction() {
        result := KeyWait("x", "T" . Config.LongPressDuration/1000)
        
        if (!result) {
            ; Long press - find selected text
            selectedText := SearchManager.GetSelectedText()
            if (selectedText) {
                Send("^f")
                Send("^v")
                Sleep(500)
                Send("{Enter}")
            }
        } else {
            ; Short press - open find dialog
            Send("^f")
        }
        KeyWait("x")
    }
}

;; ============================================================================
;;                              Excel Helpers
;; ============================================================================

class ExcelHelpers {
    static IsExcelActive() {
        return WinActive("ahk_class XLMAIN")
    }
    
    static PasteSpecial(type) {
        if (!this.IsExcelActive())
            return
            
        switch type {
            case "values":
                Send("^!v{v}{Enter}")
            case "formulas":
                Send("^!v{f}{Enter}")
            case "formatting":
                Send("^!v{t}{Enter}")
            case "links":
                Send("^!v{l}")
        }
    }
}

;; ============================================================================
;;                              Launcher System
;; ============================================================================

class Launcher {
    static commands := Map(
        ; Delete operations
        "fa", () => Send("^a{Delete}"),
        "fs", () => Send("{Shift Down}{Home}{Home}{Shift Up}{Delete}"),
        "fe", () => Send("{Shift Down}{End}{End}{Shift Up}{Delete}"),
        
        ; Copy operations  
        "da", () => Send("^a^c"),
        "ds", () => Send("{Shift Down}{Home}{Home}{Shift Up}^c"),
        "de", () => Send("{Shift Down}{End}{End}{Shift Up}^c"),
        
        ; Cut operations
        "va", () => Send("^a^x"),
        "vw", () => Send("^{Right}{Shift Down}^{Left}{Shift Up}^x"),
        "vv", () => Send("{Home}{Home}{Shift Down}{End}{End}{Shift Up}^x"),
        "vs", () => Send("{Shift Down}{Home}{Home}{Shift Up}^x"),
        "ve", () => Send("{Shift Down}{End}{End}{Shift Up}^x"),
        
        ; Select operations
        "sa", () => Send("^a"),
        "ss", () => Send("{Shift Down}{Home}{Home}{Shift Up}"),
        "se", () => Send("{Shift Down}{End}{End}{Shift Up}")
    )
    
    static Show() {
        ; Get two character input
        ih := InputHook("L2 T" . Config.SearchTimeout)
        ih.Start()
        ih.Wait()
        
        command := ih.Input
        
        if (this.commands.Has(command)) {
            this.commands[command]()
        } else if (command) {
            ToolTip("Unknown command: " . command)
            SetTimer(() => ToolTip(), -2000)
        }
    }
}

;; ============================================================================
;;                                Number Mode
;; ============================================================================

class NumberMode {
    static keyMap := Map(
        "Space", "0", "m", "1", ",", "2", ".", "3", "j", "4", "k", "5", "l", "6",
        "u", "7", "i", "8", "o", "9", "p", "*", "[", "/", "'", "-", "SC027", "+",
        "/", ".", "n", ",", "h", "=",
        ; Alternative layout
        "x", "1", "c", "2", "v", "3", "s", "4", "d", "5", "f", "6",
        "w", "7", "e", "8", "r", "9", "1", "/", "2", "*", "q", "-",
        "z", ".", "a", "+", "g", "="
    )
    
    static IsActive() {
        return ModeManager.IsActive("number")
    }
}

;; ============================================================================
;;                              Mouse Utilities
;; ============================================================================

class MouseUtils {
    static dragData := Map()
    
    static StartWindowDrag() {
        MouseGetPos(&startX, &startY, &winId)
        WinGetPos(&winX, &winY, , , winId)
        
        ; Only drag if window is not maximized
        winState := WinGetMinMax(winId)
        if (winState != 0)
            return
            
        this.dragData := Map(
            "startX", startX,
            "startY", startY,
            "winId", winId,
            "originalX", winX,
            "originalY", winY
        )
        
        SetTimer((*) => this.UpdateWindowDrag(), 10)
    }
    
    static UpdateWindowDrag() {
        ; Check if button is still held
        if (!GetKeyState("RButton", "P")) {
            SetTimer((*) => this.UpdateWindowDrag(), 0)
            return
        }
        
        ; Check for escape
        if (GetKeyState("Escape", "P")) {
            SetTimer((*) => this.UpdateWindowDrag(), 0)
            WinMove(this.dragData["originalX"], this.dragData["originalY"], , , this.dragData["winId"])
            return
        }
        
        ; Update window position
        MouseGetPos(&currentX, &currentY)
        WinGetPos(&winX, &winY, , , this.dragData["winId"])
        
        newX := winX + currentX - this.dragData["startX"]
        newY := winY + currentY - this.dragData["startY"]
        
        WinMove(newX, newY, , , this.dragData["winId"])
        WinActivate(this.dragData["winId"])
        
        ; Update start position for next iteration
        this.dragData["startX"] := currentX
        this.dragData["startY"] := currentY
    }
}

;; ============================================================================
;;                              Initialize
;; ============================================================================

; Initialize configuration
Config.Init()

;; ============================================================================
;;                                Hotkeys
;; ============================================================================

; ------------------ Mouse Buttons ------------------
XButton2::Send("{Enter}")
XButton1::Send("{Delete}")
CapsLock & LButton::Click(2)

; ------------------ CapsLock Toggle ------------------
#CapsLock::{
    if GetKeyState("CapsLock", "T")
        SetCapsLockState("AlwaysOff")
    else
        SetCapsLockState("AlwaysOn")
}

; ------------------ Main Navigation ------------------
CapsLock & q::Send("{Escape}")
CapsLock & w::Launcher.Show()
CapsLock & e::Send("^z")
CapsLock & r::Send("^y")
CapsLock & t::HotkeyHandler.HandleWordAction()
CapsLock & y::Send("{Blind}{Home}")
CapsLock & u::Send("{Blind}{PgUp}")
CapsLock & i::Send("{Blind}{Up}")
CapsLock & o::Send("{Blind}{PgDn}")
CapsLock & p::Send("{Blind}{End}")

CapsLock & a::HotkeyHandler.HandleSaveAction()
CapsLock & s::Send("^x")
CapsLock & d::Send("^c")
CapsLock & f::Send("^v")
CapsLock & g::HotkeyHandler.HandleLineAction()
CapsLock & h::Send("{Blind}^{Left}")
CapsLock & j::Send("{Blind}{Left}")
CapsLock & k::Send("{Blind}{Down}")
CapsLock & l::Send("{Blind}{Right}")
CapsLock & SC027::Send("{Blind}^{Right}")

CapsLock & z::AltTab
CapsLock & x::HotkeyHandler.HandleFindAction()
CapsLock & c::Send("{Enter}")
CapsLock & v::Send("{Delete}")
CapsLock & b::Send("{Blind}{BS}")
CapsLock & n::Send("{Blind}{BS}")
CapsLock & m::Send("{Blind}^{BS}")
CapsLock & ,::Send("{Delete}")
CapsLock & .::Send("^{Delete}")
CapsLock & /::Send("{Enter}")

; ------------------ Text Surrounding ------------------
CapsLock & 9::TextUtils.SurroundSelection("(", ")")
CapsLock & 0::TextUtils.SurroundSelection("'", "'")
CapsLock & '::TextUtils.SurroundSelection('"', '"')
CapsLock & [::TextUtils.SurroundSelection("[", "]")
CapsLock & ]::TextUtils.SurroundSelection("{", "}")

; ------------------ Line Editing ------------------
CapsLock & Enter::TextUtils.SmartEnter()
CapsLock & Home::Send("{Home}{Home}{Shift Down}{End}{End}{Shift Up}^c{End}{Enter}^v{Up}{End}")
CapsLock & End::Send("{Home}{Home}{Shift Down}{End}{End}{Shift Up}^c{End}{Enter}^v")
CapsLock & PgDn::TextUtils.JoinLines("down")
CapsLock & PgUp::TextUtils.JoinLines("up")

; ------------------ Function Keys ------------------
CapsLock & F1::Send("{AppsKey}")
CapsLock & F11::ModeManager.Toggle("command")
CapsLock & F12::WindowManager.ToggleAlwaysOnTop()

; ------------------ Number Keys ------------------
CapsLock & `::ModeManager.Toggle("number")
CapsLock & 1::Send("{AppsKey}")
CapsLock & 2::Send("{F2}")
CapsLock & 3::Send("=")
CapsLock & 5::Send("{Blind}^{Home}")
CapsLock & 6::Send("{Blind}^{End}")
CapsLock & 7::Send("{PgUp}")
CapsLock & 8::Send("{PgDn}")
CapsLock & -::Send("_")
CapsLock & =::Send("{+}")

; ------------------ Special Keys ------------------
CapsLock & Alt::Send("{Blind}{Alt}")
CapsLock & Space::return
CapsLock & BS::Send("{Blind}^{BS}")
#Space::Send("{Space}{Left}")

CapsLock & Tab::Send("{Blind}{Shift Down}")
CapsLock & Tab up::Send("{Blind}{Shift Up}")

; ------------------ Excel Specific ------------------
#HotIf WinActive("ahk_class XLMAIN")
WheelLeft::Send("!{PgUp}")
WheelRight::Send("!{PgDn}")

`::Send(",")
CapsLock & 1::Send("^[")
CapsLock & 2::Send("{F5}{Enter}")
CapsLock & 3::Send("=")
CapsLock & 4::Send("{F4}")

+!v::ExcelHelpers.PasteSpecial("values")
^!f::ExcelHelpers.PasteSpecial("formulas")
^!t::ExcelHelpers.PasteSpecial("formatting")
^!z::ExcelHelpers.PasteSpecial("links")

CapsLock & u::Send("^{Up}")
CapsLock & o::Send("^{Down}")
CapsLock & [::Send("^{PgUp}")
CapsLock & ]::Send("^{PgDn}")

!,::Send("^{PgUp}")
!.::Send("^{PgDn}")

CapsLock & b::Send("^d")
CapsLock & t::Send("^r")
CapsLock & g::Send("{F2}")

CapsLock & F1::Send("-")
CapsLock & F2::Send("{+}")
CapsLock & F3::Send("*")
CapsLock & F4::Send("/")

CapsLock & Enter::{
    if GetKeyState("Space", "P")
        Send("{Home}!{Enter}{Up}")
    else
        Send("{End}!{Enter}")
}
#HotIf

; ------------------ Command Mode Window Management ------------------
#HotIf ModeManager.IsActive("command")
!+1::WindowManager.MaximizeToMonitor(1)
!+2::WindowManager.MaximizeToMonitor(2)
!+e::WindowManager.SplitVertical(true)
!+r::WindowManager.SplitVertical(false)
!+a::WindowManager.AlterTab(A_ScreenWidth//2, A_ScreenHeight)
!+d::WindowManager.AlterTab(A_ScreenWidth, A_ScreenHeight)
#HotIf

; ------------------ Number Mode ------------------
#HotIf ModeManager.IsActive("number")
Space::Send("0")
m::Send("1")
,::Send("2")
.::Send("3")
j::Send("4")
k::Send("5")
l::Send("6")
u::Send("7")
i::Send("8")
o::Send("9")
p::Send("*")
[::Send("/")
'::Send("-")
SC027::Send("{+}")  ; Using scan code like original
/::Send(".")
n::Send(",")
h::Send("=")

; Alternative layout
x::Send("1")
c::Send("2")
v::Send("3")
s::Send("4")
d::Send("5")
f::Send("6")
w::Send("7")
e::Send("8")
r::Send("9")
1::Send("/")
2::Send("*")
q::Send("-")
z::Send(".")
a::Send("{+}")  ; Keep 'a' for alternative layout
g::Send("=")

; Make sure space works in number mode
CapsLock & Space::Send("{Space}")
#HotIf

; ------------------ Search Functions ------------------
#y::SearchManager.Search("youtube")
#+y::SearchManager.Search("youtube", , true)
#s::SearchManager.Search("google")
#+s::SearchManager.Search("google", , true)

; ------------------ Window Controls ------------------
!+q::Send("!{F4}")
!+k::WinMinimize("A")

; ------------------ Alt Key Remapping ------------------
RAlt::RControl

; ------------------ Mouse Window Dragging ------------------
CapsLock & RButton::MouseUtils.StartWindowDrag()

; ------------------ Clipboard Functions ------------------
^!c::ClipboardManager.GatherText()
+!c::ClipboardManager.CopyToTaggedWindow()
^#+z::ClipboardManager.TagWindow()
^#+r::ClipboardManager.ResetTarget()

; ------------------ Numpad Navigation ------------------
CapsLock & Numpad8::Send("{Blind}{Up}")
CapsLock & Numpad4::Send("{Blind}{Left}")
CapsLock & Numpad5::Send("{Blind}{Down}")
CapsLock & Numpad6::Send("{Blind}{Right}")
CapsLock & NumpadDiv::Send("{Blind}^{Up}")
CapsLock & Numpad7::Send("{Blind}^{Left}")
CapsLock & Numpad2::Send("{Blind}^{Down}")
CapsLock & Numpad9::Send("{Blind}^{Right}")
CapsLock & Numpad1::Send("{Blind}{BS}")
CapsLock & Numpad3::Send("{Blind}{Delete}")
CapsLock & Numpad0::Send("{F2}")
CapsLock & NumpadAdd::Send("{Blind}=")
CapsLock & NumpadEnter::Send("{Blind}^{Enter}")
CapsLock & NumLock::Send("{Escape}")

; ------------------ Exit Controls ------------------
>^q::{
    result := MsgBox("Exit AutoHotkey script?", "Confirm Exit", "YesNo")
    if (result = "Yes")
        ExitApp()
}

;; ============================================================================
;;                              Status Messages  
;; ============================================================================

; Show startup message
ToolTip("AutoHotkey v2 Productivity Suite Loaded!`nPress CapsLock+F11 for Command Mode`nPress CapsLock+` for Number Mode")
SetTimer(() => ToolTip(), -3000)