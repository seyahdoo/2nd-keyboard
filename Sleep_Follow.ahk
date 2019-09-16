/*
	Mute on hibernation
	
	Purpose:
		Mute the internal speakers if the computer is sent into hibernation or standby mode.
		
		Some laptop models of Fujitsu-Siemens are making short beep sounds everytime
		they are sent into sleep mode. This annoying behavior cannot be switched off,
		so this program circumvents it by disabling the speakers before sleep mode and
		reactivating them when resuming from hibernation.
	
	Functioning:
		The program runs in background, listening for the system´s message to hibernate
		the computer. It then mutes the speakers and turns them on again after the
		computer woke up.
		The mute state is left untouched in case the speakers were not muted by this
		program.
		The program will create one registry entry to save the mute state.
	
	Requirements:
		- Windows 2000 and newer
		- Read and write permission to HKEY_CURRENT_USER registry stem.
		
	
	Author:  Dirk Schwarzmann
	Version: 0.2
	Date:    2007-08-02
	
	Contact:
		Dirk 'Rob' Schwarzmann
		http://www.dirk-schwarzmann.de
		mailto://dirk@dirk-schwarzmann.de
	
	Version history:
		0.1, 2007-08-01: Initial version
		0.2, 2007-08-02: Replace unreliable timer function by real power event parameters
*/

#SingleInstance force

; Tray icon and menu definition
Menu, TRAY, Tip, Mute speakers on hibernation

#include C:\AHK\Library\Keyboard_Led_Controll.ahk

; Listen to the Windows power event "WM_POWERBROADCAST" (ID: 0x218):
OnMessage(0x218, "func_WM_POWERBROADCAST")


/*
	This function is executed if the system sends a power event.
	Parameters wParam and lParam define the type of event:
	
	lParam: always 0
	wParam:
		PBT_APMQUERYSUSPEND             0x0000
		PBT_APMQUERYSTANDBY             0x0001
		
		PBT_APMQUERYSUSPENDFAILED       0x0002
		PBT_APMQUERYSTANDBYFAILED       0x0003
		
		PBT_APMSUSPEND                  0x0004
		PBT_APMSTANDBY                  0x0005
		
		PBT_APMRESUMECRITICAL           0x0006
		PBT_APMRESUMESUSPEND            0x0007
		PBT_APMRESUMESTANDBY            0x0008
		
		PBTF_APMRESUMEFROMFAILURE       0x00000001
		
		PBT_APMBATTERYLOW               0x0009
		PBT_APMPOWERSTATUSCHANGE        0x000A
		
		PBT_APMOEMEVENT                 0x000B
		PBT_APMRESUMEAUTOMATIC          0x0012
		
		Source: http://weblogs.asp.net/ralfw/archive/2003/09/09/26908.aspx
*/
func_WM_POWERBROADCAST(wParam, lParam)
{
	If (lParam = 0) {
		; PBT_APMSUSPEND or PBT_APMSTANDBY? -> System will sleep
		If (wParam = 4 OR wParam = 5) {
			KeyboardLED(2, "off", 4)
		}
		
		; PBT_APMRESUMESUSPEND oder PBT_APMRESUMESTANDBY? -> System wakes up
		If (wParam = 7 OR wParam = 8 OR wParam = 18) {
			KeyboardLED(2, "off", 4)
			MsgBox "Woke Up" 
		}
		
		
		
	}
	Return
}


