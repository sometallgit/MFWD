package  
{
	
	import flash.display.MovieClip;
	
	
	public class HUD extends MovieClip 
	{
		public var parentState;
		public function HUD(_parent) 
		{
			x = 18;
			y = 14;
			parentState = _parent;
		}
		
		public function update()
		{
			healthBar.health.scaleX = parentState.hitler.health/100;
		}
	}
	
}
