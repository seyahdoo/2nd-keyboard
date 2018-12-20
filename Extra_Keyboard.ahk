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
Menu, Tray, NoStandard 
Menu Tray, Add, Edit, EditScript
Menu Tray, Add, Reload, ReloadScript
Menu Tray, Add, Close Extra Keyboard, CloseItem
Menu Tray, Default, Reload

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

#include C:\AHK\Lib\Almost_All_Windows_Functions.ahk
#include C:\AHK\Lib\Firefox_Functions.ahk
#include C:\AHK\Lib\NoFunction.ahk
#include C:\AHK\Lib\Firefox_Youtube.ahk

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
;END of F23 based keyboard
;-------------------------


