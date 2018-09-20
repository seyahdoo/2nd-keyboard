#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.




; Script to activate any given firefox tab...
;This requires the ACC library, which you have to install into AutoHotKey (it's pretty easy, just scroll to the top of this page and follow the instructions.)
;https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114
; calling the funciton looks like this: 
;^!+numpad2::JEE_FirefoxFocusTabByName(hWnd, "Linus Media Group Inc. Mail")
;==================================================

JEE_FirefoxGetTabCount(hWnd)
{
oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
vRet := 0
for each, oChild in Acc_Children(oAcc)
	if (oChild.accName(0) == "Browser tabs")
	{
		oAcc := Acc_Children(oChild)[1], vRet := 1
		break
	}
if !vRet
{
	oAcc := oChild := ""
	return
}

vCount := 0
for each, oChild in Acc_Children(oAcc)
	if !(oChild.accName(0) == "")
		vCount++
oAcc := oChild := ""
return vCount
}

;==================================================

JEE_FirefoxGetTabNames(hWnd, vSep="`n")
{
oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
vRet := 0
for each, oChild in Acc_Children(oAcc)
	if (oChild.accName(0) == "Browser tabs")
	{
		oAcc := Acc_Children(oChild)[1], vRet := 1
		break
	}
if !vRet
{
	oAcc := oChild := ""
	return
}

vOutput := ""
for each, oChild in Acc_Children(oAcc)
{
	vTabText := oChild.accName(0)
	if !(vTabText == "")
	;&& !(vTabText == "New Tab")
	;&& !(vTabText == "Open a new tab")
		vOutput .= vTabText vSep
}
vOutput := SubStr(vOutput, 1, -StrLen(vSep)) ;trim right
oAcc := oChild := ""
return vOutput
}

;==================================================

gotofiretab(name,URL)
{
;WinActivate ahk_exe firefox.exe ;I think this is unreilable because it only makes sure the applicaiton is RUNNING, not necessarily that it's ACTIVE.
WinActivate ahk_class MozillaWindowClass ;so i use the CLASS instead.
;tooltip, FIRETAB
sleep 15
WinGet, the_current_id, ID, A
vRet := JEE_FirefoxFocusTabByName(the_current_id, name)
;tooltip, vret is %vRet%
if (vRet = 0)
	run, firefox.exe %URL%
sleep 100
tooltip,
}



JEE_FirefoxFocusTabByNum(hWnd, vNum)
{
;TARAN NOTE: Using a tab NAME is somewhat unstable. Gmail for example will dynamically change the name to "Message from Nick Light" or whatever else. So really, I need to get the tab URL. will have to poke around ACC viewer to see where that information is...
; for future URL getting: https://autohotkey.com/boards/viewtopic.php?t=3702
; better: https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114



oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
vRet := 0
for each, oChild in Acc_Children(oAcc)
	if (oChild.accName(0) == "Browser tabs")
	{
		oAcc := Acc_Children(oChild)[1], vRet := 1
		break
	}
if !vRet || !Acc_Children(oAcc)[vNum]
	vNum := ""
else
	Acc_Children(oAcc)[vNum].accDoDefaultAction(0)
oAcc := oChild := ""
return vNum
}

;==================================================



 
JEE_FirefoxFocusTabByName(hWnd, vTitle, vNum=1)
{
oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
vRet := 0
for each, oChild in Acc_Children(oAcc)
	if (oChild.accName(0) == "Browser tabs")
	{
		oAcc := Acc_Children(oChild)[1], vRet := 1
		break
	}
if !vRet
{
	oAcc := oChild := ""
	return
}

vCount := 0, vRet := 0
for each, oChild in Acc_Children(oAcc)
{
	vTabText := oChild.accName(0)
	; if (vTabText = vTitle)
		; vCount++
	If InStr(vTabText, vTitle) ;TARAN NOTE: I changed this line so that only a PARTIAL tab title match is required.
		vCount++
	if (vCount = vNum)
	{
		oChild.accDoDefaultAction(0), vRet := A_Index
		break
	}
}
oAcc := oChild := ""
return vRet
}
 
;==================================================




;;;;;;;scripts from this guy;;;;;;;;;;;;;;;;
;https://github.com/asvas/AsVas_AutoHotkey_Scripts/blob/master/ahk_Scripts.ahk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;not CURRENTLY used anywhere...;;;;


; x::F_Switch("firefox.exe","ahk_class MozillaWindowClass","firefoxgroup","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
; +x::F_Run("firefox.exe","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
; c::F_Switch("chrome.exe","ahk_class Chrome_WidgetWin_1","chromegroup")
; +c::F_Run("chrome.exe")
;
; w::F_Switch("WINWORD.EXE","ahk_class OpusApp","wordgroup") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
; +w::F_Run("WINWORD.EXE") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")


;---------------------------------------------------------------------------------
;Run Function - Running specific executable
F_Run(Target,TPath = 0)
{
if TPath = 0 
	Run, %Target%
else
	Run, %TPath% ;Command for running target if conditions are satisfied
}

;---------------------------------------------------------------------------------
;Switch Function - Switching between different instances of the same executable or running it if missing
F_Switch(Target,TClass,TGroup,TPath = 0)
{
IfWinExist, ahk_exe %Target% ;Checking state of existence
	{
	GroupAdd, %TGroup%, %TClass% ;Definition of the group (grouping all instance of this class) (Not the perfect spot as make fo unnecessary reapeats of the command with every cycle, however the only easy option to keep the group up to date with the introduction of new instances)
	ifWinActive %TClass% ;Status check for active window if belong to the same instance of the "Target"
		{
		GroupActivate, %TGroup%, r ;If the condition is met cycle between targets belonging to the group
		}
	else
		WinActivate %TClass% ;you have to use WinActivatebottom if you didn't create a window group.
	}
else
	{
	if TPath = 0 
		Run, %Target%
	else
		Run, %TPath% ;Command for running target if conditions are satisfied
	}
Return
}
;;;;;;scripts from another guy END;;;;;;;;;