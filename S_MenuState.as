package
{
	
	import flash.display.MovieClip;
	
	public class S_MenuState extends StateMachine
	{
		private var refToDocClass;
		private var button;
		private var testArray = new Array();
		
		public function S_MenuState(documentClass)
		{
			refToDocClass = documentClass;
			
			//Create GUI
			button = new GUIButton(refToDocClass, "ENTER_GAME", new Button1());
			addChild(button);			
		}
		
		override public function update()
		{
			button.update(mouseIsPressed);
		}
		
		override public function keyPressed(key)
		{
			
		}
		
		override public function keyReleased(key)
		{
		
		}
		
		override public function mousePressed()
		{
			button.mousePressed();
		}
		
		override public function test()
		{
			//trace("overridden");
			//trace(refToDocClass);
		}
		
		public function buildFromXML()
		{
			//trace(refToDocClass.xmlManager.xmlFile.menu.test);
			//trace(refToDocClass.xmlManager.xmlFile.children().length());
			var item:XML;
			for each(item in refToDocClass.xmlManager.xmlFile.menu.gui.button1.object) 
			{ 
				create(item);
			}
			
			for each(item in refToDocClass.xmlManager.xmlFile.menu.gui.button2.object) 
			{ 
				create(item);
			}
			
			function create(xmlObject)
			{
				switch(xmlObject.@type.toString())
				{
					case "Button1":
						testArray.push(new Button1());
						testArray[testArray.length-1].x = xmlObject.@x;
						testArray[testArray.length-1].y = xmlObject.@y;
					break;
					case "Button2":
						testArray.push(new Button2());
						testArray[testArray.length-1].x = xmlObject.@x;
						testArray[testArray.length-1].y = xmlObject.@y;
					break;
					case "dog":
						trace("dog");
					break;
					default:
						trace("The type '" + xmlObject.@type.toString() + "' is not a recognised type. Add a definition for it.");
					break;
				}
				//trace(refToDocClass.xmlManager.xmlFile.menu.test.word.toString())
				//total += myXML.item.@quantity[pname] * myXML.item.price[pname]; 
			}
			
			for (var i = 0; i < testArray.length; i++)
			{
				addChild(testArray[i]);
			}
			//for (var i:int = 0; i < refToDocClass.xmlManager.xmlFile.menu.gui.button1.children().length(); i++)
			//{
				
				//trace(i);
			//}
		}
		
	}
}