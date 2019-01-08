#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#NoTrayIcon

;constants
MONITOR_ON = -1
MONITOR_OFF = 2
MONITOR_STANBY = 1

;turn monitors off
SendMessage 0x112, 0xF170, %MONITOR_OFF%,,Program Manager

;wait for a key to be pressed
Input, SingleKey, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause} ;wait for a key to be pressed
;turn monitors on
SendMessage 0x112, 0xF170, %MONITOR_ON%,,Program Manager

ExitApp