package  
{
	import flash.events.Event;

	import flash.net.*;	

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.geom.Point;
	
// parameters that could be added
//		retrigger : when called a 2nd time while already playing : restart (stops current), ignore (let current play), overlap (start multiple instances)
//		memory : resident (load at startup), demand (load when needed and keep), purge (on complete)
//		ignore delay (seconds) -- don't play again for x seconds

	public class Audio
	{
		// public static, so it can be accessed from anywhere as "Audio.ready"
		// will become true when config and all resident sounds are loaded.  false until then.
		// the program should not start until ready is true.
		// Audio.play will be ignored until this is true.  (ensure background sound isn't started until this is true!)
		public static var ready : Boolean = false;
		
		// config holds configuration for the audio parameters
		// public static, so it can be accessed from anywhere as "Audio.config"
		// NOTE this null until loaded
		public static var config : XML;
		
		// private static, "Audio.instance" can be addressed by static functions within Audio
		private static var instance : Audio;
		
		// variable to hold the object that loads the xml data.
		// this object has a temporary life - long enough to load the XML data, before it is nulled out
		private var audioConfigLoader : URLLoader;

		// associative array - string name of sample is index, holds XML data for the sample
		private var sampleConfig : Array = new Array;
		
		// associative array - string name of sample is index, holds sound data object
		private var sampleAudio : Array = new Array;
		
		
		
		// create the audio manager object
		// this follows a "Singleton" pattern
		// audio object is created once & accessible globally in the program
		public static function init()
		{
			if (!instance) instance = new Audio();
		}

		
		public static function playSound(numVariations:int = 0)
		{
			var r = int(Math.random()*numVariations);
			
			//name += "_" + r; 
		}
		
		// create the audio manager object
		// this follows a "Singleton" pattern
		// audio object is created once & accessible globally in the program
		public static function play(name : String, numVariations = 0)
		{
			
			var r = int(Math.random()*numVariations);
			
			name = name + "_" + r;
			
			if (!instance) return;
			if (!instance.sampleConfig) return;
			if (!instance.sampleAudio) return;

			var sound = instance.sampleAudio[name];
			if (!sound) {trace "NO SOUND NAMED >>" + name + "<<"; return; }
			
			var volume : Number = instance.sampleConfig[name].volume;
			var repeats : int = (instance.sampleConfig[name].type == "loop") ? int.MAX_VALUE : 0;	// looping sound plays 2 billion times, otherwise once
			
			var startTime : Number = 0;
			var channel = sound.play(startTime, repeats, new SoundTransform(volume,0));
			return channel;
		}
		
		//Take a point to the player and the sound source, apply a falloff to the volume and pan the audio based on the distance and direction
		public static function playDynamic(name : String, player:Point, source:Point, maxVolumeDistance = 1600, maxPanDistance = 800, numVariations = 0)
		{
			
			var r = int(Math.random()*numVariations);
			
			name = name + "_" + r;
			
			if (!instance) return;
			if (!instance.sampleConfig) return;
			if (!instance.sampleAudio) return;

			var sound = instance.sampleAudio[name];
			if (!sound) {trace "NO SOUND NAMED >>" + name + "<<"; return; }
			
			var point1:Point = new Point(player.x, player.y);
			var point2:Point = new Point(source.x, source.y);
			var distance =  Point.distance(point1, point2);
			var volumeDistance = distance;
			if (volumeDistance > maxVolumeDistance) volumeDistance = maxVolumeDistance;
			var volume = 1 - (volumeDistance / maxVolumeDistance);
			trace("Volume: " + volume);
			//trace(volume);
			if (point1.x > point2.x) distance = -distance;
			var pan = distance / maxPanDistance;
			trace ("Pan: " +pan);
			
			volume *= instance.sampleConfig[name].volume;
			var repeats : int = (instance.sampleConfig[name].type == "loop") ? int.MAX_VALUE : 0;	// looping sound plays 2 billion times, otherwise once
			
			var startTime : Number = 0;
			var channel = sound.play(startTime, repeats, new SoundTransform(volume,pan));
			return channel;
		}

		// will stop a sound channel returned from play function
		public static function stop(channel : SoundChannel)
		{
			if (channel == null) return;
			channel.stop();
		}

		
		//
		// create an instance of our Audio manager
		// it automatically loads config when created
		// and automatically loads resident (generally small) sound effects - e.g. weapon fire and explosions.
		// large sounds (e.g. background music) should be loaded by the levels / screens that use them
		//
		public function Audio() 
		{
			loadAudioConfig();
		}
		

		// start the load of config data		
		private function loadAudioConfig()
		{
			trace ("loading audio config");
			audioConfigLoader = new URLLoader();
			audioConfigLoader.load(new URLRequest("data/audio.xml"));
			audioConfigLoader.addEventListener(Event.COMPLETE, loadAudioConfigDone);
		}

		
		// load is completed - 
		// NOTE - when running on a local PC, this will generally be instant
		// if loading from the internet, it may be numerious frames before this completes
		// so it's important to check Audio.configXML is not null before attempting to use it
		// (shouldn't really start the main menu until it is loaded)
		private function loadAudioConfigDone(e :Event)
		{
			// import the loaded XML into our config variable for later reference
			trace ("AUDIO CONFIG LOADED vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
			config = new XML(e.target.data);
			trace (config);
			trace ("AUDIO CONFIG LOADED ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
			
			// and clean up the loader
			audioConfigLoader.removeEventListener(Event.COMPLETE, loadAudioConfigDone);
			audioConfigLoader = null;
			
			// now load resident sounds
			loadResidentAudio();
		}


		// any audio files listed as resident in the config file should be loaded immediately
		private function loadResidentAudio()
		{
			// record all sample info
			for (var i : int = 0; i < config.samples.sample.length(); ++i)
			{
				var thisSample = config.samples.sample[i];	// pointer into the xml fragment for neater code
				sampleConfig[thisSample.name] = thisSample;
			}


			// now load the actual samples (where desired)
			for (var key in sampleConfig)
			{
				trace (key + "  :: " + sampleConfig[key].file + " VOL:" + sampleConfig[key].volume);
				var path = "data/audio/" + sampleConfig[key].file;
				var sound = new Sound();
				loadSoundFromFile(sound, path);
				sampleAudio[key] = sound;	// NB, it's still loading, but it will load to here
			}
			
			// audio system is ready now (strictly shouldn't do this until all are loaded, but flash will play when load finishes)
			ready = true;
		}
		
		

		//
		//
		// Loading sound from a file
		//
		//
		
		private static function loadSoundFromFile(sound : Object, path : String)
		{
			sound.load(new URLRequest(path));
			sound.addEventListener(Event.COMPLETE, soundLoaded);
		}

		private static function soundLoaded(e : Event)
		{
			e.target.removeEventListener(Event.COMPLETE, soundLoaded);
		}
		
	}
}
