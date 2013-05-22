package
{
	import flash.display.MovieClip
	
	//I know flash has its own built in button type 
	
	public class GUIButton extends MovieClip
	{
		private var func:String; //What function does the button have when pressed
		private var refToDocClass;
		private var clip; //What does the button look like
		private var mouseHover:Boolean = false;
		private var pressed:Boolean = false;
		public var startX;
		public var startY;
		
		public var soundPlayed:Boolean = false;
		
		public function GUIButton(documentClass, f, c)
		{
			refToDocClass = documentClass
			func = f;
			clip = c;
			
			addChild(clip);
			
			startX = x;
			startY = y;
		}
		
		public function update(mouseIsPressed)
		{
			//Update buttons to stay on their relative coordinates
			x = startX + -refToDocClass.currentState.x;

			
			//if ((mouseX + -refToDocClass.currentState.x) > x && ((mouseX + -refToDocClass.currentState.x) < (x + width)) && mouseY > y && mouseY < y + height) - //Old method of testing for the mouse only worked if the x and y of the button wasn't changed
			if (this.hitTestPoint((mouseX + x - (-refToDocClass.currentState.x)), (mouseY + y)))
			{
				mouseHover = true;
				if (!soundPlayed)
				{
					Audio.play("button");
					soundPlayed = true;
				}
			}
			else
			{
				mouseHover = false;
				soundPlayed = false;
			}
			
			//Testing
			//if (func == "MUTE_SOUNDS")
			//{
				//trace("x1: " + startX + ", x2: " + (startX + width));
				//trace(mouseX + x - (-refToDocClass.currentState.x));
			//}
		}
		
		public function mousePressed()
		{
			if (this.hitTestPoint((mouseX + x - (-refToDocClass.currentState.x)), (mouseY + y)))
			{
				doFunction();
			}
			
			//if ((((mouseX + x) + (startX - x) + (-refToDocClass.currentState.x)) > x) && (((mouseX + x) + (-refToDocClass.currentState.x)) < (x + width)) && mouseY > y && mouseY < y + height)
			//{
				//doFunction();
			//}
			//if (this.hitTestPoint((mouseX + x), (mouseY + y)))
			//{
				//doFunction();
			//}
			
		}
		
		private function doFunction()
		{
			//Reset the button state before leaving
			pressed = false;
			
			switch (func)
			{
				case "ENTER_MENU":
					refToDocClass.changeStateTo(refToDocClass.s_Menu);
				break;
				case "ENTER_INSTRUCTIONS":
					//do this
				break;
				case "ENTER_GAME":
					refToDocClass.changeStateTo(refToDocClass.s_LevelOne);
				break;
				case "MUTE_SOUNDS":
					//invert mute setting
					Config.muteSounds = !Config.muteSounds;
				break;
				case "MUTE_MUSIC":
					//invert mute setting
					Config.muteMusic = !Config.muteMusic;
					if (Config.muteMusic) Config.musicTracker = Audio.play("music");
					else Audio.stop(Config.musicTracker);
				break;
				default:
					trace("Button Error in doFunction()");
				break;
			}
			
		}
		
	}
}