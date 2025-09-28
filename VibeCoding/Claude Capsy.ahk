;; ============================================================================
;;                        Modern AutoHotkey v2 Productivity Suite
;; ============================================================================

#SingleInstance Force
#WinActivateForce
#Warn LocalSameAsGlobal, Off  ; Suppress warnings for function calls in hotkeys
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 60000
SendMode("Input")
SetCapsLockState("AlwaysOff")
CoordMode("Mouse", "Screen")

;; ============================================================================
;;                    Window Management - Complete Implementation
;; ============================================================================

TileWindows() {
    ; Get current window and work area
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(MonitorGetPrimary(), &L, &T, &R, &B)
    W := (R - L) // 2
    H := B - T
    
    ; Get all windows and find next valid one
    Windows := WinGetList()
    NextWin := 0
    Found := false
    
    ; Find next visible, non-minimized window after current
    for ID in Windows {
        if (Found && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
            NextWin := ID
            break
        }
        if (ID == CurrWin) {
            Found := true
        }
    }
    
    ; If no window found after current, take first valid window
    if (!NextWin) {
        for ID in Windows {
            if (ID != CurrWin && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
                NextWin := ID
                break
            }
        }
    }
    
    ; Tile windows
    if (NextWin) {
        ; Both windows: Next left, Current right
        if (WinGetMinMax("ahk_id " . NextWin) == 1) {
            WinRestore("ahk_id " . NextWin)
        }
        if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
            WinRestore("ahk_id " . CurrWin)
        }
        WinMove(L, T, W, H, "ahk_id " . NextWin)
        WinMove(L + W, T, W, H, "ahk_id " . CurrWin)
        WinActivate("ahk_id " . NextWin)  ; Activate previous window instead
    } else {
        ; Single window: Current right
        if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
            WinRestore("ahk_id " . CurrWin)
        }
        WinMove(L + W, T, W, H, "ahk_id " . CurrWin)
    }
}

MaximizeWindow() {
    WinMaximize("A")
}

MaximizeToMonitor1() {
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(1, &L, &T, &R, &B)
    W := R - L
    H := B - T
    
    if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
        WinRestore("ahk_id " . CurrWin)
    }
    WinMove(L, T, W, H, "ahk_id " . CurrWin)
}

MaximizeToMonitor2() {
    ; Check if Monitor 2 exists
    if (MonitorGetCount() < 2) {
        ToolTip("Monitor 2 not found!")
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(2, &L, &T, &R, &B)
    W := R - L
    H := B - T
    
    if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
        WinRestore("ahk_id " . CurrWin)
    }
    WinMove(L, T, W, H, "ahk_id " . CurrWin)
}

MaximizeToMonitor3() {
    ; Check if Monitor 3 exists
    if (MonitorGetCount() < 3) {
        ToolTip("Monitor 3 not found!")
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(3, &L, &T, &R, &B)
    W := R - L
    H := B - T
    
    if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
        WinRestore("ahk_id " . CurrWin)
    }
    WinMove(L, T, W, H, "ahk_id " . CurrWin)
}

TileLeftMonitor2() {
    ; Check if Monitor 2 exists
    if (MonitorGetCount() < 2) {
        ToolTip("Monitor 2 not found!")
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(2, &L, &T, &R, &B)
    W := (R - L) // 2
    H := B - T
    
    if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
        WinRestore("ahk_id " . CurrWin)
    }
    WinMove(L, T, W, H, "ahk_id " . CurrWin)
}

TileRightMonitor2() {
    ; Check if Monitor 2 exists
    if (MonitorGetCount() < 2) {
        ToolTip("Monitor 2 not found!")
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(2, &L, &T, &R, &B)
    W := (R - L) // 2
    H := B - T
    
    if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
        WinRestore("ahk_id " . CurrWin)
    }
    WinMove(L + W, T, W, H, "ahk_id " . CurrWin)
}

SwapWindows() {
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    ; Find previous window in Alt+Tab order (same logic as TileWindows)
    Windows := WinGetList()
    PrevWin := 0
    Found := false
    
    ; Find next window after current in Z-order
    for ID in Windows {
        if (Found && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
            PrevWin := ID
            break
        }
        if (ID == CurrWin) {
            Found := true
        }
    }
    
    ; If no window found after current, take first valid window
    if (!PrevWin) {
        for ID in Windows {
            if (ID != CurrWin && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
                PrevWin := ID
                break
            }
        }
    }
    
    ; Swap positions and sizes if previous window exists
    if (PrevWin) {
        ; Get current positions and sizes
        WinGetPos(&CurrX, &CurrY, &CurrW, &CurrH, "ahk_id " . CurrWin)
        WinGetPos(&PrevX, &PrevY, &PrevW, &PrevH, "ahk_id " . PrevWin)
        
        ; Restore windows if maximized
        if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
            WinRestore("ahk_id " . CurrWin)
        }
        if (WinGetMinMax("ahk_id " . PrevWin) == 1) {
            WinRestore("ahk_id " . PrevWin)
        }
        
        ; Simple swap - previous window moves to current position, current moves to previous position
        WinMove(CurrX, CurrY, CurrW, CurrH, "ahk_id " . PrevWin)
        WinMove(PrevX, PrevY, PrevW, PrevH, "ahk_id " . CurrWin)
        
        ; Make previous window active
        WinActivate("ahk_id " . PrevWin)
    }
}

