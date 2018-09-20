#NoTrayIcon
#Persistent
#SingleInstance force


;;SILENTLY OPEN INTERCEPT
;;Credit -> https://superuser.com/questions/1106317/how-can-i-make-a-bat-file-run-only-in-system-tray

global hBatFile

/* Setup Tray icon and add item that will handle
* double click events
*/
Menu Tray, Icon
Menu Tray, Icon, C:\windows\system32\cmd.exe
Menu, Tray, NoStandard 
Menu Tray, Add, Close Intercept, CloseItem
Menu Tray, Default, Close Intercept

;// Run program or batch file hidden
DetectHiddenWindows On
Run .\intercept.exe /apply,, Hide, PID
WinWait ahk_pid %PID%
hBatFile := WinExist()
DetectHiddenWindows Off
return

TrayClick:
OnTrayClick()
return

;// Show / hide program or batch file on double click
OnTrayClick() {
    if DllCall("IsWindowVisible", "Ptr", hBatFile) {
        WinHide ahk_id %hBatFile%

    } else {
        WinShow ahk_id %hBatFile%
        WinActivate ahk_id %hBatFile%
    }
}

CloseItem() {

       DetectHiddenWindows On
       WinWait ahk_class ConsoleWindowClass
       Process, Close, cmd.exe
       DetectHiddenWindows Off
       ExitApp

}
;;OPEN INTERCEPT END


