; 無変換キーをベースとしたショートカットキー割当
; -----------------------------------

CapsLock::Ctrl

; 無変換の単発押しは無変換
; vk1D::vk1D

; -----------------------------------
; vimのcursolkey
; -----------------------------------
vk1D & h::Left
vk1D & j::Down
vk1D & k::Up
vk1D & l::Right

; -----------------------------------
; wort jump
; -----------------------------------
vk1D & u::
    if GetKeyState("Shift") {
        Send ^+{Left}
        return
    }
    Send ^{Left}
    return

vk1D & i::
    if GetKeyState("Shift") {
        Send ^{Right}
        return
    }
    Send ^{Right}
    return

; -----------------------------------
; コロン(vkBA)とセミコロン(vkBB)とスペースをEnter
; -----------------------------------
vk1D & vkBa::Enter 
vk1D & vkBB::Enter
vk1D & Space::Enter

; -----------------------------------
; Home / End / BS / Del
; -----------------------------------
vk1D & a::Home
vk1D & e::End
vk1D & n::BS
vk1D & m::Del

; -----------------------------------
; カーソル位置から行末まで削除
; -----------------------------------
vk1D & o::
    send {ShiftDown}{End}{ShiftUp}
    send ^c
    send {Del}
    return

; -----------------------------------
; 変換キーをベースとしたショートカットキー割当
; -----------------------------------

; 変換の単発押しは変換
; vk1C::vk1C

; -----------------------------------
; 変換キー + Home, End, PageUp, PageDown
; -----------------------------------
vk1C & h::Home
vk1C & j::PgDn
vk1C & k::PgUp
vk1C & l::End

; -----------------------------------
; altキーをベースとしたショートカットキー割当 
; -----------------------------------

; -----------------------------------
; vscode 定義元ジャンプ
; vscode shortcut F12
; -----------------------------------
vk1C & p::F12

; -----------------------------------
; vscode 定義元ジャンプから戻る
; vscode shortcut Alt + LeftArrow
; -----------------------------------
vk1C & o::Send, !{Left}

; -----------------------------------
; vscode プレビュー表示
; vscode Ctrl + Shift + F10
;  -----------------------------------
vk1C & i::Send, {^!F10}

; -----------------------------------
; IME Script
; -----------------------------------
IME_SET(SetSts, WinTitle="A")    {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

   return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}

; -----------------------------------
; 無変換 + [ をescキーに割り当て
; -----------------------------------
vk1d & [::Send, {Esc}

; -----------------------------------
; alt tab + alt shift tab
; -----------------------------------
vk1D & f::AltTab
vk1D & d::ShiftAltTab

; -----------------------------------
; 右クリックメニュー
; -----------------------------------
vk1D & g::Send, {AppsKey}

; -----------------------------------
; rename
;  -----------------------------------
vk1C & r::F2

; ; -----------------------------------
; ; 日本語入力
; ; -----------------------------------
; vk1D & 0::
; IME_SET(1)
; return

; ; -----------------------------------
; ; 英語入力
; ; -----------------------------------
; vk1D & 9::
; IME_SET(0)
; return