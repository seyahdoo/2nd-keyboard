#NoTrayIcon
#Persistent
#SingleInstance force

;;Credit -> https://superuser.com/questions/1106317/how-can-i-make-a-bat-file-run-only-in-system-tray

global hBatFile

Menu Tray, Icon
Menu, Tray, Icon, C:\AHK\Functions\TinderBOT\tinder.ico
Menu, Tray, NoStandard 
Menu Tray, Add, Close TinderBOT, CloseItem
Menu Tray, Default, Close TinderBOT

DetectHiddenWindows On
Run C:\AHK\Functions\TinderBOT\tinderbot.py ,, Hide, PID
WinWait ahk_pid %PID%
hBatFile := WinExist()
DetectHiddenWindows Off

CloseItem() {
       DetectHiddenWindows On
       Process, Close, python.exe
       DetectHiddenWindows Off
       ExitApp
}


#if (getKeyState("F23", "P"))
F23::return

t::CloseItem()

#if