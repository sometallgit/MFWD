package  
{
	import flash.events.Event;

	import flash.net.*;	
	
	//The Newgrounds API
	import com.newgrounds.*;
	import com.newgrounds.components.*;
	
// parameters that could be added
//		retrigger : when called a 2nd time while already playing : restart (stops current), ignore (let current play), overlap (start multiple instances)
//		memory : resident (load at startup), demand (load when needed and keep), purge (on complete)
//		ignore delay (seconds) -- don't play again for x seconds

	public class Config
	{
		//initialise the newgrounds scorebrowser
		public static var scoreBrowser:ScoreBrowser = new ScoreBrowser();
		
		//Global flag for muting sounds
		public static var muteSounds:Boolean = false;
		public static var muteMusic:Boolean = false;
		//store the audio channel for the music so it can be stopped at any time
		public static var musicTracker;
		
		//The variables that the score is calculated with for level 1
		public static var enemiesKilledLevel1:int = 0;
		public static var completionTimeLevel1:int = 0;
		public static var hitlerHealthLevel1:int = 0;
		//The variables that the score is calculated with for level 2
		public static var enemiesKilledLevel2:int = 0;
		public static var completionTimeLevel2:int = 0;
		public static var hitlerHealthLevel2:int = 0;
		//The variables that the score is calculated with for level 3
		public static var enemiesKilledLevel3:int = 0;
		public static var completionTimeLevel3:int = 0;
		public static var hitlerHealthLevel3:int = 0;
		
		//Temporary variables that take the information from one of the level states and are copied to the variables above
		//TODO: No they're not. I don't think these are even used
		public static const enemyKilledPoint = 10;
		public static const timeScore = 1;
		public static const healthScore = 1;
		
		public static var totalScore:int = 0;
		
		//TODO: Check this is called
		public static function clear()
		{
			trace("CLEAR() HAS BEEN CALLED AND IS NOT A DUD FUNCTION");
			enemiesKilledLevel1 = 0;
			completionTimeLevel1 = 0;
			hitlerHealthLevel1 = 0;
			
			enemiesKilledLevel2 = 0;
			completionTimeLevel2 = 0;
			hitlerHealthLevel2 = 0;
			
			enemiesKilledLevel3 = 0;
			completionTimeLevel3 = 0;
			hitlerHealthLevel3 = 0;
			
			totalScore = 0;
		}
		
		public static function getScore(e, c, h, l:int)
		{
			//record the level states according to which level just ended
			switch(l)
			{
				case 1:
					enemiesKilledLevel1 = e;	
					completionTimeLevel1 = c;		
					hitlerHealthLevel1 = h;
				break;
				
				case 2:
					enemiesKilledLevel2 = e;
					completionTimeLevel2 = c;
					hitlerHealthLevel2 = h;
				break;
				
				case 3:
					enemiesKilledLevel3 = e;
					completionTimeLevel3 = c;
					hitlerHealthLevel3 = h;
				break;
				
				default:
					trace("Incorrect level number given in Config.getScore()");
				break;
			}
		}
		
		// public static, so it can be accessed from anywhere as "Audio.ready"
		// will become true when config and all resident sounds are loaded.  false until then.
		// the program should not start until ready is true.
		// Audio.play will be ignored until this is true.  (ensure background sound isn't started until this is true!)
		public static var ready : Boolean = false;
		
		// config holds configuration for the audio parameters
		// public static, so it can be accessed from anywhere as "Config.config"
		// NOTE this null until loaded
		public static var config : XML;
		
		// private static, "Config.instance" can be addressed by static functions within Config
		private static var instance : Config;
		
		// variable to hold the object that loads the xml data.
		// this object has a temporary life - long enough to load the XML data, before it is nulled out
		private var configLoader : URLLoader;
				
		
		// create the config manager object
		// this follows a "Singleton" pattern
		// object is created once & accessible globally in the program
		public static function init()
		{
			if (!instance) instance = new Config();
		}


		//
		// create an instance of our Config manager
		// it automatically loads config when created
		//
		public function Config() 
		{
			loadConfig();
		}
		

		// start the load of config data		
		private function loadConfig()
		{
			trace ("loading game config");
			configLoader = new URLLoader();
			configLoader.load(new URLRequest("data/config.xml"));
			configLoader.addEventListener(Event.COMPLETE, loadConfigDone);
		}

		
		// load is completed - 
		// NOTE - when running on a local PC, this will generally be instant
		// if loading from the internet, it may be numerious frames before this completes
		private function loadConfigDone(e :Event)
		{
			// import the loaded XML into our config variable for later reference
			trace ("GAME CONFIG LOADED vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
			config = new XML(e.target.data);
			trace (config);
			trace ("GAME CONFIG LOADED ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
			
			// and clean up the loader
			configLoader.removeEventListener(Event.COMPLETE, loadConfigDone);
			configLoader = null;
			ready = true;
		}
	}
}
