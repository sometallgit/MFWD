package
{
	import flash.display.MovieClip;
	
	public class S_MenuState extends StateMachine
	{
		private var refToDocClass;
		private var startButton;
		private var helpButton;
		private var creditsButton;
		private var muteSoundButton;
		private var menuBackground;
		
		public function S_MenuState(documentClass)
		{
			refToDocClass = documentClass;
			
			//Create GUI
			startButton = new GUIButton(refToDocClass, "ENTER_GAME", new ButtonStart());
			startButton.x = 562.65;
			startButton.startX = 562.65;
			startButton.y = 283.15;
			
			muteSoundButton = new GUIButton(refToDocClass, "MUTE_SOUNDS", new ButtonSound());
			muteSoundButton.x = 727.8;
			muteSoundButton.startX = 727.8;
			muteSoundButton.y = 14.6;
			
			helpButton = new GUIButton(refToDocClass, "ENTER_HELP", new ButtonHelp());
			helpButton.x = 561.65;
			helpButton.startX = 561.65;
			helpButton.y = 368.15;
			
			creditsButton = new GUIButton(refToDocClass, "ENTER_CREDITS", new ButtonCredits());
			creditsButton.x = 561.65;
			creditsButton.startX = 561.65;
			creditsButton.y = 447.65;
			
			//Create the background image for the menu state
			menuBackground = new TitleBackground();
			
			addChild(menuBackground);
			addChild(startButton);			
			addChild(muteSoundButton);
			addChild(helpButton);	
			addChild(creditsButton);	
		}
		
		//Update the buttons
		override public function update()
		{
			startButton.update(mouseIsPressed);
			muteSoundButton.update(mouseIsPressed);
			creditsButton.update(mouseIsPressed);
			helpButton.update(mouseIsPressed);
		}
		
		override public function keyPressed(key)
		{	
		}
		
		override public function keyReleased(key)
		{
		}
		
		//Tell the buttons when the gui registered a mouse down event
		override public function mousePressed()
		{
			startButton.mousePressed();
			muteSoundButton.mousePressed();
			creditsButton.mousePressed();
			helpButton.mousePressed();
		}
	}
}