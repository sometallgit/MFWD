package
{
	
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.*;
	import flash.utils.*;
	
	public class S_LevelTwoState extends GameState
	{

		override public function S_LevelTwoState(documentClass)
		{
			
			refToDocClass = documentClass;
			//Initialise the player
			player = new Player(40, 40, this);
			
			//Initialise Hitler
			hitler = new Hitler(40, 40, this);
			
			enemies.push(new Enemy(this, hitler));
			enemies.push(new Enemy(this, hitler));
			enemies.push(new Enemy(this, hitler));
			
			button = new GUIButton(refToDocClass, "ENTER_MENU", new Button1());
			
		}
		
		//Move through each of the sections on the XML file and push a new instance of what is found into the respective array
		override public function buildFromXML()
		{
			var item:XML;
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.gui.button1.object) 
			{ 
				create(item, midgroundArray);
			}
			//button2
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.gui.button2.object) 
			{ 
				create(item, midgroundArray);
			}
			
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.midground.object) 
			{ 
				create(item, midgroundArray);
			}
			
			//stopping point
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.stop_point.object) 
			{ 
				create(item, stoppingPointArray);
			}
			
			//CollisionBoundingBox
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.collision.object) 
			{ 
				barrierArray.push(new Barrier(item.@x, item.@y, item.@width, item.@height))
			}
			
			//JumpTrigger
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.jump_trigger.object) 
			{ 
				jumpTriggerArray.push(new JumpTrigger(item.@x, item.@y, item.@width, item.@height))
			}
			
			//foreground
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.foreground.object) 
			{ 
				create(item, foregroundArray);
			}
			
			//static foreground
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.static_foreground.object) 
			{ 
				create(item, staticForegroundArray);
			}
			
			//background
			for each(item in refToDocClass.xmlManager.xmlFile.level_2.background.object) 
			{ 
				create(item, backgroundArray);
			}
			
			function create(xmlObject, layerArray)
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
			
			addToStage();

		}
		
	}
}