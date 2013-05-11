package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class Main extends MovieClip
	{
		//Various States for the state machine
		public var currentState;
		public var s_Menu;
		public var s_LevelOne;
		
		public var xmlManager;
		
		private var musicTracker;	// returned from audio channel when we start playing music.  we need this so we can stop it later if we want.
		
		public function Main()
		{	
			xmlManager = new XmlManager(MovieClip(root).levelData, this);
			//xmlManager.readStage();
			
			Audio.init();
			Config.init();
			
			currentState = new StateMachine(this);
			s_Menu = new S_MenuState(this);
			s_LevelOne = new S_LevelOneState(this);
			
			trace("Main Class Instantiated");
			currentState = s_Menu;
			currentState.test();
			addChild(currentState);
			
			
			//Event listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			//keyboard event
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			
		}
		
		public function enterFrameHandler(e:Event)
		{
			//Update function
			currentState.update();
		}
		
		private function keyDownHandler(keyEvent)
		{
			currentState.keyPressed(keyEvent.keyCode);
			
			
			//TESTING
			switch(keyEvent.keyCode)
			{
				// a - just play fire sound effect
				case 65: Audio.play("fire"); break;
				
				// b - just play explode sound effect
				case 66: Audio.play("explode"); break;
				
				// c - play fire sound effect with notifaction on complete
				case 67:
				{
					//var c = Audio.play("fire"); 
					//c.addEventListener(Event.SOUND_COMPLETE, fireSoundComplete);
				}
				break;

				// d - play background music
				case 68: musicTracker = Audio.play("music"); break;

				// e - stop music
				case 69: Audio.stop(musicTracker); musicTracker = null; break;
			}
			
			
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
		public function changeStateTo(newState)
		{
			removeChild(currentState);
			currentState = newState;
			addChild(currentState);
		}
		
		// fire sound effect complete is notified
		private function fireSoundComplete(e : Event)
		{
			trace("fire sound complete");
		}
		
	}
}