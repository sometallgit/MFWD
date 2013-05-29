package
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.*;
	import flash.utils.*;
	
	public class S_LevelOneState extends GameState
	{
		override public function S_LevelOneState(documentClass)
		{
			refToDocClass = documentClass;
			//Initialise the player
			player = new Player(40, 40, this);
			
			//Initialise Hitler
			hitler = new Hitler(40, 40, this);
			hud = new HUD(this);
			enemies.push(new Enemy(this, hitler));
			
			muteSoundButton = new GUIButton(refToDocClass, "MUTE_SOUNDS", new ButtonSound());
			muteSoundButton.x = 727.8;
			muteSoundButton.startX = 727.8;
			muteSoundButton.y = 14.6;
			
			muteMusicButton = new GUIButton(refToDocClass, "MUTE_MUSIC", new ButtonMusic());
			muteMusicButton.x = 662.8;
			muteMusicButton.startX = 662.8;
			muteMusicButton.y = 14.6;
		}
		
		override public function endLevel()
		{
			//Before we transition away from this state, flush the scores to the Config class so they can be retrieved
			Config.getScore(enemiesKilled, levelTime, hitler.health, 1);
			//Tell the document class to transition to the next state
			refToDocClass.changeStateTo(refToDocClass.s_EndLevel, 1);
		}
		
		public function restartLevel()
		{
			Config.getScore(0,0,0, 1);
			refToDocClass.changeStateTo(refToDocClass.s_LevelOne);
		}
		
		
		//Move through each of the sections on the XML file and push a new instance of what is found into the respective array
		override public function buildFromXML()
		{
			var item:XML;

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
			
			//static background
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.static_background.object) 
			{ 
				create(item, staticBackgroundArray);
			}
			
			//background
			for each(item in refToDocClass.xmlManager.xmlFile.level_1.background.object) 
			{ 
				create(item, backgroundArray);
			}
			
			addToStage();

			addChild(muteSoundButton);
		}
	}
}