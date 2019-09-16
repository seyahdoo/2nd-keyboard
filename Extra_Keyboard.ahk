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


Numpad7:: Send {Volume_Down}
Numpad8:: Send {Volume_Mute}
Numpad9:: Send {Volume_Up}
NumpadSub:: Send {Volume_Down}

Numpad4:: 
	IfWinExist, ahk_exe mpc-hc64.exe
	{
		Send {Media_Prev}
		Return
	} Else {
		youtube_prev()
		Return
	}
	
Numpad5:: 
	IfWinExist, ahk_exe mpc-hc64.exe
	{
		Send {Media_Play_Pause}
		Return
	} Else {
		youtube_play_pause()
		Return
	}
	
Numpad6:: 
	IfWinExist, ahk_exe mpc-hc64.exe
	{
		Send {Media_Next}
		Return
	} Else {
		youtube_next()
		Return
	}


NumpadAdd:: Send {Volume_Up}

Numpad1:: Send {F22}

Numpad2:: Send {F23}

	;UnmuteMic()
	;KeyboardLED(2, "off", 4)
	;Return

Numpad3:: Send {F24}
	;MuteMic()
	;KeyboardLED(2, "on", 4)
	;Return

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


