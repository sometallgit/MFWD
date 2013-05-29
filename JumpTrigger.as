package
{
	import flash.geom.Point;
	
	public class JumpTrigger
	{
		public var x:Number;
		public var y:Number;
		public var width:Number; 
		public var height:Number;
		public function JumpTrigger(_x, _y, _width, _height)
		{
			x = _x;
			y = _y;
			width = _width;
			height = _height;
		}
		
		public function update()
		{
			
		}
		
		public function resolveCollisions(target)
		{
			
			if (target is Hitler || target is Player || target is Enemy)
			{
				var collision:Point = testAABB(
										x, (x + width), y, (y + height),
										target.x - (target.width / 2), (target.x + (target.width/2)), (target.y - (target.height/2)), (target.y + (target.height/2))
									 );
			}
			/*
			var collision:Point = testAABB(
										x, (x + width), y, (y + height),
										target.x, (target.x + target.width), target.y, (target.y + target.height)
									 );*/
			if(collision) 
			{
				target.yVelocity = -8;
				//target.x -= collision.x;
				//target.y -= collision.y;
				if(collision.y) 
				{
					//target.grounded = true;
					//target.yVelocity = 0.1;
				} 
				else 
				{
					//target.xVelocity = 0;
				}
				//collided = true;
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