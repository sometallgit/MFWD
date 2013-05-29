package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	//Sound stuff
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class Main extends MovieClip
	{
		//Various States for the state machine
		public var currentState;
		public var s_Menu;
		public var s_Help;
		public var s_Credits;
		public var s_LevelOne;
		public var s_LevelTwo;
		public var s_LevelThree;
		public var s_EndLevel;
		public var s_GameOver;
		
		public var xmlManager;
		
		private var musicTracker;	// returned from audio channel when we start playing music.  we need this so we can stop it later if we want.
		
		//Load assets from dropbox
		//NOTE: Because of the security settings of flash, you can't have both local and network accessing in the same flash file, even if they're kept separate behind a boolean like below.
		//Audio.as, Config.as, and XmlManager.as all have their local file accessing commented out
		public static var loadFromNet:Boolean = true;
		public static var levelDataLoaded:Boolean = false;
		private var loadScreen;
		
		public function Main()
		{	
			xmlManager = new XmlManager(MovieClip(root).levelData, this);
			
			Audio.init();
			Config.init();
			
			//Initialise the states
			currentState = new StateMachine(this);
			s_Menu = new S_MenuState(this);
			s_LevelOne = new S_LevelOneState(this);
			s_LevelTwo = new S_LevelTwoState(this);
			s_LevelThree = new S_LevelThreeState(this);
			s_EndLevel = new EndLevelState(this);
			s_GameOver = new S_GameOverState(this);
			s_Help = new S_HelpState(this);
			s_Credits = new S_CreditsState(this);
			
			loadScreen = new Loading();
			
			trace("Main Class Instantiated");
			currentState = s_Menu;
			addChild(currentState);
			addChild(loadScreen);
			
			//Event listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			//keyboard event
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		//Update
		public function enterFrameHandler(e:Event)
		{
			if (levelDataLoaded)
			{
				currentState.update();
				if (loadScreen)
				{
					removeChild(loadScreen);
					loadScreen = null;
				}
			}
		}
		
		//TODO: Clean this up
		private function keyDownHandler(keyEvent)
		{
			currentState.keyPressed(keyEvent.keyCode);
		}
		
		private function keyUpHandler(keyEvent)
		{
			currentState.keyReleased(keyEvent.keyCode);
		}
		
		public function mousePressed(e:MouseEvent)
		{
			currentState.mousePressed();
		}
		
		public function mouseReleased(e:MouseEvent)
		{
			currentState.mouseReleased();
		}
		
		//Make the state machine switch the currently active state
		public function changeStateTo(newState, index = 0)
		{
			//If changing from one of the game level states, reset them before switching so they're ready to be reused
			//Stop the music, too
			if (currentState is S_LevelOneState) 
			{
				Audio.stop(Config.musicTracker);
				s_LevelOne = new S_LevelOneState(this);
				s_LevelOne.buildFromXML();
			}
			else if (currentState is S_LevelTwoState) 
			{
				Audio.stop(Config.musicTracker);
				s_LevelTwo = new S_LevelTwoState(this);
				s_LevelTwo.buildFromXML();
			}
			
			else if (currentState is S_LevelThreeState) 
			{
				Audio.stop(Config.musicTracker);
				s_LevelThree = new S_LevelThreeState(this);
				s_LevelThree.buildFromXML();
			}
			//Reset the endlevel state if changing from there
			if (currentState is EndLevelState)	s_EndLevel = new EndLevelState(this);
			
			//Zero the scores after coming from the game over screen
			if (currentState is S_GameOverState)
			{
				s_GameOver = new S_GameOverState(this);
				Config.clear();
			}
			
			removeChild(currentState);
			currentState = newState;
			addChild(currentState);
			
			//If transitioning to an end level state, tell it which level we just came from
			if (currentState is EndLevelState) currentState.buildScore(index);
			
			//Start the music at the beginning of a level
			if (currentState is S_LevelOneState)
			{
				Config.musicTracker = Audio.play("music");
				currentState.resetLevelTimer()
			}
			if (currentState is S_LevelTwoState) 
			{
				Config.musicTracker = Audio.play("music");
				currentState.resetLevelTimer()
			}
			if (currentState is S_LevelThreeState) 
			{
				Config.musicTracker = Audio.play("music");
				currentState.resetLevelTimer()
			}
		}
	}
}