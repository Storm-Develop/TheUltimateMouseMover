Gui, Add, Tab2,, Endless|Timer|Autoclicker (Bonus)
Gui, Add, Button, vStartEndlessMouse , Start endless mouse movement
Gui, Font, cWhite
Gui, Color, Black, Green

Gui, Add, Button, vButtonStartEndlessSpace, Start endless press of a SPACE key
Gui, Add, Text,, Note: Stop by pressing X.
MouseMovement:="off"
SpacePressing:="off"

Gui, Add, Button, default xm, Hide
Gui, Tab, 2
Gui, Add, Text,, Please select a time for mouse to move in minutes:
Gui, Add, Edit
Gui, Add, UpDown, vNumberEnter Range1-10000000, 1

Gui, Add, Button, vButtonStartRegMouse , Start
Gui, Add, Text,, Note: Stop by pressing X. Or wait for Timer to finish.
Gui, Add, Button, default xm, Hide
Gui, Submit , NoHide

Gui, Tab, 3
Gui, Add, Button, default xm, Hide
Gui, Add, StatusBar,Color,Red Bar's starting text.
SB_SetText("Mouse movement " . MouseMovement . " Space pressing " SpacePressing)
Menu, Tray,  Icon, cursor.ico

Gui, Show
return



ButtonStartEndlessMouseMovement:
{
	MouseMovement:="on"
	SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )

	while(!GetKeyState("X", "P"))
		{
			Random, randX, 0, 1000
			Random, randY, 0, 1000
			MouseMove, randX, randY
				Sleep, 10
		}
	MouseMovement:="off"
	SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )
	return
}

ButtonStart:
{
	Gui, Submit , NoHide
	MouseMovement:="on"
	SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )
	timeElapse:=NumberEnter*60
	CallTimer()
	return
}

CallTimer()
{
	Progress, m1 b fs70 fm12 zh10 CTgreen w250, % "00:00", Press (P) to pause/resume (X to exit)
	settimer,startTimer,1000
}

startTimer:
{
++time
	if (GetKeyState("X", "P"))
	{
		return
	}
if (time < timeElapse)
{
    Progress, % 100*(timeElapse-time)/timeElapse, % SubStr("00" floor((timeElapse-time)/60),-1) ":" SubStr("00" mod(timeElapse-time,60),-1), Press (P) to pause/resume (X to exit)
	Random, randX, 0, 1000
	Random, randY, 0, 1000
	MouseMove, randX, randY
}
else if (time = timeElapse)
    {
    Progress, Off
	settimer,startTimer,off
	time := 0
	MouseMovement:="off"	
	SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )
	return
    }
}

~p:: settimer,startTimer,% (a:=!a) ? "off" : "on"

~x::
{
	if(MouseMovement=="on")
	{
		Progress, Off
		settimer,startTimer,off
		MouseMovement:="off"
		time := 0
		SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )
	}
}

ButtonStartEndlessPressOfaSpaceKey:
{
	SpacePressing:="on"
	SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )
	while(!GetKeyState("X", "P"))
		{
			Send {Space}
		}
	SpacePressing:="off"
		SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )
		return
}

ButtonStopEndlessSpace:
{
	EndlessSpace:=true
	return
}


ButtonHide:
{
	Gui, Hide
	return
}

return
