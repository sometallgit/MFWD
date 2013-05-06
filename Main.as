package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	
	public class Main extends MovieClip
	{
		//Various States for the state machine
		public var currentState;
		public var s_Menu;
		public var s_LevelOne;
		
		public var xmlManager;
		
		public function Main()
		{	
			xmlManager = new XmlManager(MovieClip(root).levelData, this);
			//xmlManager.readStage();
			
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
			//trace("update");
			currentState.update();
			//trace(stage.frameRate);
		}
		
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
		public function changeStateTo(newState)
		{
			removeChild(currentState);
			currentState = newState;
			addChild(currentState);
		}
	}
}