TileLeft() {
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(MonitorGetPrimary(), &L, &T, &R, &B)
    W := (R - L) // 2
    H := B - T
    
    if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
        WinRestore("ahk_id " . CurrWin)
    }
    WinMove(L, T, W, H, "ahk_id " . CurrWin)
}

TileRight() {
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(MonitorGetPrimary(), &L, &T, &R, &B)
    W := (R - L) // 2
    H := B - T
    
    if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
        WinRestore("ahk_id " . CurrWin)
    }
    WinMove(L + W, T, W, H, "ahk_id " . CurrWin)
}

Tile2to1() {
    ; Get current window and work area
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    MonitorGetWorkArea(MonitorGetPrimary(), &L, &T, &R, &B)
    TotalW := R - L
    H := B - T
    LeftW := (TotalW * 2) // 3    ; 2/3 width
    RightW := TotalW - LeftW      ; 1/3 width (remaining space)
    
    ; Find next window (same logic as TileWindows)
    Windows := WinGetList()
    NextWin := 0
    Found := false
    
    for ID in Windows {
        if (Found && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
            NextWin := ID
            break
        }
        if (ID == CurrWin) {
            Found := true
        }
    }
    
    if (!NextWin) {
        for ID in Windows {
            if (ID != CurrWin && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
                NextWin := ID
                break
            }
        }
    }
    
    ; Tile windows
    if (NextWin) {
        ; Previous window 2/3 left, Current window 1/3 right
        if (WinGetMinMax("ahk_id " . NextWin) == 1) {
            WinRestore("ahk_id " . NextWin)
        }
        if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
            WinRestore("ahk_id " . CurrWin)
        }
        WinMove(L, T, LeftW, H, "ahk_id " . NextWin)
        WinMove(L + LeftW, T, RightW, H, "ahk_id " . CurrWin)
        WinActivate("ahk_id " . NextWin)  ; Activate previous window
    } else {
        ; Single window: Current takes 1/3 right
        if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
            WinRestore("ahk_id " . CurrWin)
        }
        WinMove(L + LeftW, T, RightW, H, "ahk_id " . CurrWin)
    }
}

