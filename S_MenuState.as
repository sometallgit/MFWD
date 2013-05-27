package
{
	//TODO: Clean this up
	import flash.display.MovieClip;
	
	public class S_MenuState extends StateMachine
	{
		private var refToDocClass;
		private var startButton;
		private var helpButton;
		private var creditsButton;
		private var muteSoundButton;
		private var menuBackground;
		//private var testArray = new Array();
		
		public function S_MenuState(documentClass)
		{
			refToDocClass = documentClass;
			
			//Create GUI
			startButton = new GUIButton(refToDocClass, "ENTER_GAME", new ButtonStart());
			startButton.x = 562.65;
			startButton.startX = 562.65;
			startButton.y = 283.15;
			
			muteSoundButton = new GUIButton(refToDocClass, "MUTE_SOUNDS", new ButtonSound());
			muteSoundButton.x = 727.8;
			muteSoundButton.startX = 727.8;
			muteSoundButton.y = 14.6;
			
			helpButton = new GUIButton(refToDocClass, "ENTER_HELP", new ButtonHelp());
			helpButton.x = 561.65;
			helpButton.startX = 561.65;
			helpButton.y = 368.15;
			
			creditsButton = new GUIButton(refToDocClass, "ENTER_CREDITS", new ButtonCredits());
			creditsButton.x = 561.65;
			creditsButton.startX = 561.65;
			creditsButton.y = 447.65;
			
			//Create the background image for the menu state
			menuBackground = new TitleBackground();
			
			addChild(menuBackground);
			addChild(startButton);			
			addChild(muteSoundButton);
			addChild(helpButton);	
			addChild(creditsButton);	
			
		}
		
		//Update the buttons
		override public function update()
		{
			startButton.update(mouseIsPressed);
			muteSoundButton.update(mouseIsPressed);
			creditsButton.update(mouseIsPressed);
			helpButton.update(mouseIsPressed);
		}
		
		override public function keyPressed(key)
		{	
		}
		
		override public function keyReleased(key)
		{
		}
		
		//Tell the buttons when the gui registered a mouse down event
		override public function mousePressed()
		{
			startButton.mousePressed();
			muteSoundButton.mousePressed();
			creditsButton.mousePressed();
			helpButton.mousePressed();
		}
		
		/*
		override public function test()
		{
			//trace("overridden");
			//trace(refToDocClass);
		}
		*/
		/*
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
		}*/
		
		
	}
}