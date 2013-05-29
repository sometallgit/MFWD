package
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.events.*;
	
	//Because working with the stage makes me cry, the XML Manager reads the levels created on the stage, dumps the position
	//and type of everything and then rebuilds the level in code using the XML file. This allows the levels to be created
	//on the stage without making me pull my hair out
	
	//TODO: Clean up XML structure. Add newgrounds URL to the URL Loader
	public class XmlManager extends MovieClip
	{
		public var xmlFile:XML;
		var refToStage;
		var xmlLoader = new URLLoader();
		var refToDocClass
		//To generate and dump an XML file, set generateXML to true
		//Do the opposite to load an already generated xml file
		private var generateXML:Boolean = false;
		
		
		//If generateXML is true, this empty xml object will be populated as it reads the stage
		//If generateXML is false, the xml object is replaced by the xml file that the URL loader brings in
		public function XmlManager(stage, refToDoc)
		{
			refToStage = stage;
			refToDocClass = refToDoc;
			xmlFile = 		<Data>
								
								<menu>
									<art></art>
									
								</menu>
								
								<instructions>
								</instructions>
								
								<level_1>
									<background></background>
									<midground></midground>
									<foreground></foreground>
									<static_foreground></static_foreground>
									<static_background></static_background>
									<collision></collision>
									<jump_trigger></jump_trigger>
									<stop_point></stop_point>
								</level_1>
								
								<level_2>
									<background></background>
									<midground></midground>
									<foreground></foreground>
									<static_foreground></static_foreground>
									<static_background></static_background>
									<collision></collision>
									<jump_trigger></jump_trigger>
									<stop_point></stop_point>
								</level_2>
								
								<level_3>
									<background></background>
									<midground></midground>
									<foreground></foreground>
									<static_foreground></static_foreground>
									<static_background></static_background>
									<collision></collision>
									<jump_trigger></jump_trigger>
									<stop_point></stop_point>
								</level_3>
																
							</Data>;
			if (generateXML)
			{
				readStage();
				save();
			}
			else
			{
				load();
			}
			
		}
		
		public function readStage()
		{
			trace("readStage()");
			var i:int = 0; //Stop annoying duplicate variable warning
			var object:XML;
			
			function checkType(stageAddress, xmlAddress)
			{
				//if (stageAddress.getChildAt(i) is Button1)		appendXML("Button1", stageAddress, xmlAddress);
				//if (stageAddress.getChildAt(i) is Button2)		appendXML("Button2", stageAddress, xmlAddress);
				
				//You have no idea how much macros make me happy. Otherwise this would have been very painful
				if (stageAddress.getChildAt(i) is Asset00)		appendXML("Asset00", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset01)		appendXML("Asset01", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset02)		appendXML("Asset02", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset03)		appendXML("Asset03", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset04)		appendXML("Asset04", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset05)		appendXML("Asset05", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset06)		appendXML("Asset06", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset07)		appendXML("Asset07", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset08)		appendXML("Asset08", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset09)		appendXML("Asset09", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset10)		appendXML("Asset10", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset11)		appendXML("Asset11", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset12)		appendXML("Asset12", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset13)		appendXML("Asset13", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset14)		appendXML("Asset14", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset15)		appendXML("Asset15", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset16)		appendXML("Asset16", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset17)		appendXML("Asset17", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset18)		appendXML("Asset18", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset19)		appendXML("Asset19", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset20)		appendXML("Asset20", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset21)		appendXML("Asset21", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset22)		appendXML("Asset22", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset23)		appendXML("Asset23", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset24)		appendXML("Asset24", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset25)		appendXML("Asset25", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset26)		appendXML("Asset26", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset27)		appendXML("Asset27", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset28)		appendXML("Asset28", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset29)		appendXML("Asset29", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset30)		appendXML("Asset30", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset31)		appendXML("Asset31", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset32)		appendXML("Asset32", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset33)		appendXML("Asset33", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset34)		appendXML("Asset34", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset35)		appendXML("Asset35", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset36)		appendXML("Asset36", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset37)		appendXML("Asset37", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset38)		appendXML("Asset38", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset39)		appendXML("Asset39", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset40)		appendXML("Asset40", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset41)		appendXML("Asset41", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset42)		appendXML("Asset42", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset43)		appendXML("Asset43", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset44)		appendXML("Asset44", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset45)		appendXML("Asset45", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset46)		appendXML("Asset46", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset47)		appendXML("Asset47", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset48)		appendXML("Asset48", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset49)		appendXML("Asset49", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset50)		appendXML("Asset50", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset51)		appendXML("Asset51", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset52)		appendXML("Asset52", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset53)		appendXML("Asset53", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset54)		appendXML("Asset54", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset55)		appendXML("Asset55", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset56)		appendXML("Asset56", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset57)		appendXML("Asset57", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset58)		appendXML("Asset58", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset59)		appendXML("Asset59", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset60)		appendXML("Asset60", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset61)		appendXML("Asset61", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset62)		appendXML("Asset62", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset63)		appendXML("Asset63", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset64)		appendXML("Asset64", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset65)		appendXML("Asset65", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset66)		appendXML("Asset66", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset67)		appendXML("Asset67", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset68)		appendXML("Asset68", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset69)		appendXML("Asset69", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset70)		appendXML("Asset70", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset71)		appendXML("Asset71", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset72)		appendXML("Asset72", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset73)		appendXML("Asset73", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset74)		appendXML("Asset74", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset75)		appendXML("Asset75", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset76)		appendXML("Asset76", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset77)		appendXML("Asset77", stageAddress, xmlAddress);
				/*if (stageAddress.getChildAt(i) is Asset78)		appendXML("Asset78", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset79)		appendXML("Asset79", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset80)		appendXML("Asset80", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset81)		appendXML("Asset81", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset82)		appendXML("Asset82", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset83)		appendXML("Asset83", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset84)		appendXML("Asset84", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset85)		appendXML("Asset85", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset86)		appendXML("Asset86", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset87)		appendXML("Asset87", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset88)		appendXML("Asset88", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset89)		appendXML("Asset89", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset90)		appendXML("Asset90", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset91)		appendXML("Asset91", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset92)		appendXML("Asset92", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset93)		appendXML("Asset93", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset94)		appendXML("Asset94", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset95)		appendXML("Asset95", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset96)		appendXML("Asset96", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Asset97)		appendXML("Asset97", stageAddress, xmlAddress);
				*/
			}
			
			function appendXML(t, stageAddress, xmlAddress)
			{
				object.@type = 	t;
				object.@x = 	stageAddress.getChildAt(i).x;
				object.@y = 	stageAddress.getChildAt(i).y;
				object.@rotation = 	stageAddress.getChildAt(i).rotation;
				object.@scaleX = 	stageAddress.getChildAt(i).scaleX;
				object.@scaleY = 	stageAddress.getChildAt(i).scaleY;
				object.@transformX = 	stageAddress.getChildAt(i).transform.matrix.c;
				object.@transformY = 	stageAddress.getChildAt(i).transform.matrix.b;
				object.@matrixA = 	stageAddress.getChildAt(i).transform.matrix.a;
				object.@matrixB = 	stageAddress.getChildAt(i).transform.matrix.b;
				object.@matrixC = 	stageAddress.getChildAt(i).transform.matrix.c;
				object.@matrixD = 	stageAddress.getChildAt(i).transform.matrix.d;
				object.@matrixTX = 	stageAddress.getChildAt(i).transform.matrix.tx;
				object.@matrixTY = 	stageAddress.getChildAt(i).transform.matrix.ty;
				xmlAddress.appendChild(object);
			}
			
			function appendXMLScalable(t, stageAddress, xmlAddress)
			{
				object.@type = 	t;
				object.@x = stageAddress.getChildAt(i).x;
				object.@y = stageAddress.getChildAt(i).y;
				object.@width = stageAddress.getChildAt(i).width;
				object.@height = stageAddress.getChildAt(i).height;
				xmlAddress.appendChild(object);
			}
			
			//==========================================
			//================MAIN MENU=================
			//==========================================
			for(i = 0;i<refToStage.menu.numChildren;i++)
			{
				object = 	<object>
							</object>
				/*
				//==========================================
				//================Button01==================
				//==========================================
				if (refToStage.menu.getChildAt(i) is Button1) 					{					appendXML("Button1", refToStage.menu, xmlFile.menu.gui.button1);			}

				//==========================================
				//================Button02==================
				//==========================================
				if (refToStage.menu.getChildAt(i) is Button2)					{					appendXML("Button2", refToStage.menu, xmlFile.menu.gui.button2);			}
				*/
			}
			
			//==========================================
			//================LEVEL 01==================
			//==========================================
			for(i = 0;i<refToStage.level1.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				//==========================================
				//================Midground==================
				//==========================================
				checkType(refToStage.level1, xmlFile.level_1.midground);
				
				//==========================================
				//================Collision=================
				//==========================================
				if (refToStage.level1.getChildAt(i) is CollisionBoundingBox)	{					appendXMLScalable("CollisionBoundingBox", refToStage.level1, xmlFile.level_1.collision);		}
				
				//==========================================
				//==============Jump Trigger================
				//==========================================
				if (refToStage.level1.getChildAt(i) is AiJumpTrigger)			{					appendXMLScalable("AiJumpTrigger", refToStage.level1, xmlFile.level_1.jump_trigger);			}
				
				//==========================================
				//===============Stop Point=================
				//==========================================
				if (refToStage.level1.getChildAt(i) is StoppingPoint)			{					appendXML("StoppingPoint", refToStage.level1, xmlFile.level_1.stop_point);		}
				
			}
			
			//==========================================
			//===========LEVEL01 Foreground=============
			//==========================================
			for(i = 0;i<refToStage.level1_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level1_foreground, xmlFile.level_1.foreground);
			}
			
			//==========================================
			//===========LEVEL01 Background=============
			//==========================================
			for(i = 0;i<refToStage.level1_background.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level1_background, xmlFile.level_1.background);
			}
			
			//==========================================
			//=====LEVEL01 Static Foreground============
			//==========================================
			for(i = 0;i<refToStage.level1_static_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level1_static_foreground, xmlFile.level_1.static_foreground);
			}
			
			//==========================================
			//=====LEVEL01 Static Background============
			//==========================================
			for(i = 0;i<refToStage.level1_static_background.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level1_static_background, xmlFile.level_1.static_background);
			}
			
			
			//==========================================
			//================LEVEL 02==================
			//==========================================
			for(i = 0;i<refToStage.level2.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				//==========================================
				//================Midground=================
				//==========================================
				checkType(refToStage.level2, xmlFile.level_2.midground);
				
				//==========================================
				//================Collision=================
				//==========================================
				if (refToStage.level2.getChildAt(i) is CollisionBoundingBox)	{					appendXMLScalable("CollisionBoundingBox", refToStage.level2, xmlFile.level_2.collision);		}
				
				//==========================================
				//==============Jump Trigger================
				//==========================================
				if (refToStage.level2.getChildAt(i) is AiJumpTrigger)			{					appendXMLScalable("AiJumpTrigger", refToStage.level2, xmlFile.level_2.jump_trigger);			}
				
				//==========================================
				//===============Stop Point=================
				//==========================================
				if (refToStage.level2.getChildAt(i) is StoppingPoint)			{					appendXML("StoppingPoint", refToStage.level2, xmlFile.level_2.stop_point);		}
				
			}
			
			//==========================================
			//===========LEVEL02 Foreground=============
			//==========================================
			for(i = 0;i<refToStage.level2_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level2_foreground, xmlFile.level_2.foreground);
			}
			
			//==========================================
			//===========LEVEL02 Background=============
			//==========================================
			for(i = 0;i<refToStage.level2_background.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level2_background, xmlFile.level_2.background);
			}
			
			//==========================================
			//=====LEVEL02 Static Foreground============
			//==========================================
			for(i = 0;i<refToStage.level2_static_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level2_static_foreground, xmlFile.level_2.static_foreground);
			}
			
			//==========================================
			//=====LEVEL02 Static Background============
			//==========================================
			for(i = 0;i<refToStage.level2_static_background.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level2_static_background, xmlFile.level_2.static_background);
			}
			
			//==========================================
			//================LEVEL 03==================
			//==========================================
			for(i = 0;i<refToStage.level3.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				//==========================================
				//================Midground==================
				//==========================================
				checkType(refToStage.level3, xmlFile.level_3.midground);
				
				//==========================================
				//================Collision=================
				//==========================================
				if (refToStage.level3.getChildAt(i) is CollisionBoundingBox)	{					appendXMLScalable("CollisionBoundingBox", refToStage.level3, xmlFile.level_3.collision);		}
				
				//==========================================
				//==============Jump Trigger================
				//==========================================
				if (refToStage.level3.getChildAt(i) is AiJumpTrigger)			{					appendXMLScalable("AiJumpTrigger", refToStage.level3, xmlFile.level_3.jump_trigger);			}
				
				//==========================================
				//===============Stop Point=================
				//==========================================
				if (refToStage.level3.getChildAt(i) is StoppingPoint)			{					appendXML("StoppingPoint", refToStage.level3, xmlFile.level_3.stop_point);		}
				
			}
			
			//==========================================
			//===========LEVEL03 Foreground=============
			//==========================================
			for(i = 0;i<refToStage.level3_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level3_foreground, xmlFile.level_3.foreground);
			}
			
			//==========================================
			//===========LEVEL03 Background=============
			//==========================================
			for(i = 0;i<refToStage.level3_background.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level3_background, xmlFile.level_3.background);
			}
			
			//==========================================
			//=====LEVEL03 Static Foreground============
			//==========================================
			for(i = 0;i<refToStage.level3_static_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level3_static_foreground, xmlFile.level_3.static_foreground);
			}
			
			//==========================================
			//=====LEVEL03 Static Background============
			//==========================================
			for(i = 0;i<refToStage.level3_static_background.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				checkType(refToStage.level3_static_background, xmlFile.level_3.static_background);
			}
			
		}
		
		public function load()
		{
			xmlLoader.addEventListener(Event.COMPLETE, loadXML);
			if (Main.loadFromNet) xmlLoader.load(new URLRequest("https://dl.dropboxusercontent.com/s/wpemfps5hp1a3vb/Data.xml?token_hash=AAGba4Vxz51Hs9X3hvNsZ-tVM__HMuQO--zEa9KkILEBzg&dl=1")); 
			//if (!Main.loadFromNet) xmlLoader.load(new URLRequest("Data.xml"));
		}
		
		private function loadXML(e:Event)
		{
			xmlFile = new XML(e.target.data);
			trace("XML Loaded Successfully");
			Main.levelDataLoaded = true;
			//Once the external xml file has loaded, tell the states to grab a copy
			refToDocClass.s_LevelOne.buildFromXML();
			refToDocClass.s_LevelTwo.buildFromXML();
			refToDocClass.s_LevelThree.buildFromXML();
			//TODO: Change visible to remove child
			//Remove the level movieclip
			refToStage.visible = false;
		}
		
		public function save()
		{
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(xmlFile);
			
			var fr:FileReference = new FileReference();
			fr.save(ba, "Data.xml");
		}
	}
}