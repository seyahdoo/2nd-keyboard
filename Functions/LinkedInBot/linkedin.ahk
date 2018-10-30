#NoTrayIcon
#Persistent
#SingleInstance force


Menu Tray, Icon
Menu, Tray, Icon, C:\AHK\Functions\LinkedInBot\linkedin.ico
Menu, Tray, NoStandard 
Menu Tray, Add, Close LinkedinBOT, CloseItem
Menu Tray, Default, Close LinkedinBOT

CloseItem() {
       DetectHiddenWindows On
       Process, Close, python.exe
       DetectHiddenWindows Off
       ExitApp
}

F9::

    Loop
    {
		
		Loop 14
		{
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, C:\AHK\Functions\LinkedInBot\connect_btn.bmp
			MouseMove, FoundX, FoundY
			Click, FoundX, FoundY
			Sleep, 500
		}
		
		Send {f5}
		Sleep, 2000
    }

Return

F10::
Reload
Return