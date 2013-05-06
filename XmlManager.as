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
			//xmlFile.ignoreWhite = true;
			//readStage();
			//save();
			load();
		}
		
		public function readStage()
		{
			trace("readStage()");
			var i:int = 0; //Stop annoying duplicate variable warning
			var object:XML;
			
			
			
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
				if (refToStage.menu.getChildAt(i) is Button1) 
				{
					object.@type = 	"Button1";
					object.@x = 	refToStage.menu.getChildAt(i).x;
					object.@y = 	refToStage.menu.getChildAt(i).y;
					xmlFile.menu.gui.button1.appendChild(object);
				}

				//==========================================
				//================Button02==================
				//==========================================
				if (refToStage.menu.getChildAt(i) is Button2)
				{
					object.@type = 	"Button2";
					object.@x = refToStage.menu.getChildAt(i).x;
					object.@y = refToStage.menu.getChildAt(i).y;
					xmlFile.menu.gui.button2.appendChild(object);
				}
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
				if (refToStage.level1.getChildAt(i) is Asset00) 
				{
					object.@type = 	"Asset00";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset01) 
				{
					object.@type = 	"Asset01";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset02) 
				{
					object.@type = 	"Asset02";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset03) 
				{
					object.@type = 	"Asset03";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset04) 
				{
					object.@type = 	"Asset04";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset05) 
				{
					object.@type = 	"Asset05";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset06) 
				{
					object.@type = 	"Asset06";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset07) 
				{
					object.@type = 	"Asset07";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset08) 
				{
					object.@type = 	"Asset08";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				if (refToStage.level1.getChildAt(i) is Asset09) 
				{
					object.@type = 	"Asset09";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.midground.appendChild(object);
				}
				
				//==========================================
				//================Button01==================
				//==========================================
				if (refToStage.level1.getChildAt(i) is Button1) 
				{
					object.@type = 	"Button1";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.gui.button1.appendChild(object);
				}
				
				//==========================================
				//================Button02==================
				//==========================================
				else if (refToStage.level1.getChildAt(i) is Button2)
				{
					object.@type = 	"Button2";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.gui.button2.appendChild(object);
				}
				
				//==========================================
				//================Collision=================
				//==========================================
				else if (refToStage.level1.getChildAt(i) is CollisionBoundingBox)
				{
					object.@type = 	"CollisionBoundingBox";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					object.@width = refToStage.level1.getChildAt(i).width;
					object.@height = refToStage.level1.getChildAt(i).height;
					xmlFile.level_1.collision.appendChild(object);
				}
				
				//==========================================
				//==============Jump Trigger================
				//==========================================
				else if (refToStage.level1.getChildAt(i) is AiJumpTrigger)
				{
					object.@type = 	"AiJumpTrigger";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					object.@width = refToStage.level1.getChildAt(i).width;
					object.@height = refToStage.level1.getChildAt(i).height;
					xmlFile.level_1.jump_trigger.appendChild(object);
				}
				
				//==========================================
				//===============Stop Point=================
				//==========================================
				else if (refToStage.level1.getChildAt(i) is StoppingPoint)
				{
					object.@type = 	"StoppingPoint";
					object.@x = refToStage.level1.getChildAt(i).x;
					object.@y = refToStage.level1.getChildAt(i).y;
					xmlFile.level_1.stop_point.appendChild(object);
				}
				
								
			}
			
			//==========================================
			//===========LEVEL01 Foreground=============
			//==========================================
			for(i = 0;i<refToStage.level1_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				if (refToStage.level1_foreground.getChildAt(i) is Button1) 
				{
					object.@type = 	"Button1";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
					trace("found");
				}
				
				else if (refToStage.level1_foreground.getChildAt(i) is Button2)
				{
					object.@type = 	"Button2";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
					trace("found");
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset00) 
				{
					object.@type = 	"Asset00";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset01) 
				{
					object.@type = 	"Asset01";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset02) 
				{
					object.@type = 	"Asset02";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset03) 
				{
					object.@type = 	"Asset03";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset04) 
				{
					object.@type = 	"Asset04";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset05) 
				{
					object.@type = 	"Asset05";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset06) 
				{
					object.@type = 	"Asset06";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset07) 
				{
					object.@type = 	"Asset07";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset08) 
				{
					object.@type = 	"Asset08";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
				if (refToStage.level1_foreground.getChildAt(i) is Asset09) 
				{
					object.@type = 	"Asset09";
					object.@x = refToStage.level1_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_foreground.getChildAt(i).y;
					xmlFile.level_1.foreground.appendChild(object);
				}
				
			}
			
			//==========================================
			//===========LEVEL01 Background=============
			//==========================================
			for(i = 0;i<refToStage.level1_background.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				if (refToStage.level1_background.getChildAt(i) is Button1) 
				{
					object.@type = 	"Button1";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
					trace("found");
				}
				
				else if (refToStage.level1_background.getChildAt(i) is Button2)
				{
					object.@type = 	"Button2";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
					trace("found");
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset00) 
				{
					object.@type = 	"Asset00";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset01) 
				{
					object.@type = 	"Asset01";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset02) 
				{
					object.@type = 	"Asset02";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset03) 
				{
					object.@type = 	"Asset03";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset04) 
				{
					object.@type = 	"Asset04";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset05) 
				{
					object.@type = 	"Asset05";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset06) 
				{
					object.@type = 	"Asset06";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset07) 
				{
					object.@type = 	"Asset07";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset08) 
				{
					object.@type = 	"Asset08";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
				if (refToStage.level1_background.getChildAt(i) is Asset09) 
				{
					object.@type = 	"Asset09";
					object.@x = refToStage.level1_background.getChildAt(i).x;
					object.@y = refToStage.level1_background.getChildAt(i).y;
					xmlFile.level_1.background.appendChild(object);
				}
				
			}
			
			//==========================================
			//=====LEVEL01 Static Foreground============
			//==========================================
			for(i = 0;i<refToStage.level1_static_foreground.numChildren;i++)
			{
				object = 	<object>
							</object>
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Button1) 
				{
					object.@type = 	"Button1";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
					trace("found");
				}
				
				else if (refToStage.level1_static_foreground.getChildAt(i) is Button2)
				{
					object.@type = 	"Button2";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
					trace("found");
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset00) 
				{
					object.@type = 	"Asset00";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset01) 
				{
					object.@type = 	"Asset01";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset02) 
				{
					object.@type = 	"Asset02";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset03) 
				{
					object.@type = 	"Asset03";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset04) 
				{
					object.@type = 	"Asset04";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset05) 
				{
					object.@type = 	"Asset05";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset06) 
				{
					object.@type = 	"Asset06";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset07) 
				{
					object.@type = 	"Asset07";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset08) 
				{
					object.@type = 	"Asset08";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
				if (refToStage.level1_static_foreground.getChildAt(i) is Asset09) 
				{
					object.@type = 	"Asset09";
					object.@x = refToStage.level1_static_foreground.getChildAt(i).x;
					object.@y = refToStage.level1_static_foreground.getChildAt(i).y;
					xmlFile.level_1.static_foreground.appendChild(object);
				}
				
			}
			
			
			//trace(xmlFile);
			/*
			for(var i=0;i<MovieClip(root).test.numChildren;i++)
			{
				//if(container.getChildAt(i) is Pic) doSomething();
				if (MovieClip(root).test.getChildAt(i) is Button1) 
				{
					trace("Button1 object found in movieclip");
					var object:XML = 	<test>
										</test>
					object.@x = MovieClip(root).test.getChildAt(i).x;
					object.@y = MovieClip(root).test.getChildAt(i).y;
					xmlFile.button1.appendChild(object);
				}
				 //trace(MovieClip(root).test.getChildAt(i));
			}
			trace(xmlFile);
			*/
			//Save out the xml
			if (false)
			save();
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
		
		public function write()
		{
			
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