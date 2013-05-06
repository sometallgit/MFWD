package  
{
	
	import flash.display.MovieClip;
	import flash.geom.*;
	
	public class StoppingPoint extends MovieClip 
	{
		public var type:String;
		
		public function StoppingPoint(_type = "flower") 
		{
			//x = _x;
			//y = _y;
			type = _type;
		}
		
		public function resolveCollisions(target)
		{
			var collision:Point = testAABB(
										x, (x + width), y, (y + height),
										target.x, (target.x + target.width), target.y, (target.y + target.height)
									 );
			if(collision) 
			{
				
				target.atStopPoint();
			}
			else
			{
				//collided = false;
				//target.grounded = false;
			}
		}
		
		//AABB collision pulled from the mario example
		function testAABB(xMin1, xMax1, yMin1, yMax1, xMin2, xMax2, yMin2, yMax2 ):Point 
		{
			if (xMax1 < xMin2 || yMax1 < yMin2 || xMin1 > xMax2 || yMin1 > yMax2) 
			{
				return null;
			} 
			else 
			{
				var xFix:Number = 0;
				var yFix:Number = 0;		
		
				if (xMin1 < xMin2) 
				{
					xFix = xMin2 - xMax1;
				} 
				else 
				{
					xFix = xMax2 - xMin1;			
				}			

				if (yMin1 < yMin2) 
				{
					yFix = yMin2 - yMax1;
				} 
				else 
				{
					yFix = yMax2 - yMin1;			
				}
		
				if (Math.abs(xFix) < Math.abs(yFix)) 
				{
					yFix = 0;
				} 
				else 
				{
					xFix = 0;
				}

				return new Point(xFix, yFix);
			}
		}
		
	}
	
}
