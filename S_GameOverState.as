package
{
	import flash.display.MovieClip;
	import flash.text.*;
	
	//The Newgrounds API
	import com.newgrounds.*;
	import com.newgrounds.components.*;
	
	//This state is changed to at the very end of the game
	public class S_GameOverState extends StateMachine
	{
		private var refToDocClass;
		private var button;
		
		private var scoreBoardDisplayed:Boolean = false;
		
		public var scoreFormat:TextFormat = new TextFormat();
		public var totalText:TextField = new TextField();
		
		public var highscoreBackground;
		
		public function S_GameOverState(documentClass)
		{
			refToDocClass = documentClass;
			
			//Create GUI
			button = new GUIButton(refToDocClass, "ENTER_MENU", new ButtonBack());
			addChild(button);	
			
			scoreFormat.align = TextFormatAlign.CENTER;
			scoreFormat.size = 20;
			scoreFormat.color = 0xFFFFFF;
			
			totalText.text = "Total Score: 0";			
			totalText.width = 800;
			totalText.y = 20;

			highscoreBackground = new HighscoresBackground();
			
			addChild(highscoreBackground);
			addChild(totalText);
			addChild(button);
		}
		
		override public function update()
		{
			button.update(mouseIsPressed);
			
			if (!scoreBoardDisplayed)
			{
				publishScore();
				scoreBoardDisplayed = true;
			}
			
			totalText.text = "Total Score: " + Config.totalScore;
			totalText.setTextFormat(scoreFormat);
		}
		
		override public function mousePressed()
		{
			button.mousePressed();
		}
		
		public function publishScore()
		{
			API.postScore("FuhrersDayOff", Config.totalScore);
			Config.scoreBrowser.scoreBoardName = "FuhrersDayOff";
			Config.scoreBrowser.period = ScoreBoard.ALL_TIME;
			Config.scoreBrowser.loadScores();
			
			Config.scoreBrowser.x = 400 - (Config.scoreBrowser.width/2);
			Config.scoreBrowser.y = 300 - (Config.scoreBrowser.height/2);
			
			addChild(Config.scoreBrowser);
		}
	}
}

