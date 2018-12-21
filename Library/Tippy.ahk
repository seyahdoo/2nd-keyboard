#NoEnv

Tippy(tipText, wait:=333)
{
	ToolTip, %tipText%,,,8
	SetTimer, notip, %wait%
	Return
}
notip:
	ToolTip,,,,8
	return
