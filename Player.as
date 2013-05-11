﻿package
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Player extends MovieClip
	{
		public var directionFacing:String = "RIGHT";
		public var animationState:String;
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
				
		public function Player(_x, _y, state)
		{
			trace("Player Created");
			
			x = _x;
			y = _y;
			parentState = state;
			
			currentWeapon = new Weapon("GRENADE", true, this, parentState);
			addChild(currentWeapon);

		}
		
		public function update()
		{
			updateMovement();
			updateCollisions()
			currentWeapon.update();
			
			stateCheck();
			
			
		}
		
		private function stateCheck()
		{
			if (yVelocity > 0 && directionFacing == "LEFT") animationState = "L_FALL";
			else if (yVelocity > 0 && directionFacing == "RIGHT") animationState = "R_FALL";
			
			if (isMovingLeft && grounded && parentState.hitler.isCarried == false) animationState = "L_WALKING";
			else if (directionFacing == "LEFT" && grounded && parentState.hitler.isCarried == false) animationState = "L_IDLE";
			
			if (isMovingLeft && grounded && parentState.hitler.isCarried == true) animationState = "L_WALKING_CARRY";
			else if (directionFacing == "LEFT" && grounded && parentState.hitler.isCarried == true) animationState = "L_IDLE_CARRY";
			
			if (isMovingRight && grounded && parentState.hitler.isCarried == true) animationState = "R_WALKING_CARRY";
			else if (directionFacing == "RIGHT" && grounded && parentState.hitler.isCarried == true) animationState = "R_IDLE_CARRY";
			
			//attacking idle
			//attacking moving
			//fall, jump carry
			
			if (isMovingRight && grounded && parentState.hitler.isCarried == false) animationState = "R_WALKING";
			else if (directionFacing == "RIGHT" && grounded && parentState.hitler.isCarried == false) animationState = "R_IDLE";
			
			if ((isMovingUp || yVelocity < 0) && directionFacing == "LEFT") animationState = "L_JUMP";
			else if ((isMovingUp || yVelocity < 0) && directionFacing == "RIGHT") animationState = "R_JUMP";
			
			
			MovieClip(root).debugText1.text = "PLAYER ANIM STATE: " + animationState;
		}
		
		public function attack()
		{
			currentWeapon.fire();
		}
		
		public function weaponDepleted()
		{
			removeChild(currentWeapon);
			currentWeapon = new Weapon("KNIFE", true, this, parentState);
			addChild(currentWeapon);
		}
		
		public function pickupWeapon()
		{
			for (var i:int = 0; i < parentState.droppedWeapons.length; i++)
			{
				if (parentState.droppedWeapons[i].alive)
				{
					if (this.hitTestObject(parentState.droppedWeapons[i])) 
					{
						parentState.droppedWeapons[i].alive = false;
						removeChild(currentWeapon);
						currentWeapon = new Weapon(parentState.droppedWeapons[i].type, true, this, parentState);
						addChild(currentWeapon);
						return;
					}
				}
			}
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
			y -= 50;
			for (var i = 0; i < parentState.barrierArray.length; i++)
			{
				parentState.barrierArray[i].resolveCollisions(this);
			}
			y += 50;
			
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