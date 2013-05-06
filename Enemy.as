package
{
	import flash.display.MovieClip;
	import flash.utils.*;
	
	public class Enemy extends MovieClip
	{

		public var currentWeapon;
		private var stopDistance:int;
		
		public var directionFacing:String = "RIGHT";
		public var stopTime:int = 0;
		public var currentTime;
		public var stopDuration:int = 2000;
		public var target;
		
		public var xVelocity:Number = 0;
		public var yVelocity:Number = 0;
		private var maxVelocity:Number = 16;
		private var xConst:Number = 0;
		private var yConst:Number = 0;
		private var gravity:Number = 0.2;
		public var grounded:Boolean = true;
		
		private var parentState;
		
		//Has a movement key been pressed/released?
		private var isMovingUp:Boolean = false;
		private var isMovingDown:Boolean = false;
		private var isMovingLeft:Boolean = false;
		private var isMovingRight:Boolean = false;
		
		//For scrolling
		//public var xOffset;
		//public var yOffset;
		//private var startX;
		//private var startY;
		
		public function Enemy(_x, _y, state, _target)
		{
			trace("Enemy Created");
			
			target = _target;
			x = _x;
			y = _y;
			parentState = state;
			
			currentWeapon = new Weapon("RANDOM", false, this, parentState);
			addChild(currentWeapon);
			
			switch (currentWeapon.type)
			{
				case "KNIFE": 		stopDistance = 10;	break;
				case "GUN": 		stopDistance = 400;	break;
				case "GRENADE": 	stopDistance = 600;	break;
			}
			
			//xOffset = 0;
			//yOffset = 0;
			//startX = 0;
			//startY = 0;
			
			
		}
		
		public function init()
		{
			//Manually called constructor after the XML is successfully loaded
			//parentState.stoppingPointArray[currentTarget];
		}
		
		public function update()
		{
			currentWeapon.update();
			//if (currentTime > stopTime)
			//{
				if (target.x > x) directionFacing = "RIGHT";
				if (target.x < x) directionFacing = "LEFT";
				
				if (target.x > x + stopDistance)
				{
					setConstantForce(2,0);
					
				}
				else if (target.x < x - stopDistance)
				{
					
					setConstantForce(-2,0);
					
				}
				
				else
				{
					setConstantForce(0,0);
					attack();
				}
			//}
			//else
			//{
				//setConstantForce(0,0);
			//}
			currentTime = getTimer();
			//trace(currentTime);
			updateMovement();
			updateCollisions()
			
			
		}
		

		public function attack()
		{
			currentWeapon.fire();
		}
		
		//Basically the same as the mario code
		private function updateMovement()
		{
			var tempVelocity:Number = 0;
		
			if(Math.abs(xVelocity) > maxVelocity) 
			{
				tempVelocity = xVelocity;
				xVelocity = maxVelocity;
				if(tempVelocity < 0) 
				{
					xVelocity = -xVelocity;
				}
			}
			
			if(Math.abs(yVelocity) > maxVelocity) 
			{
				tempVelocity = yVelocity;
				yVelocity = maxVelocity;
				if(tempVelocity < 0) 
				{
					yVelocity = -yVelocity;
				}
			}
	
			x += xVelocity + xConst;
			y += yVelocity + yConst;
			
			applyForce(0, gravity);
		}
		
		private function updateCollisions()
		{
			var i:int = 0;
			for (i = 0; i < parentState.barrierArray.length; i++)
			{
				parentState.barrierArray[i].resolveCollisions(this);
			}
			
			for (i = 0; i < parentState.jumpTriggerArray.length; i++)
			{
				parentState.jumpTriggerArray[i].resolveCollisions(this);
			}
			
			//parentState.stoppingPointArray[currentTarget].resolveCollisions(this);
			
		}
		
		/*public function atStopPoint()
		{
			//trace("collision");
			stopTime = currentTime + stopDuration;
			//trace(stopTime);
			
			//trace(parentState.stoppingPointArray[currentTarget].x)
			if (currentTarget == parentState.stoppingPointArray.length -1)
			{
				currentTarget = 0;
			}
			else
			{
				currentTarget++;
			}
			
		}*/
		
		public function resetYVelocity()
		{
			yVelocity = 0;
		}
		
		public function applyForce(aX:Number, aY:Number) 
		{
			xVelocity += aX;
			yVelocity += aY;
		}
		
		public function setConstantForce(aX:Number, aY:Number) 
		{
			xConst = aX;
			yConst = aY;
		}
		
		public function applyConstantForce(aX:Number, aY:Number) 
		{
			xConst += aX;
			yConst += aY;
		}
		
		public function startMovingUp()		
		{

			if (!isMovingUp && grounded)
				{					
					grounded = false;
					isMovingUp 	= true; 
					applyForce(0, -8.5);
				}
		}
		public function startMovingDown() 	{isMovingDown 	= true;}		
		
		public function startMovingLeft() 	
		{

			if (!isMovingLeft)
				{
					//removeChild(playerClip);
					//playerClip = new Player_RunningL();
					//addChild(playerClip);
					isMovingLeft 	= true; 
					applyConstantForce(-6,0);
				}
		}		
		
		public function startMovingRight()	
		{
			if (!isMovingRight)
				{
					//removeChild(playerClip);
					//playerClip = new Player_Running();
					//addChild(playerClip);
					isMovingRight 	= true; 
					applyConstantForce(6,0);
				}
		}
		
		public function stopMovingUp()		{isMovingUp 	= false;}
		public function stopMovingDown() 	{isMovingDown 	= false;}		
		public function stopMovingLeft() 	
		{
			isMovingLeft 	= false; xConst = 0;
			//removeChild(playerClip);
			//playerClip = new PlayerL();
			//addChild(playerClip);
		}
		
		public function stopMovingRight() 	
		{
			isMovingRight 	= false; xConst = 0;
			//removeChild(playerClip);
			//playerClip = new Player();
			//addChild(playerClip);
		}
		
	}
}