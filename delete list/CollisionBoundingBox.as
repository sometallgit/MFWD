package  
{
	import flash.display.MovieClip;
	
	public class CollisionBoundingBox extends MovieClip 
	{
		
		/////////////////////////////////////////////////////////////////////////////////
		////////////////			DEPRECATED - MARKED FOR DELETION	/////////////////
		/////////////////////////////////////////////////////////////////////////////////
		
		
		//Every bounding box object shares a static array
		//public static var collisionBoxArray:Array = new Array();
		
		public function CollisionBoundingBox() 
		{
			//Whenever a bounding box object is instantiated, it adds itself to the static array
			//The x,y,width and height properties of these movieclips can than be copied into to the trigger array,
			//allowing the world object to control them
			//collisionBoxArray.push(this);
			//Set to invisible as soon as it's instantiated
			//visible = false;
		}
	}
}