MaximizeAllWindows() {
    Windows := WinGetList()
    
    for ID in Windows {
        ; Skip windows without titles or minimized windows
        if (WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
            ; Get which monitor this window is primarily on
            WinGetPos(&WinX, &WinY, &WinWidth, &WinHeight, "ahk_id " . ID)
            WinCenterX := WinX + (WinWidth // 2)
            WinCenterY := WinY + (WinHeight // 2)
            
            ; Find which monitor contains the center of this window
            MonitorCount := MonitorGetCount()
            TargetMonitor := 1  ; Default to monitor 1
            
            Loop MonitorCount {
                MonitorGet(A_Index, &MonLeft, &MonTop, &MonRight, &MonBottom)
                if (WinCenterX >= MonLeft && WinCenterX <= MonRight && 
                    WinCenterY >= MonTop && WinCenterY <= MonBottom) {
                    TargetMonitor := A_Index
                    break
                }
            }
            
            ; Get work area of the target monitor and resize window
            MonitorGetWorkArea(TargetMonitor, &L, &T, &R, &B)
            W := R - L
            H := B - T
            
            ; Restore if maximized, then resize to full work area
            if (WinGetMinMax("ahk_id " . ID) == 1) {
                WinRestore("ahk_id " . ID)
            }
            WinMove(L, T, W, H, "ahk_id " . ID)
        }
    }
}

TileDualMonitors() {
    ; Check if Monitor 2 exists
    if (MonitorGetCount() < 2) {
        ToolTip("Monitor 2 not found!")
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    ; Get current window
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    ; Get work areas for both monitors
    MonitorGetWorkArea(1, &L1, &T1, &R1, &B1)
    MonitorGetWorkArea(2, &L2, &T2, &R2, &B2)
    W1 := R1 - L1
    H1 := B1 - T1
    W2 := R2 - L2
    H2 := B2 - T2
    
    ; Find previous window in Alt+Tab order (same logic as TileWindows)
    Windows := WinGetList()
    PrevWin := 0
    Found := false
    
    for ID in Windows {
        if (Found && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
            PrevWin := ID
            break
        }
        if (ID == CurrWin) {
            Found := true
        }
    }
    
    if (!PrevWin) {
        for ID in Windows {
            if (ID != CurrWin && WinGetTitle("ahk_id " . ID) != "" && !(WinGetMinMax("ahk_id " . ID) == -1)) {
                PrevWin := ID
                break
            }
        }
    }
    
    ; Tile windows to different monitors
    if (PrevWin) {
        ; Current window to Monitor 2, Previous window to Monitor 1 (primary)
        if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
            WinRestore("ahk_id " . CurrWin)
        }
        if (WinGetMinMax("ahk_id " . PrevWin) == 1) {
            WinRestore("ahk_id " . PrevWin)
        }
        WinMove(L2, T2, W2, H2, "ahk_id " . CurrWin)
        WinMove(L1, T1, W1, H1, "ahk_id " . PrevWin)
        WinActivate("ahk_id " . PrevWin)  ; Activate previous window
    } else {
        ; Single window: Current to Monitor 2
        if (WinGetMinMax("ahk_id " . CurrWin) == 1) {
            WinRestore("ahk_id " . CurrWin)
        }
        WinMove(L2, T2, W2, H2, "ahk_id " . CurrWin)
    }
}

MoveToNextMonitor() {
    try {
        CurrWin := WinGetID("A")
    } catch {
        return  ; No active window, exit silently
    }
    
    ; Check if we have multiple monitors
    MonitorCount := MonitorGetCount()
    if (MonitorCount < 2) {
        return  ; Only one monitor, nothing to do
    }
    
    ; Get current window position to determine which monitor it's on
    WinGetPos(&WinX, &WinY, &WinWidth, &WinHeight, "ahk_id " . CurrWin)
    WinCenterX := WinX + (WinWidth // 2)
    WinCenterY := WinY + (WinHeight // 2)
    
    ; Find which monitor contains the center of this window
    CurrentMonitor := 1  ; Default to monitor 1
    
    Loop MonitorCount {
        MonitorGet(A_Index, &MonLeft, &MonTop, &MonRight, &MonBottom)
        if (WinCenterX >= MonLeft && WinCenterX <= MonRight && 
            WinCenterY >= MonTop && WinCenterY <= MonBottom) {
            CurrentMonitor := A_Index
            break
        }
    }
    
    ; Calculate next monitor (cycle back to 1 if at the last monitor)
    NextMonitor := (CurrentMonitor == MonitorCount) ? 1 : CurrentMonitor + 1
    
    ; Get work areas for current and next monitor
    MonitorGetWorkArea(CurrentMonitor, &CurrL, &CurrT, &CurrR, &CurrB)
    MonitorGetWorkArea(NextMonitor, &NextL, &NextT, &NextR, &NextB)
    
    ; Calculate relative position within current monitor
    RelativeX := WinX - CurrL
    RelativeY := WinY - CurrT
    
    ; Calculate new position on next monitor (same relative position)
    NewX := NextL + RelativeX
    NewY := NextT + RelativeY
    
    ; Ensure window doesn't go outside next monitor bounds
    NextW := NextR - NextL
    NextH := NextB - NextT
    
    if (NewX + WinWidth > NextR) {
        NewX := NextR - WinWidth
    }
    if (NewY + WinHeight > NextB) {
        NewY := NextB - WinHeight
    }
    if (NewX < NextL) {
        NewX := NextL
    }
    if (NewY < NextT) {
        NewY := NextT
    }
    
    ; Move window to next monitor (same size, new position)
    WinMove(NewX, NewY, WinWidth, WinHeight, "ahk_id " . CurrWin)
}

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
            searchQuery := result.Value  ; Changed from .Text to .Value
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
    
    static CopyToTaggedWindow() {
        if (!this.targetWindow) {
            ToolTip("No target window tagged! Use Ctrl+Win+Shift+Z to tag a window.")
            SetTimer(() => ToolTip(), -3000)
            return
        }
        
        ; Get selected text directly
        oldClip := ClipboardAll()
        A_Clipboard := ""
        Send("^c")
        
        if (!ClipWait(1)) {
            ToolTip("No text selected!")
            SetTimer(() => ToolTip(), -2000)
            A_Clipboard := oldClip
            return
        }
        
        textToCopy := A_Clipboard
        
        if (!WinExist(this.targetTitle)) {
            ToolTip("Tagged window no longer exists!")
            SetTimer(() => ToolTip(), -3000)
            this.ResetTarget()
            A_Clipboard := oldClip
            return
        }
        
        currentWin := WinGetTitle("A")
        WinActivate(this.targetTitle)
        
        if (WinWaitActive(this.targetTitle, , 2)) {
            Send("^v`r`r")
            WinActivate(currentWin)
        }
        
        A_Clipboard := oldClip
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
CapsLock & x::Send("^f")
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

; ------------------ Window Management Hotkeys ------------------
!+a::TileWindows()
!+1::MaximizeToMonitor1()
!+2::MaximizeToMonitor2()
!+3::MaximizeToMonitor3()
!+4::TileLeftMonitor2()
!+5::TileRightMonitor2()
!+s::SwapWindows()
!+e::TileLeft()
!+r::TileRight()
!+t::Tile2to1()
!+d::TileDualMonitors()
!+z::MoveToNextMonitor()
!+x::MaximizeAllWindows()

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

; ------------------ Clipboard Functions ------------------
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