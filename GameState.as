package
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.display.*;
	import flash.filters.*;
	
	public class GameState extends StateMachine
	{
		public var refToDocClass;
		
		public var currentTime;
		public var startTime;
		public var levelTime;
		
		public var enemiesKilled:int;
		
		public var barrierArray:Array = new Array();
		public var jumpTriggerArray:Array = new Array();
		public var foregroundArray:Array = new Array();
		public var staticForegroundArray:Array = new Array(); //Non parallaxing layer
		public var midgroundArray:Array = new Array();
		public var backgroundArray:Array = new Array();
		public var stoppingPointArray:Array = new Array();
		public var enemies:Array = new Array();
		
		public var bullets:Array = new Array();
		
		public var droppedWeapons:Array = new Array();
		
		public var button;
		public var muteSoundButton;
		public var player;
		public var hitler;
		
		//Text object used for debugging
		public var debugFormat:TextFormat = new TextFormat();
		public var debugText1:TextField = new TextField();
		public var debugText2:TextField = new TextField();
		public var debugText3:TextField = new TextField();
		
		//Make the text a bit easier to see
		public var outline:GlowFilter=new GlowFilter(0xFFFFFF,1.0,2.0,2.0,10);
		
		
		public function GameState(documentClass = null)
		{
			currentTime = getTimer();
			startTime = currentTime;
			
			refToDocClass = documentClass;
			//Initialise the player
			//player = new Player(40, 40, this);
			
			//Initialise Hitler
			//hitler = new Hitler(40, 40, this);
			
			//button = new GUIButton(refToDocClass, "ENTER_MENU", new Button1());
			muteSoundButton = new GUIButton(refToDocClass, "MUTE_SOUNDS", new Button1());
			muteSoundButton.x = 400;
			
			
		}
		
		public function reset()
		{
			currentTime = getTimer();
			startTime = currentTime;
		    levelTime = 0;
			
			x = 0;
			var i:int = 0;
			for (i = 0; i < backgroundArray.length; i++)		{				removeChild(backgroundArray[i]);		}
			for (i = 0; i < midgroundArray.length; i++)			{				removeChild(midgroundArray[i]);			}
			for (i = 0; i < stoppingPointArray.length; i++)		{				removeChild(stoppingPointArray[i]);		}			
			for (i = 0; i < enemies.length; i++)				{				removeChild(enemies[i]);				}
			removeChild(hitler);
			removeChild(player);
			for (i = 0; i < staticForegroundArray.length; i++)	{				removeChild(staticForegroundArray[i]);	}
			for (i = 0; i < foregroundArray.length; i++)		{				removeChild(foregroundArray[i]);		}
			for (i = 0; i < bullets.length; i++)				{				removeChild(bullets[i]);				}
			
			barrierArray = new Array();
			jumpTriggerArray = new Array();
			foregroundArray = new Array();
			staticForegroundArray = new Array(); //Non parallaxing layer
			midgroundArray = new Array();
			backgroundArray = new Array();
			stoppingPointArray = new Array();
			enemies = new Array();
		
			bullets = new Array();
		
			droppedWeapons = new Array();
			
			player = new Player(40, 40, this);
			hitler = new Hitler(40, 40, this);
			
			enemies.push(new Enemy(this, hitler));
			enemies.push(new Enemy(this, hitler));
			enemies.push(new Enemy(this, hitler));
			
			removeChild(button);
			button = new GUIButton(refToDocClass, "ENTER_MENU", new Button1());
			
			buildFromXML();
		}
		
		override public function update()
		{
			//Get the time
			currentTime = getTimer();
			levelTime = currentTime - startTime;
			
			//Stop annoying duplicate variable warning
			var i:int;
			
			player.update();
			hitler.update();
			for(i = 0; i < enemies.length; i++)
			{
				enemies[i].update();
			}
			updateScroll();
			button.update(mouseIsPressed);
			muteSoundButton.update(mouseIsPressed);
			
			for(i = 0; i < droppedWeapons.length; i++)
			{
				droppedWeapons[i].update();
			}
			//parent.setChildIndex(MovieClip(root).debugText1, 7)
			//parent.setChildIndex(MovieClip(root).debugText2, 7)
			//parent.setChildIndex(MovieClip(root).debugText3, 7)
			
		}
		
		//Get player input
		override public function keyPressed(key)
		{
			switch(key)
			{
				case 90:	player.startMovingUp();					break; //Z
				case 88:	hitler.carry(); player.pickupWeapon();	break; //X
				case 67:	player.attack();						break; //C
				case 40:	player.startMovingDown();				break; //Down arrow
				case 37:	player.startMovingLeft();				break; //Left arrow
				case 39:	player.startMovingRight();				break; //Right arrow
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
		
		//Get mouse input
		override public function mousePressed()
		{
			button.mousePressed();
			muteSoundButton.mousePressed();
		}
		
		//When an enemy is killed, instantiate a new dropped weapon with the type of what they were carrying. With the exception of the knife
		public function dropWep(i)
		{
			if (enemies[i].currentWeapon.type != "KNIFE")
			{
				droppedWeapons.push(new WeaponDropped(enemies[i].currentWeapon.type, this, enemies[i].x, enemies[i].y));
				addChild(droppedWeapons[droppedWeapons.length - 1]);
			}
		}
		
		override public function endLevel()
		{
			//trace("The current state has no endLevel() defined");
			//Config.getScore(enemiesKilled, levelTime, hitler.health)
			
			//if (this is S_LevelOneState)
			//{
				//refToDocClass.changeStateTo(refToDocClass.s_Menu);
			//}
		}
		
		public function updateScroll()
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
		
		//Move through each of the sections on the XML file and push a new instance of what is found into the respective array
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
			
			//static foreground
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.static_foreground.object) 
			{ 
				create(item, staticForegroundArray);
			}
			
			//background
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.background.object) 
			{ 
				create(item, backgroundArray);
			}
			
			addToStage();

		}
		
		//Used to build the level arrays
		public function create(xmlObject, layerArray)
			{
				function createAssetGeneric()
				{
					layerArray[layerArray.length-1].transform.matrix = new Matrix(	  layerArray[layerArray.length-1].transform.matrix.a = xmlObject.@matrixA,
																					  layerArray[layerArray.length-1].transform.matrix.b = xmlObject.@matrixB,
																					  layerArray[layerArray.length-1].transform.matrix.c = xmlObject.@matrixC,
																					  layerArray[layerArray.length-1].transform.matrix.d = xmlObject.@matrixD,
																					  layerArray[layerArray.length-1].transform.matrix.tx = xmlObject.@matrixTX,
																					  layerArray[layerArray.length-1].transform.matrix.ty = xmlObject.@matrixTY)
					layerArray[layerArray.length-1].cacheAsBitmap = true;
				}
				
				
				switch(xmlObject.@type.toString())
				{
					case "Button1":						layerArray.push(new Button1());						createAssetGeneric();					break;
					case "Button2":						layerArray.push(new Button2());						createAssetGeneric();					break;
					case "StoppingPoint":				layerArray.push(new StoppingPoint());				createAssetGeneric();					break;
					case "Asset00":						layerArray.push(new Asset00());						createAssetGeneric();					break;
					case "Asset01":						layerArray.push(new Asset01());						createAssetGeneric();					break;
					case "Asset02":						layerArray.push(new Asset02());						createAssetGeneric();					break;
					case "Asset03":						layerArray.push(new Asset03());						createAssetGeneric();					break;
					case "Asset04":						layerArray.push(new Asset04());						createAssetGeneric();					break;
					case "Asset05":						layerArray.push(new Asset05());						createAssetGeneric();					break;
					case "Asset06":						layerArray.push(new Asset06());						createAssetGeneric();					break;
					case "Asset07":						layerArray.push(new Asset07());						createAssetGeneric();					break;
					case "Asset08":						layerArray.push(new Asset08());						createAssetGeneric();					break;
					case "Asset09":						layerArray.push(new Asset09());						createAssetGeneric();					break;
					default:	trace("The type '" + xmlObject.@type.toString() + "' is not a recognised type. Add a definition for it.");			break;
				}
			}
		
		//Populate the newly created arrays
		public function addToStage()
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
			for (i = 0; i < enemies.length; i++)
			{
				addChild(enemies[i]);
			}

			addChild(hitler);
			addChild(player);
			
			for (i = 0; i < staticForegroundArray.length; i++)
			{
				addChild(staticForegroundArray[i]);
			}
			
			for (i = 0; i < foregroundArray.length; i++)
			{
				addChild(foregroundArray[i]);
			}
			
			addChild(button);
			addChild(muteSoundButton);
			
		}
		
	}
}