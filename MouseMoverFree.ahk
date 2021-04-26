Gui, Add, Tab2,, Endless|Buy PRO
Gui, Add, Button, vStartEndlessMouse , Start endless mouse movement
Gui, Font, cWhite
Gui, Color, White, Green

Gui, Add, Text,cBlack, Note: Stop by pressing X.
MouseMovement:="off"

Gui, Font, underline
Gui, Add, Text, cBlue gLaunchHackMaster, Developed by HackMaster.shop
Gui, Font, norm

Gui, Add, Button, default xm, Hide
Gui, Add, StatusBar,Color,Red Bar's starting text.
SB_SetText("Mouse movement " . MouseMovement " © HackMaster.shop")
Menu, Tray,  Icon, cursor.ico , 1 ,1 
Gui, Tab, 2
Gui, Add, Picture, w230 h100, C:\GitHub\BreakTime\MouseMoverPRO.png

Gui, Add, Text, cBlue gProMouseMover, Get Mouse Mover PRO

Gui, Show
return


ButtonStartEndlessMouseMovement:
{
	MouseMovement:="on"
	SB_SetText("Mouse movement " . MouseMovement)

	while(!GetKeyState("X", "P"))
		{
			Random, randX, 0, 1000
			Random, randY, 0, 1000
			MouseMove, randX, randY
				Sleep, 10
		}
	MouseMovement:="off"
	SB_SetText("Mouse movement " . MouseMovement)
	return
}

LaunchHackMaster:
{
	Run http://hackmaster.shop/
	return
}

ProMouseMover:
{
	Run https://www.buymeacoffee.com/hackmaster/e/29669
	return
}

ButtonHide:
{
	Gui, Hide
	return
}

GuiClose:
GuiEscape:
ExitApp