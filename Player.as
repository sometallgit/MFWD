package
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Player extends MovieClip
	{
		public var directionFacing:String = "RIGHT";
		public var animationState:String;
		public var lastAnimationState:String;
		public var attackFinished:Boolean = true;
		public var animationBeforeAttack;
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
			x = _x;
			y = _y;
			parentState = state;
			
			currentWeapon = new Weapon("GRENADE", true, this, parentState);
			addChild(currentWeapon);
			
			scaleX = 0.8;
			scaleY = 0.8;
		}
		
		public function update()
		{
			updateMovement();
			updateCollisions()
			currentWeapon.update();
			
			//Apply the appropriate animation to the player
			if (attackFinished) stateCheck();
		}
		
		private function stateCheck()
		{
			//Keep a track of what the last animation state was to stop the same animation constantly restarting
			lastAnimationState = animationState;
			
			if (yVelocity > 0 && directionFacing == "LEFT" && parentState.hitler.isCarried == false) animationState = "L_FALL";
			else if (yVelocity > 0 && directionFacing == "RIGHT" && parentState.hitler.isCarried == false) animationState = "R_FALL";
			
			if (yVelocity > 0 && directionFacing == "LEFT" && parentState.hitler.isCarried == true) animationState = "L_FALL_CARRY";
			else if (yVelocity > 0 && directionFacing == "RIGHT" && parentState.hitler.isCarried == true) animationState = "R_FALL_CARRY";
			
			if (isMovingLeft && grounded && parentState.hitler.isCarried == false) animationState = "L_WALKING";
			//else if (directionFacing == "LEFT" && grounded && parentState.hitler.isCarried == false) animationState = "L_IDLE";
			
			if (isMovingRight && grounded && parentState.hitler.isCarried == false) animationState = "R_WALKING";
			//else if (directionFacing == "RIGHT" && grounded && parentState.hitler.isCarried == false) animationState = "R_IDLE";
			
			if (isMovingLeft && grounded && parentState.hitler.isCarried == true) animationState = "L_WALKING_CARRY";
			else if (directionFacing == "LEFT" && grounded && parentState.hitler.isCarried == true) animationState = "L_IDLE_CARRY";
			
			if (isMovingRight && grounded && parentState.hitler.isCarried == true) animationState = "R_WALKING_CARRY";
			else if (directionFacing == "RIGHT" && grounded && parentState.hitler.isCarried == true) animationState = "R_IDLE_CARRY";
			
			//attacking idle
			//attacking moving
			//make attack set a flag
			//end of attack animation sets the flag back
			//animationState = "ATTACK";
			
			if ((isMovingUp || yVelocity < 0) && directionFacing == "LEFT" && parentState.hitler.isCarried == false) animationState = "L_JUMP";
			else if ((isMovingUp || yVelocity < 0) && directionFacing == "RIGHT" && parentState.hitler.isCarried == false) animationState = "R_JUMP";
			
			if ((isMovingUp || yVelocity < 0) && directionFacing == "LEFT" && parentState.hitler.isCarried == true) animationState = "L_JUMP_CARRY";
			else if ((isMovingUp || yVelocity < 0) && directionFacing == "RIGHT" && parentState.hitler.isCarried == true) animationState = "R_JUMP_CARRY";
			
			if (currentWeapon.type == "KNIFE")
			{
				if (isMovingLeft && grounded && parentState.hitler.isCarried == false) animationState = "L_WALKING_KNIFE";
				else if (directionFacing == "LEFT" && grounded && parentState.hitler.isCarried == false) animationState = "L_IDLE_KNIFE";
				
				if (isMovingRight && grounded && parentState.hitler.isCarried == false) animationState = "R_WALKING_KNIFE";
				else if (directionFacing == "RIGHT" && grounded && parentState.hitler.isCarried == false) animationState = "R_IDLE_KNIFE";
			}
			
			else if (currentWeapon.type == "GUN")
			{
				if (isMovingLeft && grounded && parentState.hitler.isCarried == false) animationState = "L_WALKING_RIFLE";
				else if (directionFacing == "LEFT" && grounded && parentState.hitler.isCarried == false) animationState = "L_IDLE_RIFLE";
				
				if (isMovingRight && grounded && parentState.hitler.isCarried == false) animationState = "R_WALKING_RIFLE";
				else if (directionFacing == "RIGHT" && grounded && parentState.hitler.isCarried == false) animationState = "R_IDLE_RIFLE";
			}
			
			else if (currentWeapon.type == "GRENADE")
			{
				if (isMovingLeft && grounded && parentState.hitler.isCarried == false) animationState = "L_WALKING_GRENADE";
				else if (directionFacing == "LEFT" && grounded && parentState.hitler.isCarried == false) animationState = "L_IDLE_GRENADE";
				
				if (isMovingRight && grounded && parentState.hitler.isCarried == false) animationState = "R_WALKING_GRENADE";
				else if (directionFacing == "RIGHT" && grounded && parentState.hitler.isCarried == false) animationState = "R_IDLE_GRENADE";
			}
			
			//MovieClip(root).debugText1.text = "PLAYER ANIM STATE: " + animationState;
			parentState.debugText1.text = "PLAYER ANIM STATE: " + animationState;
			parentState.debugText1.x = x - (parentState.debugText1.width/2);
			parentState.debugText1.y = y;
			
			parentState.debugText1.setTextFormat(parentState.debugFormat);
			//Only set the new animation if there was a change in the state
			if (lastAnimationState != animationState)
			{
				//trace ("animation change");
				gotoAndPlay(animationState);
			}
		}
		
		private function startAttackAnimation()
		{
			animationBeforeAttack = animationState;

			if (currentWeapon.type == "KNIFE")
			{
				if (isMovingRight && parentState.hitler.isCarried == false) gotoAndPlay("R_ATTACK_KNIFE");
				if (isMovingLeft && parentState.hitler.isCarried == false) gotoAndPlay("L_ATTACK_KNIFE");
				
				if (!isMovingRight && directionFacing == "RIGHT" && parentState.hitler.isCarried == false) gotoAndPlay("R_ATTACK_KNIFE");
				if (!isMovingLeft && directionFacing == "LEFT" && parentState.hitler.isCarried == false) gotoAndPlay("L_ATTACK_KNIFE");
			}
			
			else if (currentWeapon.type == "GUN")
			{
				if (isMovingRight && parentState.hitler.isCarried == false) gotoAndPlay("R_ATTACK_RIFLE");
				if (isMovingLeft && parentState.hitler.isCarried == false) gotoAndPlay("L_ATTACK_RIFLE");
				
				if (!isMovingRight && directionFacing == "RIGHT" && parentState.hitler.isCarried == false) gotoAndPlay("R_IDLE_ATTACK_RIFLE");
				if (!isMovingLeft && directionFacing == "LEFT" && parentState.hitler.isCarried == false) gotoAndPlay("L_IDLE_ATTACK_RIFLE");
			}
			
			else if (currentWeapon.type == "GRENADE")
			{
				if (isMovingRight && parentState.hitler.isCarried == false) gotoAndPlay("R_ATTACK_GRENADE");
				if (isMovingLeft && parentState.hitler.isCarried == false) gotoAndPlay("L_ATTACK_GRENADE");
				
				if (!isMovingRight && directionFacing == "RIGHT" && parentState.hitler.isCarried == false) gotoAndPlay("R_ATTACK_GRENADE");
				if (!isMovingLeft && directionFacing == "LEFT" && parentState.hitler.isCarried == false) gotoAndPlay("L_ATTACK_GRENADE");
			}
		}
		
		public function attack()
		{
			if (parentState.hitler.isCarried) return;
			currentWeapon.fire();
			
			//Override the current animation checking with an immediate attack animation and record what the animation was before the attack started
			//So it can be returned to after the attack finishes
			attackFinished = false;
			if (currentWeapon.ammo < 0)
			{
				attackFinished = true;
				stateCheck();
				return;
			}
			if (animationState != animationBeforeAttack && (currentWeapon.currentTime > currentWeapon.cooldownOverTime)) 
			{
				animationBeforeAttack = animationState;
				
			}
			startAttackAnimation();
		}
		
		//When the current weapon runs out of ammo, give the player a knife
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
			
			//If the player starts to fall, set grounded to false
			if (yVelocity > 3) grounded = false;
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
					Audio.play("jump", 3);
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