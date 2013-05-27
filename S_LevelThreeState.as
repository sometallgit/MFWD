﻿package
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.*;
	import flash.utils.*;
	//Used for text TODO: Remove - Probably
	import flash.text.*;
	import flash.filters.*;
	
	public class S_LevelThreeState extends GameState
	{
		override public function S_LevelThreeState(documentClass)
		{
			
			refToDocClass = documentClass;
			//Initialise the player
			player = new Player(40, 40, this);
			
			//Initialise Hitler
			hitler = new Hitler(40, 40, this);
			hud = new HUD(this);
			enemies.push(new Enemy(this, hitler));
			//enemies.push(new Enemy(this, hitler));
			//enemies.push(new Enemy(this, hitler));
			
			button = new GUIButton(refToDocClass, "ENTER_MENU", new Button1());
			muteSoundButton = new GUIButton(refToDocClass, "MUTE_SOUNDS", new ButtonSound());
			muteSoundButton.x = 727.8;
			muteSoundButton.startX = 727.8;
			muteSoundButton.y = 14.6;
			
			muteMusicButton = new GUIButton(refToDocClass, "MUTE_MUSIC", new ButtonMusic());
			muteMusicButton.x = 662.8;
			muteMusicButton.startX = 662.8;
			muteMusicButton.y = 14.6;
			
			debugFormat.align = TextFormatAlign.CENTER;
			debugFormat.size = 20;
			debugText1.width = 400;
			debugText2.width = 400;
			debugText3.width = 400;
			
			outline.quality=BitmapFilterQuality.MEDIUM;
			
			debugText1.filters=[outline];
			debugText2.filters=[outline];
			debugText3.filters=[outline];
			
			//debugText1.text = 'This is a test of allignment';
			//debugText1.setTextFormat(debugFormat);
			addChild(debugText1);
			addChild(debugText2);
			addChild(debugText3);
			
		}
		
		override public function endLevel()
		{
			//Before we transition away from this state, flush the scores to the Config class so they can be retrieved
			Config.getScore(enemiesKilled, levelTime, hitler.health, 3);
			//Tell the document class to transition to the next state
			refToDocClass.changeStateTo(refToDocClass.s_EndLevel, 3);
		}
		
		//Move through each of the sections on the XML file and push a new instance of what is found into the respective array
		override public function buildFromXML()
		{
			var item:XML;

			for each(item in refToDocClass.xmlManager.xmlFile.level_3.midground.object) 
			{ 
				create(item, midgroundArray);
			}
			
			//stopping point
			for each(item in refToDocClass.xmlManager.xmlFile.level_3.stop_point.object) 
			{ 
				create(item, stoppingPointArray);
			}
			
			//CollisionBoundingBox
			for each(item in refToDocClass.xmlManager.xmlFile.level_3.collision.object) 
			{ 
				barrierArray.push(new Barrier(item.@x, item.@y, item.@width, item.@height))
			}
			
			//JumpTrigger
			for each(item in refToDocClass.xmlManager.xmlFile.level_3.jump_trigger.object) 
			{ 
				jumpTriggerArray.push(new JumpTrigger(item.@x, item.@y, item.@width, item.@height))
			}
			
			//foreground
			for each(item in refToDocClass.xmlManager.xmlFile.level_3.foreground.object) 
			{ 
				create(item, foregroundArray);
			}
			
			//static foreground
			for each(item in refToDocClass.xmlManager.xmlFile.level_3.static_foreground.object) 
			{ 
				create(item, staticForegroundArray);
			}
			
			//static background
			for each(item in refToDocClass.xmlManager.xmlFile.level_3.static_background.object) 
			{ 
				create(item, staticBackgroundArray);
			}
			
			//background
			for each(item in refToDocClass.xmlManager.xmlFile.level_3.background.object) 
			{ 
				create(item, backgroundArray);
			}
			
			addToStage();
			setChildIndex(debugText1, getChildIndex(player));
			setChildIndex(debugText2, getChildIndex(player));
			setChildIndex(debugText3, getChildIndex(player));
			
			addChild(muteSoundButton);

		}
		
	}
}