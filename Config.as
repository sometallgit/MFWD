﻿package  
{
	import flash.events.Event;

	import flash.net.*;	
	
// parameters that could be added
//		retrigger : when called a 2nd time while already playing : restart (stops current), ignore (let current play), overlap (start multiple instances)
//		memory : resident (load at startup), demand (load when needed and keep), purge (on complete)
//		ignore delay (seconds) -- don't play again for x seconds

	public class Config
	{
		public static var enemiesKilled:int = 0;
		public static var completionTime:int = 0;
		public static var hitlerHealth:int = 0;
		
		public static const enemyKilledPoint = 10;
		public static const timeScore = 1;
		public static const healthScore = 1;
		
		public static function clear()
		{
			enemiesKilled = 0;
			completionTime = 0;
			hitlerHealth = 0;
		}
		
		public static function getScore(e, c, h)
		{
			enemiesKilled = e;
			completionTime = c;
			hitlerHealth = h;
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
