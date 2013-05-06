package
{
	import flash.display.MovieClip
	
	public class GUIButton extends MovieClip
	{
		private var func:String;
		private var refToDocClass;
		private var clip;
		private var mouseHover:Boolean = false;
		private var pressed:Boolean = false;
		private var startX;
		private var startY;
		
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
			
			x = startX + -refToDocClass.currentState.x;

			//if (((mouseX + (-refToDocClass.currentState.x)) > x) && ((mouseX + (-refToDocClass.currentState.x)) < (x + width)))

			if ((mouseX + -refToDocClass.currentState.x) > x && ((mouseX + -refToDocClass.currentState.x) < (x + width)) && mouseY > y && mouseY < y + height)
			{
				mouseHover = true;
			}
			else
			{
				mouseHover = false;
			}
		}
		
		public function mousePressed()
		{
			if (((mouseX + (-refToDocClass.currentState.x)) > x) && ((mouseX + (-refToDocClass.currentState.x)) < (x + width)) && mouseY > y && mouseY < y + height)
			{
				doFunction();
			}
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
				default:
					trace("Button Error in doFunction()");
				break;
			}
			
		}
		
	}
}