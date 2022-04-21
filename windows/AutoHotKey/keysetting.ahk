; -----------------------------------
; capslock無効化
; -----------------------------------
CapsLock::Ctrl
; -----------------------------------
; 無変換キーをベースとしたショートカットキー割当
; -----------------------------------
; 無変換の単発押しは無変換
;vk1D::vk1D
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
    Send ^{Left}
    return
vk1D & i::
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
; alt tab + alt shift tab
; -----------------------------------
vk1D & f::AltTab
vk1D & d::ShiftAltTab
; -----------------------------------
; 右クリックメニュー
; -----------------------------------
vk1D & g::Send, {AppsKey}
; -----------------------------------
; 無変換 + [ をescキーに割り当て
; -----------------------------------
vk1d & [::Send, {Esc}
vk1d & .::Send, {Esc}
; -----------------------------------
; 変換キーをベースとしたショートカットキー割当
; -----------------------------------
; 変換の単発押しは変換
;vk1C::vk1C
; -----------------------------------
; 変換キー + Home, End, PageUp, PageDown
; -----------------------------------
vk1C & h::Home
vk1C & j::PgDn
vk1C & k::PgUp
vk1C & l::End
; -----------------------------------
; alt tab + alt shift tab
; -----------------------------------
vk1C & f::AltTab
vk1C & d::ShiftAltTab
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
vk1D::
IME_SET(0)
return
vk1C::
IME_SET(1)
return
; -----------------------------------
; 2文字入力のショートカット
; -----------------------------------
vk1C & a::func2Key()
func2Key(){
    ; 2キーの入力を待つ(L2)
    Input, UserInput, L2
    switch UserInput {
        case "aa": Send, abc
        ; ファイル名変更
        case "re": Send, {F2}
        ; vscode 定義元ジャンプ
        ; F12
        case "dj": Send, {F12}
        ; vscode 定義元ジャンプから戻る
        ; Alt + Left
        case "db": Send, !{Left}
        ; vscode 定義プレビュー
        ; Alt + F12
        case "dp": Send, !{F12}
    }
}
; -----------------------------------
; rename
; -----------------------------------
vk1C & r::F2