#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#Persistent


#if (getKeyState("F23", "P"))
F23::return

;;;;;first row;;;;;

ESC::
F1::
F2::
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
F12::SoundBeep(100, 100, 20)

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
4::
5::
6::
7::
8::
9::
0::
*::
-::
backspace::SoundBeep(100, 100, 20)

;;;;;next row;;;;;

tab::
q::
w::
e::
r::
t::
y::
u::
ı::
o::
p::
ğ::
ü::
\::SoundBeep(100, 100, 20)

;;;;;next row;;;;;

capslock::
a::
s::
d::
f::
g::
h::
j::
k::
l::
sc027::
sc028::
enter::SoundBeep(100, 100, 20)

;;;;;next row;;;;;

LShift::
z::
x::
c::
v::
b::
n::
SoundBeep(100, 100, 20)
return

m:: ;mute mic
SoundSet, 1, MASTER, mute, 2

ToolTip, Muted
SetTimer, RemoveToolTip, 1000
return

ö:: ;unmute mic
SoundSet, 0, MASTER, mute, 2

ToolTip, Unmuted
SetTimer, RemoveToolTip, 1000
return

ç::
sc035::
SC061::SoundBeep(100, 100, 20)

;;;;;next row;;;;;

LCtrl::
sc063::
Lalt::
space::
sc05A::
sc062::
Rctrl::

up::
down::
left::
right::SoundBeep(100, 100, 20)

return
#if
;END of F23 based keyboard
;-------------------------


;And then you can have a 4th keyboard and so on and so FOURTH!
;If you use all the function keys from F24 to F13, you can start using weird unassigned scancodes, or virtual keys!
;if you run out of those, you can maybe start doubling up keys! Wrap each on in TWO layers of other keys!
;If you run out of THAT, then you're absolutely crazy and your whole room would be filled with keyboards.

;-------------------------------------------------------------------------------
RemoveToolTip:
;-------------------------------------------------------------------------------
	SetTimer, RemoveToolTip, Off
	ToolTip
	return


;-------------------------------------------------------------------------------
SoundBeep(Frequency, Duration, Volume) { ; custom wrapper
;-------------------------------------------------------------------------------
    SoundGet, MasterVolume
    SoundSet, Volume
    SoundBeep, Frequency, Duration
    SoundSet, MasterVolume
	return
}
