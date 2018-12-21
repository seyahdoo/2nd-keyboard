#NoTrayIcon
#Persistent
#SingleInstance force

;;Credit -> https://superuser.com/questions/1106317/how-can-i-make-a-bat-file-run-only-in-system-tray

global hBatFile

Menu Tray, Icon
Menu, Tray, Icon, C:\Program Files\MongoDB\Server\3.6\bin\mongod.exe
Menu, Tray, NoStandard 
Menu Tray, Add, Close MongoDB, CloseItem
Menu Tray, Default, Close MongoDB

DetectHiddenWindows On
Run C:\Program Files\MongoDB\Server\3.6\bin\mongod.exe ,, Hide, PID
WinWait ahk_pid %PID%
hBatFile := WinExist()
DetectHiddenWindows Off

CloseItem() {
       DetectHiddenWindows On
       Process, Close, mongod.exe
       DetectHiddenWindows Off
       ExitApp
}
