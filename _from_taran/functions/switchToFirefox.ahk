#NoEnv
SendMode Input
#SingleInstance force


IfWinNotExist, ahk_class MozillaWindowClass
{
	Run, firefox.exe
}
if WinActive("ahk_exe firefox.exe")
{
	Send ^{tab}
}
else
{
	WinActivatebottom ahk_exe firefox.exe
	WinGet, hWnd, ID, ahk_class MozillaWindowClass
	DllCall("SetForegroundWindow", UInt, hWnd) 
}
Exitapp

