
;;SILENTLY OPEN INTERCEPT
;;Credit -> https://superuser.com/questions/1106317/how-can-i-make-a-bat-file-run-only-in-system-tray

#NoTrayIcon
#Persistent
#SingleInstance force

;// Setup Tray icon and add item that will handle
;// double click events
Menu Tray, Icon
Menu Tray, Icon, C:\windows\system32\cmd.exe
Menu, Tray, NoStandard 
Menu Tray, Add, Show & Hide Intercept, ShowHideItem
Menu Tray, Add, Close Intercept, CloseItem
Menu Tray, Default, Close Intercept

global WindowID
global ProcessID

;// Run program or batch file hidden
DetectHiddenWindows On
Run .\intercept.exe /apply,, Hide, ProcessID
WinWait ahk_pid %ProcessID%
WindowID := WinExist()
DetectHiddenWindows Off
return

ShowHideItem() {
	if DllCall("IsWindowVisible", "Ptr", WindowID) {
        WinHide ahk_id %WindowID%
    } else {
        WinShow ahk_id %WindowID%
        WinActivate ahk_id %WindowID%
    }	
}

CloseItem() {
    Process, Close, %ProcessID%
    ExitApp
}

;;OPEN INTERCEPT END

