package
{
	
	import flash.display.MovieClip;
	
	public class S_LevelOneState extends StateMachine
	{
		private var refToDocClass;
		
		public var barrierArray:Array = new Array();
		public var jumpTriggerArray:Array = new Array();
		private var foregroundArray:Array = new Array();
		private var midgroundArray:Array = new Array();
		private var backgroundArray:Array = new Array();
		public var stoppingPointArray:Array = new Array();
		
		public var bullets:Array = new Array();
		
		private var button;
		public var player;
		public var hitler;
		public var enemy
		
		public function S_LevelOneState(documentClass)
		{
			refToDocClass = documentClass;
			//Initialise the player
			player = new Player(40, 40, this);
			
			//Initialise Hitler
			hitler = new Hitler(40, 40, this);
			
			enemy = new Enemy(40, 40, this, hitler);
			
			button = new GUIButton(refToDocClass, "ENTER_MENU", new Button1());
			addChild(button);
		}
		
		override public function update()
		{
			player.update();
			hitler.update();
			enemy.update();
			
			updateScroll();
			button.update(mouseIsPressed);
		}
		
		override public function keyPressed(key)
		{
			switch(key)
			{
				//Player movement
				case 90:	player.startMovingUp();		break; //Z
				case 88:	carry();					break; //X
				case 67:	player.attack();			break; //C
				case 40:	player.startMovingDown();	break; //Down arrow
				case 37:	player.startMovingLeft();	break; //Left arrow
				case 39:	player.startMovingRight();	break; //Right arrow
			}
		}
		
		override public function keyReleased(key)
		{
			switch(key)
			{
				case 90:	player.stopMovingUp();		break; //Z
				case 40:	player.stopMovingDown();	break; //down arrow
				case 37:	player.stopMovingLeft();	break; //left arrow	
				case 39:	player.stopMovingRight();	break; //right arrow
			}
		}
		
		override public function mousePressed()
		{
			button.mousePressed();
		}
		
		public function carry()
		{
			refToDocClass.currentState.hitler.carry(player.x, player.y, player.width, player.height);
		}
		
		override public function test()
		{
			trace("overridden");
			trace(refToDocClass);
		}
		
		private function updateScroll()
		{
			if (player.x < 150 - x)
			{
				x += 6;
				updateParallax(6);
			}
			if (player.x  > 550 - x)
			{
				x -= 6;
				updateParallax(-6);
			}
			
			function updateParallax(moveAmount)
			{
				var i:int = 0;
				for (i = 0; i < backgroundArray.length; i++)
				{
					backgroundArray[i].x -= moveAmount*0.3;
				}
				
				for (i = 0; i < foregroundArray.length; i++)
				{
					foregroundArray[i].x -= -moveAmount*0.5;
				}
			}
		}
		
		public function buildFromXML()
		{
			var item:XML;
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.gui.button1.object) 
			{ 
				create(item, midgroundArray);
			}
			//button2
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.gui.button2.object) 
			{ 
				create(item, midgroundArray);
			}
			
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.midground.object) 
			{ 
				create(item, midgroundArray);
			}
			
			//stopping point
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.stop_point.object) 
			{ 
				create(item, stoppingPointArray);
			}
			
			//CollisionBoundingBox
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.collision.object) 
			{ 
				barrierArray.push(new Barrier(item.@x, item.@y, item.@width, item.@height))
			}
			
			//JumpTrigger
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.jump_trigger.object) 
			{ 
				jumpTriggerArray.push(new JumpTrigger(item.@x, item.@y, item.@width, item.@height))
			}
			
			//foreground
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.foreground.object) 
			{ 
				create(item, foregroundArray);
			}
			
			//background
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.background.object) 
			{ 
				create(item, backgroundArray);
			}
			
			function create(xmlObject, layerArray)
			{
				switch(xmlObject.@type.toString())
				{
					case "Button1":
						layerArray.push(new Button1());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Button2":
						layerArray.push(new Button2());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "StoppingPoint":
						layerArray.push(new StoppingPoint());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset00":
						layerArray.push(new Asset00());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset01":
						layerArray.push(new Asset01());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset02":
						layerArray.push(new Asset02());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset03":
						layerArray.push(new Asset03());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset04":
						layerArray.push(new Asset04());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset05":
						layerArray.push(new Asset05());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset06":
						layerArray.push(new Asset06());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset07":
						layerArray.push(new Asset07());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset08":
						layerArray.push(new Asset08());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					case "Asset09":
						layerArray.push(new Asset09());
						layerArray[layerArray.length-1].x = xmlObject.@x;
						layerArray[layerArray.length-1].y = xmlObject.@y;
					break;
					default:
						trace("The type '" + xmlObject.@type.toString() + "' is not a recognised type. Add a definition for it.");
					break;
				}
			}
			
			addToStage();

		}
		
		private function addToStage()
		{
			var i:int = 0;
			for (i = 0; i < backgroundArray.length; i++)
			{
				addChild(backgroundArray[i]);
			}
			
			for (i = 0; i < midgroundArray.length; i++)
			{
				addChild(midgroundArray[i]);
			}
			
			for (i = 0; i < stoppingPointArray.length; i++)
			{
				addChild(stoppingPointArray[i]);
			}
			hitler.init();
			addChild(enemy);
			addChild(hitler);
			addChild(player);
			
			for (i = 0; i < foregroundArray.length; i++)
			{
				addChild(foregroundArray[i]);
			}
			
		}
		
	}
}