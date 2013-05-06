package
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.*;
	import flash.net.*;
	import flash.events.*;
	
	public class XmlManager extends MovieClip
	{
		public var xmlFile:XML;
		var refToStage;
		var xmlLoader = new URLLoader();
		var refToDocClass
		
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
								</level_2>
																
							</Data>;
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