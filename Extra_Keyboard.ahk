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

global savedCLASS = "ahk_class Notepad++"
global savedEXE = "notepad++.exe" ;BEFORE the #include is apparently the only place these can go.

#include C:\AHK\Library\Almost_All_Windows_Functions.ahk
#include C:\AHK\Library\Firefox_Functions.ahk
#include C:\AHK\Library\NoFunction.ahk
#include C:\AHK\Library\Firefox_Youtube.ahk

;____________________________________________________________________________
;                                                                                                                       
; NOTE: In autohotkey, the following special characters (usually) represent modifier keys:
; # is the WIN key. (it can mean other things though, as you can see above.)
; ^ is CTRL
; ! is ALT
; + is SHIFT
; list of other keys: http://www.autohotkey.com/docs/Hotkeys.htm
; 
; 

;Open Launchy with Win button
LWin::
Send {LWin Down}

;to be able to use Win+Tab, Win+V
anyKeyPressed := false
Input, SingleKey, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}
Send %SingleKey%
anyKeyPressed := true

Return


LWin Up::
Send {F13 Down}{LWin Up}{F13 Up}
;if Win+Tab or sth used, dont open launchy
if(anyKeyPressed){
	Return
}

IfWinActive, ahk_class QTool
{
	Send ^a
	Send {Delete}
}
Else
{
	Send ^#{F13}
	WinWaitActive, ahk_class QTool, , 1
	if ErrorLevel
	{
		SoundBeep
		Return
	}
	Else
	{
		Send ^a
		Send {Delete}
	}
}
Return

F12::Send #{PrintScreen}
F11::Volume_Up
F10::Volume_Down
F9::Volume_Mute
F8::youtube_next()
F7::youtube_play_pause()
F6::youtube_prev()
;F5::NoFunction()
;F4::NoFunction()
F3::send ^{F13}
;F2 - rename
;F1::Send #d


;-------------------------
;;SECOND KEYBOARD MACROS;;
#if (getKeyState("F23", "P"))
F23::return

;;;;;first row;;;;;

ESC::
F1::Return
F2::Send {Volume_Down}
F3::Send {Volume_Up}
F4::Send {Volume_Mute}
F5::youtube_prev()
F6::youtube_next()
F7::youtube_play_pause()
F9::
F8::
F10::
F11::
F12::NoFunction()

PrintScreen::
NumLock::
return
insert::
delete::

;;;;;next row;;;;;

sc029::
1::
2::
3::
4::return
5::youtube_volume_down()
6::youtube_volume_up()
7::return
8::
9::
0::
*::
-::
backspace::NoFunction()

;;;;;next row;;;;;

tab::NoFunction()
q::switchToFirefox()
w::switchToExplorer()
e::
r::
t::Run "C:\AHK\Functions\TinderBOT\tinderbot_tray.ahk"
y::
u::
ı::
o::
p::
ğ::
ü::
\::NoFunction()

;;;;;next row;;;;;

capslock::
a::
s::
d::return
f::youtube_fullscreen()
g::return
h::
j::
k::
l::
sc027::
sc028::
enter::NoFunction()

;;;;;next row;;;;;

LShift::
return
z:: Run C:\Users\seyahdoo\Documents\CODE-SEGMANT\Github\MiniRoyale\MiniRoyaleServer\start-master.bat
x:: Run C:\Users\seyahdoo\Documents\CODE-SEGMANT\Github\MiniRoyale\MiniRoyaleServer\start-slave.bat
c:: 
v::
b::
n::
NoFunction()
return

m::MuteMic()
ö::UnmuteMic()
ç::Tippy("Hello")
sc035::
SC061::NoFunction()

;;;;;next row;;;;;

LCtrl::
sc063::
Lalt::ReloadScript()
space::youtube_play_pause()
sc05A::
sc062::
Rctrl::

up::
down::
left::
right::NoFunction()

return
#if
;END of SECOND KEYBOARD MACROS
;-----------------------------


