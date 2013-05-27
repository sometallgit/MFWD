package
{
	import flash.display.MovieClip;
	
	public class S_CreditsState extends StateMachine
	{
		private var refToDocClass;
		private var backButton;
		private var creditsBackground;

		public function S_CreditsState(documentClass)
		{
			refToDocClass = documentClass;
			//Create GUI
			backButton = new GUIButton(refToDocClass, "ENTER_MENU", new ButtonBack());
			backButton.x = 20;
			backButton.startX = 20;
			backButton.y = 20;
			//Create the background image for the menu state
			creditsBackground = new CreditsBackground();
			addChild(creditsBackground);
			addChild(backButton);			
		}
		
		//Update the buttons
		override public function update()
		{
			backButton.update(mouseIsPressed);
		}
		
		//Tell the buttons when the gui registered a mouse down event
		override public function mousePressed()
		{
			backButton.mousePressed();
		}
	}
}