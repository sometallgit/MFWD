package
{
	import flash.display.MovieClip;
	import flash.utils.*;
	
	//The enemy class
	public class Enemy extends MovieClip
	{
		public var currentWeapon; //What weapon am I holding
		private var stopDistance:int; //How close should I get to Hitler before stopping
		
		private var moving:Boolean; //Am I moving
		public var animationState:String;
		public var directionFacing:String = "RIGHT";
		public var lastAnimationState:String;
		public var attackFinished:Boolean = true;
		public var animationBeforeAttack;
		
		public var stopTime:int = 0;
		public var currentTime;
		public var stopDuration:int = 2000;
		public var target; //Who am I chasing
		
		public var xVelocity:Number = 0;
		public var yVelocity:Number = 0;
		private var maxVelocity:Number = 16;
		private var xConst:Number = 0;
		private var yConst:Number = 0;
		private var gravity:Number = 0.2;
		public var grounded:Boolean = true;
		
		private var parentState;
		
		public function Enemy(state, _target)
		{
			target = _target;
			parentState = state;
			currentWeapon = new Weapon("RANDOM", false, this, parentState);
			addChild(currentWeapon);
			
			//Assign the stop distance based on which weapon the enemy is holding
			switch (currentWeapon.type)
			{
				case "KNIFE": 		stopDistance = 10;	break;
				case "GUN": 		stopDistance = 200;	break;
				case "GRENADE": 	stopDistance = 400;	break;
			}
			
			scaleX = 0.8;
			scaleY = 0.8;
			
			init();
		}
		
		public function init()
		{
			//Set spawn location just beyond the screen
			//TODO: Increase this range once the level is a decent size
			var r = int(Math.random()*2);
			y = 0;
			switch(r)
			{
				case 0: 
					x = -parentState.x - (width * 3) - 200;
				break;
				case 1:
					x = 800 + -parentState.x + (width * 2) + 200;
				break;
			}
		}
		
		public function update()
		{
			currentWeapon.update();
			
			//Turn to face the target (hitler)
			if (target.x > x) directionFacing = "RIGHT";
			if (target.x < x) directionFacing = "LEFT";
			
			//Make a B-Line to the target
			if (target.x > x + stopDistance)
			{
				setConstantForce(2,0);
				moving = true;
			}
			else if (target.x < x - stopDistance)
			{
				setConstantForce(-2,0);
				moving = true;
			}
			
			//In attacking range, stop
			else
			{
				setConstantForce(0,0);
				attack();
				moving = false;
			}

			currentTime = getTimer();
			updateMovement();
			updateCollisions()
			
			//If I get spawned outside the world, replace me
			if (y > 600) init();
			
			if (attackFinished) stateCheck();
		}
		
		private function stateCheck()
		{
			lastAnimationState = animationState;	
			
			//Set the animation state accordingly
			if (currentWeapon.type == "KNIFE")
			{
				if (moving && grounded && directionFacing == "LEFT") animationState = "L_WALKING_KNIFE";
				else if (!moving && directionFacing == "LEFT" && grounded) animationState = "L_IDLE_KNIFE";
				
				if (moving && grounded && directionFacing == "RIGHT") animationState = "R_WALKING_KNIFE";
				else if (!moving && directionFacing == "RIGHT" && grounded) animationState = "R_IDLE_KNIFE";
			}
			
			else if (currentWeapon.type == "GUN")
			{
				if (moving && grounded && directionFacing == "LEFT") animationState = "L_WALKING_RIFLE";
				else if (!moving && directionFacing == "LEFT" && grounded ) animationState = "L_IDLE_RIFLE";
				
				if (moving && grounded && directionFacing == "RIGHT") animationState = "R_WALKING_RIFLE";
				else if (!moving && directionFacing == "RIGHT" && grounded ) animationState = "R_IDLE_RIFLE";
			}
			
			else if (currentWeapon.type == "GRENADE")
			{
				if (moving && grounded && directionFacing == "LEFT") animationState = "L_WALKING_GRENADE";
				else if (!moving && directionFacing == "LEFT" && grounded ) animationState = "L_IDLE_GRENADE";
				
				if (moving && grounded && directionFacing == "RIGHT") animationState = "R_WALKING_GRENADE";
				else if (!moving && directionFacing == "RIGHT" && grounded ) animationState = "R_IDLE_GRENADE";
			}
			
			if (yVelocity > 3 && directionFacing == "LEFT") animationState = "L_FALL";
			else if (yVelocity > 3 && directionFacing == "RIGHT") animationState = "R_FALL";
			
			if (yVelocity < -3 && directionFacing == "LEFT") animationState = "L_JUMP";
			else if (yVelocity < -3 && directionFacing == "RIGHT") animationState = "R_JUMP";
			
			if (lastAnimationState != animationState)
			{
				//trace("ANIM STATE: " + animationState);
				gotoAndPlay(animationState);
			}
		}
		
		//Attack animations interrupt any other animations and will not allow a state change until the animation has finished
		private function startAttackAnimation()
		{
			animationBeforeAttack = animationState;

			if (currentWeapon.type == "KNIFE")
			{
				if (moving && directionFacing == "RIGHT") gotoAndPlay("R_ATTACK_KNIFE");
				if (moving && directionFacing == "LEFT") gotoAndPlay("L_ATTACK_KNIFE");
				
				if (!moving && directionFacing == "RIGHT") gotoAndPlay("R_ATTACK_KNIFE");
				if (!moving && directionFacing == "LEFT") gotoAndPlay("L_ATTACK_KNIFE");
			}
			
			else if (currentWeapon.type == "GUN")
			{
				if (moving && directionFacing == "RIGHT") gotoAndPlay("R_ATTACK_RIFLE");
				if (moving && directionFacing == "LEFT") gotoAndPlay("L_ATTACK_RIFLE");
				
				if (!moving && directionFacing == "RIGHT") gotoAndPlay("R_IDLE_ATTACK_RIFLE");
				if (!moving && directionFacing == "LEFT") gotoAndPlay("L_IDLE_ATTACK_RIFLE");
			}
			
			else if (currentWeapon.type == "GRENADE")
			{
				if (moving && directionFacing == "RIGHT") gotoAndPlay("R_ATTACK_GRENADE");
				if (moving && directionFacing == "LEFT") gotoAndPlay("L_ATTACK_GRENADE");
				
				if (!moving && directionFacing == "RIGHT") gotoAndPlay("R_ATTACK_GRENADE");
				if (!moving && directionFacing == "LEFT") gotoAndPlay("L_ATTACK_GRENADE");
			}
		}
		
		public function attack()
		{
			//TODO: Introduce a delay (wind up) to attacking for balancing
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
			
			//If the enemy starts to fall, set grounded to false
			if (yVelocity > 3) grounded = false;
		}
		
		private function updateCollisions()
		{
			var i:int = 0;
			//Check for walls
			for (i = 0; i < parentState.barrierArray.length; i++)
			{
				parentState.barrierArray[i].resolveCollisions(this);
			}
			//Check for jump triggers
			for (i = 0; i < parentState.jumpTriggerArray.length; i++)
			{
				parentState.jumpTriggerArray[i].resolveCollisions(this);
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
	}
}