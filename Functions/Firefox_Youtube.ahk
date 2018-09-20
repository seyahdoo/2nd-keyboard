#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


youtube_play_pause(){
	ControlSend,,{Space},ahk_class MozillaWindowClass
	Return
}

youtube_fullscreen(){
	ControlSend,,{f down}{f up},ahk_class MozillaWindowClass
	Return
}

youtube_next(){
	ControlSend,,{Shift Down}{n Down}{n Up}{Shift Up},ahk_class MozillaWindowClass
	Return
}

youtube_prev(){
	ControlSend,,{Backspace Down}{Backspace Up},ahk_class MozillaWindowClass
	Return
}

youtube_volume_up(){
	ControlSend,,{Up Down}{Up Up},ahk_class MozillaWindowClass
	Return
}

youtube_volume_down(){
	ControlSend,,{Down Down}{Down Up},ahk_class MozillaWindowClass
	Return
}
