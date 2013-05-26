﻿package
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
	
	//Text stuff
	//TODO: Probably remove this
	import flash.text.*;
	
	public class Main extends MovieClip
	{
		//Various States for the state machine
		public var currentState;
		public var s_Menu;
		public var s_LevelOne;
		public var s_LevelTwo;
		public var s_LevelThree;
		public var s_EndLevel;
		public var s_GameOver;
		
		public var xmlManager;
		
		private var musicTracker;	// returned from audio channel when we start playing music.  we need this so we can stop it later if we want.
		
		//TODO: Remove these
		var temp;
		var myFormat:TextFormat = new TextFormat();
		var myText:TextField = new TextField();
		public var soundComplete:Boolean = true;
		
		public function Main()
		{	
			xmlManager = new XmlManager(MovieClip(root).levelData, this);
			//xmlManager.readStage();
			
			Audio.init();
			Config.init();
			
			currentState = new StateMachine(this);
			s_Menu = new S_MenuState(this);
			s_LevelOne = new S_LevelOneState(this);
			s_LevelTwo = new S_LevelTwoState(this);
			s_LevelThree = new S_LevelThreeState(this);
			s_EndLevel = new EndLevelState(this);
			s_GameOver = new S_GameOverState(this);
			
			trace("Main Class Instantiated");
			currentState = s_Menu;
			//currentState.test();
			addChild(currentState);
			
			//TODO: Remove these
			myFormat.align = TextFormatAlign.CENTER;
			myFormat.size = 30;
			myText.width = 400;
			myText.text = 'This is a test of allignment';
			myText.setTextFormat(myFormat);
			myText.selectable = false;
			addChild(myText);
			
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
			
			//TODO: Remove
			if (currentState.numChildren != temp)
			{
				setChildIndex(myText, getChildIndex(currentState));
				myText.text = currentState.numChildren;
				myText.setTextFormat(myFormat);
				temp = currentState.numChildren;
			}
		}
		
		//TODO: Clean this up
		private function keyDownHandler(keyEvent)
		{
			currentState.keyPressed(keyEvent.keyCode);
			/*
			//TESTING
			switch(keyEvent.keyCode)
			{
				// a - just play fire sound effect
				case 65: Audio.play("fire"); currentState.reset(); currentState.buildFromXML(); break;
				
				// b - just play explode sound effect
				case 66: Audio.play("explode"); break;
				
				// c - play fire sound effect with notifaction on complete
				case 67:
				{
					if (soundComplete)
					{
						var c = Audio.play("fire");
						soundComplete = false;
						c.addEventListener(Event.SOUND_COMPLETE, fireSoundComplete);
					} 
					
				}
				break;

				// d - play background music
				case 68: musicTracker = Audio.play("music"); break;

				// e - stop music
				case 69: Audio.stop(musicTracker); musicTracker = null; break;
			}
			*/
			
			
			switch(keyEvent.keyCode)
			{
				case 65: 
					
					trace("score submitted");
				break
				
				case 66:
					trace("Showing scores");
					
					
				break;
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
			if (currentState is S_LevelOneState) Config.musicTracker = Audio.play("music");
			if (currentState is S_LevelTwoState) Config.musicTracker = Audio.play("music");
			if (currentState is S_LevelThreeState) Config.musicTracker = Audio.play("music");
		}
		
		//TODO: Remove this if needed
		public function reset()
		{
			trace("RESET HAS BEEN CALLED! IT'S NOT A DUD FUNCTION");
			removeChild(currentState);
			if (currentState is S_MenuState) currentState = new  S_MenuState(this);
			if (currentState is S_LevelOneState) 
			{
				
				currentState = new  S_LevelOneState(this); 
				currentState.buildFromXML()
				
			}
			if (currentState is S_LevelTwoState) currentState = new  S_LevelTwoState(this);
			if (currentState is EndLevelState) currentState = new  EndLevelState(this);
			addChild(currentState);
		}
		
		// fire sound effect complete is notified
		private function fireSoundComplete(e : Event)
		{
			trace("fire sound complete");
			soundComplete = true;
		}
		
	}
}