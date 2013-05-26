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
		
		//If the readStage() function is uncommented, this empty xml object will be populated as it reads the stage
		//If load() is uncommented, the xml object is replaced by the xml file that the URL loader brings in
		public function XmlManager(stage, refToDoc)
		{
			refToStage = stage;
			refToDocClass = refToDoc;
			xmlFile = 		<Data>
								
								<menu>
									<gui>
										<button1></button1>									
										<button2></button2>
									</gui>
									<art></art>
									
								</menu>
								
								<instructions>
								</instructions>
								
								<level_1>
									<gui>
										<button1></button1>									
										<button2></button2>
									</gui>
									
									<background></background>
									<midground></midground>
									<foreground></foreground>
									<static_foreground></static_foreground>
									<collision></collision>
									<jump_trigger></jump_trigger>
									<stop_point></stop_point>
								</level_1>
								
								<level_2>
									<gui>
										<button1></button1>									
										<button2></button2>
									</gui>
									
									<background></background>
									<midground></midground>
									<foreground></foreground>
									<static_foreground></static_foreground>
									<collision></collision>
									<jump_trigger></jump_trigger>
									<stop_point></stop_point>
								</level_2>
								
								<level_3>
									<gui>
										<button1></button1>									
										<button2></button2>
									</gui>
									
									<background></background>
									<midground></midground>
									<foreground></foreground>
									<static_foreground></static_foreground>
									<collision></collision>
									<jump_trigger></jump_trigger>
									<stop_point></stop_point>
								</level_3>
																
							</Data>;
			//TODO: Move this into a flag held in the config xml
			//To generate and dump an XML file, uncomment readStage() and save() and comment load()
			//Do the opposite to load an already generated xml file
			//readStage();
			//save();
			load();
		}
		
		public function readStage()
		{
			trace("readStage()");
			var i:int = 0; //Stop annoying duplicate variable warning
			var object:XML;
			
			function checkType(stageAddress, xmlAddress)
			{
				if (stageAddress.getChildAt(i) is Button1)		appendXML("Button1", stageAddress, xmlAddress);
				if (stageAddress.getChildAt(i) is Button2)		appendXML("Button2", stageAddress, xmlAddress);
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
				
				//==========================================
				//================Button01==================
				//==========================================
				if (refToStage.menu.getChildAt(i) is Button1) 					{					appendXML("Button1", refToStage.menu, xmlFile.menu.gui.button1);			}

				//==========================================
				//================Button02==================
				//==========================================
				if (refToStage.menu.getChildAt(i) is Button2)					{					appendXML("Button2", refToStage.menu, xmlFile.menu.gui.button2);			}
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
			//================LEVEL 02==================
			//==========================================
			for(i = 0;i<refToStage.level2.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				//==========================================
				//================Midground==================
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
			
		}
		
		public function load()
		{
			xmlLoader.addEventListener(Event.COMPLETE, loadXML);
			xmlLoader.load(new URLRequest("Data.xml"));
		}
		
		private function loadXML(e:Event)
		{
			xmlFile = new XML(e.target.data);
			trace("XML Loaded Successfully");
			//Once the external xml file has loaded, tell the states to grab a copy
			refToDocClass.s_Menu.buildFromXML();
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