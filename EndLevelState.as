package
{
	import flash.display.MovieClip;
	
	public class EndLevelState extends StateMachine
	{
		//How it knows which score to pull from the config
		public var levelIndex:int = 0;
		
		private var refToDocClass;
		//private var enemiesKilledLevel;
		//private var completionTimeLevel;
		//private var hitlerHealthLevel;
		
		private var enemiesKilledLevel1;
		private var completionTimeLevel1;
		private var hitlerHealthLevel1;

		private var enemiesKilledLevel2;
		private var completionTimeLevel2;
		private var hitlerHealthLevel2;
			
		private var enemiesKilledLevel3;
		private var completionTimeLevel3;
		private var hitlerHealthLevel3;
		
		public function EndLevelState(documentClass)
		{
			//Give me a reference/pointer to the document class so I can access the variables and functions in the document class
			refToDocClass = documentClass;
			
			//When this state is transitioned to, get
		}
		
		public function buildScore(l)
		{
			//retrieve the level states according to which level just ended
			switch(l)
			{
				case 1:
					enemiesKilledLevel1 = Config.enemiesKilledLevel1;
					completionTimeLevel1 = Config.completionTimeLevel1;
					hitlerHealthLevel1 = Config.hitlerHealthLevel1;
				break;
				
				case 2:
					enemiesKilledLevel2 = Config.enemiesKilledLevel2;
					completionTimeLevel2 = Config.completionTimeLevel2;
					hitlerHealthLevel2 = Config.hitlerHealthLevel2;
				break;
				
				case 3:
					enemiesKilledLevel3 = Config.enemiesKilledLevel2;
					completionTimeLevel3 = Config.completionTimeLevel3;
					hitlerHealthLevel3 = Config.hitlerHealthLevel3;
				break;
				
				default:
					trace("Incorrect level number given in EndLevelState.buildScore()");
				break;
			}
			levelIndex = l;
		}
		
		override public function update()
		{
			//Print score
			//parent.setChildIndex(MovieClip(root).scoreText1, 7)
			//parent.setChildIndex(MovieClip(root).scoreText2, 7)
			//parent.setChildIndex(MovieClip(root).scoreText3, 7)
			
			//MovieClip(root).scoreText1.text = "TEST";
			//MovieClip(root).scoreText2.text = "TEST";
			//MovieClip(root).scoreText3.text = "TEST";
		}
		
		override public function keyPressed(key)
		{
			trace("level change");
			//Advance to next level
			switch(levelIndex)
			{
				case 1: 
					refToDocClass.changeStateTo(refToDocClass.s_LevelTwo);
				break;
				
				default:
				refToDocClass.changeStateTo(refToDocClass.s_LevelTwo);
					//trace("end level state error");
				break;
			}
		}
	}
}