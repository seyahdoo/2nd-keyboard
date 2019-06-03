SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv
SendMode Input
#InstallKeybdHook
#InstallMouseHook
#UseHook On
#SingleInstance force
#Persistent
#MaxHotkeysPerInterval 2000
#WinActivateForce
detecthiddenwindows, on
SetNumLockState, AlwaysOn

;-------------------------
;;TRAY CODE;;

Menu Tray, Icon
Menu,Tray, Icon, shell32.dll, 44
Menu,Tray, NoStandard 
Menu Tray, Add, WindowSpy, WindowSpy
Menu Tray, Add, Edit, EditScript
Menu Tray, Add, Reload, ReloadScript
Menu Tray, Add, Close Extra Keyboard, CloseItem
Menu Tray, Default, Reload

WindowSpy(){
	Run C:\AHK\Library\ActiveWindowInfo.ahk
}

EditScript(){
	Edit
}

CloseItem(){
	ExitApp
}

ReloadScript(){
	Reload
}

;END of TRAY CODE
;-----------------------------


#include C:\AHK\Library\Almost_All_Windows_Functions.ahk
#include C:\AHK\Library\Firefox_Functions.ahk
#include C:\AHK\Library\NoFunction.ahk
#include C:\AHK\Library\Firefox_Youtube.ahk
#include C:\AHK\Library\Keyboard_Led_Controll.ahk


;-------------------------
;;WIN KEY MACRO;;
;Open Launchy with AppsKey button -> will be swapped with Windows key via intercept.exe
AppsKey::
	IfWinActive, ahk_exe Wox.exe
	{
		Send ^a
	}
	Else
	{
		Send {F13}
		WinWait, ahk_exe Wox.exe, , 1
		if ErrorLevel
		{
			SoundBeep
			Return
		}
		Else
		{
			;WinActivate, ahk_exe Wox.exe, , 1
			;Send ^a
		}

	}
	Return

;END of KEY MACRO
;-----------------------------


;-------------------------
;;NUM KEYBOARD MACROS;;

Browser_Home::
;Tab::
Launch_Mail::
Launch_App2::


NumLock::
NumpadDiv::
NumpadMult::
;Backspace::


Numpad7:: youtube_next()
Numpad8:: youtube_next()
Numpad9:: youtube_next()
NumpadSub::

Numpad4:: youtube_prev()
Numpad5:: youtube_play_pause()
Numpad6:: youtube_next()
NumpadAdd::

Numpad1:: Tippy("Num1")

Numpad2:: 
	UnmuteMic()
	KeyboardLED(2, "off", 4)
	Return

Numpad3:: 
	MuteMic()
	KeyboardLED(2, "on", 4)
	Return

Numpad0:: ReloadScript()
;Space::
NumpadDot::
NumpadEnter::

;END of NUM KEYBOARD MACROS
;-----------------------------


;-------------------------
;;SECOND KEYBOARD MACROS;;
#if (getKeyState("F23", "P"))
F23::return

F2::Send {Volume_Down}
F3::Send {Volume_Up}
F4::Send {Volume_Mute}

return
#if
;END of SECOND KEYBOARD MACROS
;-----------------------------


