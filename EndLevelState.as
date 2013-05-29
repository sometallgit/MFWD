package
{
	import flash.display.MovieClip;
	import flash.utils.*;
	import flash.text.*;
		
	public class EndLevelState extends StateMachine
	{
		//How it knows which score to pull from the config
		public var levelIndex:int = 0;
		
		private var refToDocClass;
		private var enemiesKilledLevel;
		private var completionTimeLevel;
		private var hitlerHealthLevel;
		
		public var scoreFormat:TextFormat = new TextFormat();
		public var enemiesKilledText:TextField = new TextField();
		public var completionTimeText:TextField = new TextField();
		public var hitlerHealthText:TextField = new TextField();
		public var totalText:TextField = new TextField();
		public var advanceText:TextField = new TextField();
		
		private var currentTime:int;
		private var scoreIncrementTime:int;
		
		private var scoreBackground;
		
		//Which is the next text item to be updated
		private var textIndex:int = 0;
		
		private var counterFinished:Boolean;
		
		public function EndLevelState(documentClass)
		{
			//Give me a reference/pointer to the document class so I can access the variables and functions in the document class
			refToDocClass = documentClass;
			
			//When this state is transitioned to, get
			
			scoreFormat.align = TextFormatAlign.CENTER;
			scoreFormat.size = 20;
			scoreFormat.color = 0xFFFFFF;
			
			enemiesKilledText.text = "Enemies Killed: 0";
			completionTimeText.text = "Completion Time: 0";
			hitlerHealthText.text = "Health Remaining: 0";
			totalText.text = "Total: 0";

			enemiesKilledText.width = 800;
			enemiesKilledText.y = 80;
			
			completionTimeText.width = 800;
			completionTimeText.y = 160;
			
			hitlerHealthText.width = 800;
			hitlerHealthText.y = 240;
			
			totalText.width = 800;
			totalText.y = 320;
			
			advanceText.width = 800;
			advanceText.y = 400;
			
			scoreBackground = new ScoreBackground();
			
			addChild(scoreBackground);
			addChild(enemiesKilledText);
			addChild(completionTimeText);
			addChild(hitlerHealthText);
			addChild(totalText);
			addChild(advanceText);
		}
		
		public function buildScore(l)
		{
			//retrieve the level states according to which level just ended
			switch(l)
			{
				case 1:
					enemiesKilledLevel = Config.enemiesKilledLevel1;
					completionTimeLevel = Config.completionTimeLevel1;
					hitlerHealthLevel = Config.hitlerHealthLevel1;
					levelIndex = 1;
				break;
				
				case 2:
					enemiesKilledLevel = Config.enemiesKilledLevel2;
					completionTimeLevel = Config.completionTimeLevel2;
					hitlerHealthLevel = Config.hitlerHealthLevel2;
					levelIndex = 2;
				break;
				
				case 3:
					enemiesKilledLevel = Config.enemiesKilledLevel3;
					completionTimeLevel = Config.completionTimeLevel3;
					hitlerHealthLevel = Config.hitlerHealthLevel3;
					levelIndex = 3;
				break;
				
				default:
					trace("Incorrect level number given in EndLevelState.buildScore()");
				break;
			}
			//Set the timer
			scoreIncrementTime = getTimer + 1500;
			//Don't let the player exit the state till we're done
			counterFinished = false;
			//Reset the text index
			textIndex = 0;

		}
		
		override public function update()
		{
			//Get the time
			currentTime = getTimer();
			
			//If it's time to update the next score item
			if (currentTime > scoreIncrementTime)
			{
				switch (textIndex)
				{
					//Empty index to give a delay before the scores start populating
					case 0:
						textIndex++;
					break;
					
					case 1:
						enemiesKilledText.text = "Enemies Killed: " + enemiesKilledLevel.toString();
						textIndex++;
						Audio.play("score_build");
					break;
					
					case 2:
						var completionTime = (completionTimeLevel / 1000)
						completionTimeText.text = "Completion Time: " + completionTime.toString();
						textIndex++
						Audio.play("score_build");
					break;
					
					case 3:
						hitlerHealthText.text = "Health Remaining: " + hitlerHealthLevel.toString();
						textIndex++
						Audio.play("score_build");
					break;
					
					case 4:
						totalText.text = "Total: " + int(((enemiesKilledLevel * 10) + hitlerHealthLevel + (completionTimeLevel / 1000))).toString();
						Config.totalScore += int((enemiesKilledLevel * 10) + hitlerHealthLevel + (completionTimeLevel / 1000));
						//if counting is done, let the player advance
						counterFinished = true;
						//increment the textIndex to stop score retallying
						textIndex++;
						
						//Let the player know they can advance
						advanceText.text = "Press any key to advance..."
						Audio.play("score_final");
					break;
				}
				//Reset the timer
				scoreIncrementTime = currentTime + 750;
				
			}
			//Print score
			//enemiesKilledLevel
			
			enemiesKilledText.setTextFormat(scoreFormat);
			completionTimeText.setTextFormat(scoreFormat);
			hitlerHealthText.setTextFormat(scoreFormat);
			totalText.setTextFormat(scoreFormat);
			advanceText.setTextFormat(scoreFormat);
			
			
		}
		
		override public function keyPressed(key)
		{
			if (!counterFinished) return;
			//Advance to next level
			switch(levelIndex)
			{
				case 1: 
					refToDocClass.changeStateTo(refToDocClass.s_LevelTwo);
				break;
				
				case 2: 
					refToDocClass.changeStateTo(refToDocClass.s_LevelThree);
				break;
				
				case 3:
					//Transition to game over screen
					refToDocClass.changeStateTo(refToDocClass.s_GameOver);
				break;
				
				default:
					//refToDocClass.changeStateTo(refToDocClass.s_LevelTwo);
					trace("end level state error");
				break;
			}
		}
	}
}