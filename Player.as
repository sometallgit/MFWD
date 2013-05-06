package
{
	import flash.display.MovieClip;
	
	public class Player extends MovieClip
	{
		public var directionFacing:String = "RIGHT";
		public var currentWeapon;
		
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
		
		/*
		//For scrolling
		public var xOffset;
		public var yOffset;
		private var startX;
		private var startY;
		*/
		
		public function Player(_x, _y, state)
		{
			trace("Player Created");
			
			x = _x;
			y = _y;
			parentState = state;
			
			currentWeapon = new Weapon("RANDOM", true, this, parentState);
			addChild(currentWeapon);
			/*
			xOffset = 0;
			yOffset = 0;
			startX = 0;
			startY = 0;
			*/
		}
		
		public function update()
		{
			updateMovement();
			updateCollisions()
			currentWeapon.update();
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
			for (var i = 0; i < parentState.barrierArray.length; i++)
			{
				parentState.barrierArray[i].resolveCollisions(this);
			}
			
		}
		
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
					directionFacing = "LEFT";
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
					directionFacing = "RIGHT";
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