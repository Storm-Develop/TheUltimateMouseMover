Gui, Add, Tab2,, Endless|Timer|Autoclicker (Bonus)
Gui, Add, Button, vStartEndlessMouse , Start endless mouse movement
Gui, Font, cWhite
Gui, Color, Black, Green

Gui, Add, Button, vButtonStartEndlessSpace, Start endless press of a SPACE key
Gui, Add, Text,, Note: Stop by pressing X.

Gui, Font, underline
Gui, Add, Text, cGreen gLaunchHackMaster, Developed by HackMaster.shop
Gui, Font, norm

MouseMovement:="off"
SpacePressing:="off"

Gui, Add, Button, default xm, Hide
Gui, Tab, 2
Gui, Add, Text,, Please select a time for mouse to move in minutes:
Gui, Add, Edit
Gui, Add, UpDown, vNumberEnter Range1-10000000, 1

Gui, Add, Button, vButtonStartRegMouse , Start
Gui, Add, Text,, Note: Stop by pressing X. Or wait for timer to finish.
Gui, Add, Button, default xm, Hide
Gui, Submit , NoHide

Gui, Tab, 3
Gui, Add, CheckBox, vAutoClickerVal, Enable AutoClicker?

Gui, Add, Text,, To start press S and X to stop.

Gui, Add, Button, default xm, Hide
Gui, Add, StatusBar,Color,Red Bar's starting text.
SB_SetText("Mouse movement " . MouseMovement . " Space pressing " SpacePressing)

AutoClickerMessage:="off"
Menu, Tray,  Icon, Cursor_PRO.ico
Gui, Submit , NoHide

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
	Progress, m1 b fs70 fm12 zh10 CTgreen w250, % "00:00", Press (X) to exit
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
    Progress, % 100*(timeElapse-time)/timeElapse, % SubStr("00" floor((timeElapse-time)/60),-1) ":" SubStr("00" mod(timeElapse-time,60),-1), Press (X) to exit.
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

~x::
{
	Gui, Submit , NoHide
	if(MouseMovement=="on")
	{
		Progress, Off
		settimer,startTimer,off
		MouseMovement:="off"
		time := 0
		SB_SetText("Mouse movement " . MouseMovement . " Space pressing "  SpacePressing )
	}
	else if (AutoClickerVal && AutoClickerMessage=="on")
	{
		AutoClickerMessage:="off"
		SB_SetText("Autoclicker " . AutoClickerMessage)
		Toggle := false
	}
	return
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

LaunchHackMaster:
{
	Run http://hackmaster.shop/
	return
}

~s::
{
	Gui, Submit , NoHide
	if(AutoClickerVal)
	{
		Toggle := true
		AutoClickerMessage:="on"
		SB_SetText("Autoclicker " . AutoClickerMessage)
			Loop
			{
				If (!Toggle && AutoClickerVal)
					Break
				Click
				Sleep 1 ; Make this number higher for slower clicks, lower for faster.
			}

		return
	}
	else
	{
		AutoClickerMessage:="is disabled."
		SB_SetText("Autoclicker " . AutoClickerMessage)
	}
}

GuiClose:
GuiEscape:
ExitApp
