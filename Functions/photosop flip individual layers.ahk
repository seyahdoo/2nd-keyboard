#SingleInstance Force

; Allow multiple threads so that this hotkey can "turn itself off":
#MaxThreadsPerHotkey 2


x:: 
#MaxThreadsPerHotkey 1
if keep_x_running = y
{
     keep_x_running = n  ; Signal the other thread to stop.
     return
}
keep_x_running = y
Loop 100, 
{
    if keep_x_running = n  ; Another thread signaled us to stop
        return
    
	
	Send {f2}
	Sleep 300
	Send {f3}
	Sleep 300
	
	
}


