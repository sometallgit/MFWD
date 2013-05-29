package
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.*;
	import flash.utils.*;
	import flash.display.*;
	
	//GameState serves as a base class for the game levels. It holds all the common elements that the levels share to 
	//reduce the amount of duplicated code
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
		public var staticBackgroundArray:Array = new Array(); //Non parallaxing layer
		public var midgroundArray:Array = new Array();
		public var backgroundArray:Array = new Array();
		public var stoppingPointArray:Array = new Array();
		public var enemies:Array = new Array();
		
		public var bullets:Array = new Array();
		
		public var droppedWeapons:Array = new Array();
		
		public var muteSoundButton;
		public var muteMusicButton;
		public var player;
		public var hitler;
		
		public var hud; 
		
		public function GameState(documentClass = null)
		{
			currentTime = getTimer();
			startTime = currentTime;
			
			refToDocClass = documentClass;

			muteSoundButton = new GUIButton(refToDocClass, "MUTE_SOUNDS", new Button1());
			muteSoundButton.x = 400;
			hud = new HUD(this);
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
			hud.update();
			for(i = 0; i < enemies.length; i++)
			{
				enemies[i].update();
			}
			updateScroll();
			muteSoundButton.update(mouseIsPressed);
			muteMusicButton.update(mouseIsPressed);
			
			for(i = 0; i < droppedWeapons.length; i++)
			{
				droppedWeapons[i].update();
			}
		}
		
		//Reset the start time for the level
		public function resetLevelTimer()
		{
			startTime = getTimer();
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
			muteSoundButton.mousePressed();
			muteMusicButton.mousePressed();
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
				hud.x -= moveAmount;
				for (i = 0; i < staticBackgroundArray.length; i++)
				{
					staticBackgroundArray[i].x -= moveAmount;
				}
				
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
				
				//...Yeah... I know what you're thinking. It makes me cry too.
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
					case "Asset10":						layerArray.push(new Asset10());						createAssetGeneric();					break;
					case "Asset11":						layerArray.push(new Asset11());						createAssetGeneric();					break;
					case "Asset12":						layerArray.push(new Asset12());						createAssetGeneric();					break;
					case "Asset13":						layerArray.push(new Asset13());						createAssetGeneric();					break;
					case "Asset14":						layerArray.push(new Asset14());						createAssetGeneric();					break;
					case "Asset15":						layerArray.push(new Asset15());						createAssetGeneric();					break;
					case "Asset16":						layerArray.push(new Asset16());						createAssetGeneric();					break;
					case "Asset17":						layerArray.push(new Asset17());						createAssetGeneric();					break;
					case "Asset18":						layerArray.push(new Asset18());						createAssetGeneric();					break;
					case "Asset19":						layerArray.push(new Asset19());						createAssetGeneric();					break;
					case "Asset20":						layerArray.push(new Asset20());						createAssetGeneric();					break;
					case "Asset21":						layerArray.push(new Asset21());						createAssetGeneric();					break;
					case "Asset22":						layerArray.push(new Asset22());						createAssetGeneric();					break;
					case "Asset23":						layerArray.push(new Asset23());						createAssetGeneric();					break;
					case "Asset24":						layerArray.push(new Asset24());						createAssetGeneric();					break;
					case "Asset25":						layerArray.push(new Asset25());						createAssetGeneric();					break;
					case "Asset26":						layerArray.push(new Asset26());						createAssetGeneric();					break;
					case "Asset27":						layerArray.push(new Asset27());						createAssetGeneric();					break;
					case "Asset28":						layerArray.push(new Asset28());						createAssetGeneric();					break;
					case "Asset29":						layerArray.push(new Asset29());						createAssetGeneric();					break;
					case "Asset30":						layerArray.push(new Asset30());						createAssetGeneric();					break;
					case "Asset31":						layerArray.push(new Asset31());						createAssetGeneric();					break;
					case "Asset32":						layerArray.push(new Asset32());						createAssetGeneric();					break;
					case "Asset33":						layerArray.push(new Asset33());						createAssetGeneric();					break;
					case "Asset34":						layerArray.push(new Asset34());						createAssetGeneric();					break;
					case "Asset35":						layerArray.push(new Asset35());						createAssetGeneric();					break;
					case "Asset36":						layerArray.push(new Asset36());						createAssetGeneric();					break;
					case "Asset37":						layerArray.push(new Asset37());						createAssetGeneric();					break;
					case "Asset38":						layerArray.push(new Asset38());						createAssetGeneric();					break;
					case "Asset39":						layerArray.push(new Asset39());						createAssetGeneric();					break;
					case "Asset40":						layerArray.push(new Asset40());						createAssetGeneric();					break;
					case "Asset41":						layerArray.push(new Asset41());						createAssetGeneric();					break;
					case "Asset42":						layerArray.push(new Asset42());						createAssetGeneric();					break;
					case "Asset43":						layerArray.push(new Asset43());						createAssetGeneric();					break;
					case "Asset44":						layerArray.push(new Asset44());						createAssetGeneric();					break;
					case "Asset45":						layerArray.push(new Asset45());						createAssetGeneric();					break;
					case "Asset46":						layerArray.push(new Asset46());						createAssetGeneric();					break;
					case "Asset47":						layerArray.push(new Asset47());						createAssetGeneric();					break;
					case "Asset48":						layerArray.push(new Asset48());						createAssetGeneric();					break;
					case "Asset49":						layerArray.push(new Asset49());						createAssetGeneric();					break;
					case "Asset50":						layerArray.push(new Asset50());						createAssetGeneric();					break;
					case "Asset51":						layerArray.push(new Asset51());						createAssetGeneric();					break;
					case "Asset52":						layerArray.push(new Asset52());						createAssetGeneric();					break;
					case "Asset53":						layerArray.push(new Asset53());						createAssetGeneric();					break;
					case "Asset54":						layerArray.push(new Asset54());						createAssetGeneric();					break;
					case "Asset55":						layerArray.push(new Asset55());						createAssetGeneric();					break;
					case "Asset56":						layerArray.push(new Asset56());						createAssetGeneric();					break;
					case "Asset57":						layerArray.push(new Asset57());						createAssetGeneric();					break;
					case "Asset58":						layerArray.push(new Asset58());						createAssetGeneric();					break;
					case "Asset59":						layerArray.push(new Asset59());						createAssetGeneric();					break;
					case "Asset60":						layerArray.push(new Asset60());						createAssetGeneric();					break;
					case "Asset61":						layerArray.push(new Asset61());						createAssetGeneric();					break;
					case "Asset62":						layerArray.push(new Asset62());						createAssetGeneric();					break;
					case "Asset63":						layerArray.push(new Asset63());						createAssetGeneric();					break;
					case "Asset64":						layerArray.push(new Asset64());						createAssetGeneric();					break;
					case "Asset65":						layerArray.push(new Asset65());						createAssetGeneric();					break;
					case "Asset66":						layerArray.push(new Asset66());						createAssetGeneric();					break;
					case "Asset67":						layerArray.push(new Asset67());						createAssetGeneric();					break;
					case "Asset68":						layerArray.push(new Asset68());						createAssetGeneric();					break;
					case "Asset69":						layerArray.push(new Asset69());						createAssetGeneric();					break;
					case "Asset70":						layerArray.push(new Asset70());						createAssetGeneric();					break;
					case "Asset71":						layerArray.push(new Asset71());						createAssetGeneric();					break;
					case "Asset72":						layerArray.push(new Asset72());						createAssetGeneric();					break;
					case "Asset73":						layerArray.push(new Asset73());						createAssetGeneric();					break;
					case "Asset74":						layerArray.push(new Asset74());						createAssetGeneric();					break;
					case "Asset75":						layerArray.push(new Asset75());						createAssetGeneric();					break;		
					case "Asset76":						layerArray.push(new Asset76());						createAssetGeneric();					break;
					case "Asset77":						layerArray.push(new Asset77());						createAssetGeneric();					break;
					/*case "Asset78":						layerArray.push(new Asset78());						createAssetGeneric();					break;
					case "Asset79":						layerArray.push(new Asset79());						createAssetGeneric();					break;
					case "Asset80":						layerArray.push(new Asset80());						createAssetGeneric();					break;
					case "Asset81":						layerArray.push(new Asset81());						createAssetGeneric();					break;
					case "Asset82":						layerArray.push(new Asset82());						createAssetGeneric();					break;
					case "Asset83":						layerArray.push(new Asset83());						createAssetGeneric();					break;
					case "Asset84":						layerArray.push(new Asset84());						createAssetGeneric();					break;
					case "Asset85":						layerArray.push(new Asset85());						createAssetGeneric();					break;
					case "Asset86":						layerArray.push(new Asset86());						createAssetGeneric();					break;
					case "Asset87":						layerArray.push(new Asset87());						createAssetGeneric();					break;
					case "Asset88":						layerArray.push(new Asset88());						createAssetGeneric();					break;
					case "Asset89":						layerArray.push(new Asset89());						createAssetGeneric();					break;
					case "Asset90":						layerArray.push(new Asset90());						createAssetGeneric();					break;
					case "Asset91":						layerArray.push(new Asset91());						createAssetGeneric();					break;
					case "Asset92":						layerArray.push(new Asset92());						createAssetGeneric();					break;
					case "Asset93":						layerArray.push(new Asset93());						createAssetGeneric();					break;
					case "Asset94":						layerArray.push(new Asset94());						createAssetGeneric();					break;
					case "Asset95":						layerArray.push(new Asset95());						createAssetGeneric();					break;
					case "Asset96":						layerArray.push(new Asset96());						createAssetGeneric();					break;
					case "Asset97":						layerArray.push(new Asset97());						createAssetGeneric();					break;
					*/
					default:	trace("The type '" + xmlObject.@type.toString() + "' is not a recognised type. Add a definition for it.");			break;
				}
			}
		
		//Populate the newly created arrays
		public function addToStage()
		{
			var i:int = 0;
			
			for (i = 0; i < staticBackgroundArray.length; i++)
			{
				addChild(staticBackgroundArray[i]);
			}
			
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
			
			addChild(muteSoundButton);
			addChild(muteMusicButton);
			addChild(hud);
		}
	}
}