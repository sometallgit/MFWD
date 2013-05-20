package
{
	import flash.display.MovieClip;
	import flash.utils.*;
	import flash.geom.Point;
	
	public class Bullet extends MovieClip
	{
		//Grenade range ~ 600
		private var type:String; //KNIFE, GUN, GRENADE, RANDOM
		private var isPlayer:Boolean; //Did the bullet come from the player
		private var direction;
		private var isAlive:Boolean = true;
		private var parentState;
		
		//The knife is a short range bullet
		private const knifeRange:int = 75;
		private var removeKnifeRange;
		
		private var currentTime;
		private var expireTime;
		private const grenadeDieTime:int = 3000;
		
		public var xVelocity:Number = 0;
		public var yVelocity:Number = 0;
		private var maxVelocity:Number = 200;
		private var xConst:Number = 0;
		private var yConst:Number = 0;
		private var gravity:Number = 0.2;
		
		public function Bullet(startX, startY, _type, _isPlayer, _direction, _parentState)
		{
			type = _type;
			isPlayer = _isPlayer
			direction = _direction;
			parentState = _parentState;
			x = startX;
			y = startY;
			
			//Keep a note of how long the bullet has been alive for. This is needed for the grenade
			currentTime = getTimer();
			expireTime = currentTime + grenadeDieTime;
			
			//Set the range of the knife
			if (type == "KNIFE" && direction == "LEFT")
			{
				removeKnifeRange = x - knifeRange;
			}
			else if (type == "KNIFE" && direction == "RIGHT")
			{
				removeKnifeRange = x + knifeRange;
			}
			
			if (type == "GRENADE" && direction == "LEFT")
			{
				applyForce(-4, -10);
			}
			else if (type == "GRENADE" && direction == "RIGHT")
			{
				applyForce(4, -10);
			}
			
			//If the player was the one who used a weapon, play the sound globally
			if (isPlayer)
			{
				switch (type)
				{
					case "KNIFE": 		Audio.play("attack_knife", 4); 	break;
					case "GUN":			Audio.play("attack_gun"); 		break;
					case "GRENADE":		Audio.play("attack_grenade"); 	break;
				}
			}
			
			//Otherwise, play it dynamically
			else
			{
				var playerPoint = new Point(parentState.player.x, parentState.player.y);
				var sourcePoint = new Point(x, y);
				switch (type)
				{
					case "KNIFE": 		Audio.playDynamic("attack_knife", playerPoint, sourcePoint, 1600, 800, 4); 	break;
					case "GUN":			Audio.playDynamic("attack_gun", playerPoint, sourcePoint); 		break;
					case "GRENADE":		Audio.playDynamic("attack_grenade", playerPoint, sourcePoint); 	break;
				}
			}
			
		}
		
		//Update the bullets according to what they were fired from
		public function update()
		{
			currentTime = getTimer();
			if (isAlive)
			{
				switch(type)
				{
					case "KNIFE":	updateKnife(); 		break;
					case "GUN":		updateGun(); 		break;
					case "GRENADE":	updateGrenade();	break;
				}
			}
			else
			{
				visible = false;
			}
		}
		
		private function updateKnife()
		{
			if (direction == "RIGHT" && x < removeKnifeRange)
			{
				gravity = 0;
				setConstantForce(10, 0);
				updateMovement();
				checkForHit()
			}
			else if (direction == "LEFT" && x > removeKnifeRange)
			{
				gravity = 0;
				setConstantForce(-10, 0);
				updateMovement();
				checkForHit()
			}
			else
			{
				isAlive = false;
			}
		}
		
		private function updateGun()
		{
			if (direction == "RIGHT")
			{
				gravity = 0;
				setConstantForce(12, 0);
				updateMovement();
				checkForHit()
			}
			else if (direction == "LEFT")
			{
				gravity = 0;
				setConstantForce(-12, 0);
				updateMovement();
				checkForHit()
			}
		}
		
		private function updateGrenade()
		{
			if (currentTime > expireTime)
			{
				var playerPoint = new Point(parentState.player.x, parentState.player.y);
				var sourcePoint = new Point(x, y);
				Audio.playDynamic("grenade_explode", playerPoint, sourcePoint);
				isAlive = false;
				checkCollisionsGrenade();
			}
			if (direction == "RIGHT")
			{
				gravity = 0.2;
				//setConstantForce(5, -9);
				updateMovement();
				updateCollisions();
				checkForHit()
			}
			else if (direction == "LEFT")
			{
				gravity = 0.2;
				//setConstantForce(-5, -9);
				updateMovement();
				updateCollisions();
				checkForHit()
			}
		}
		
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
		
		private function checkForHit()
		{
			//If we came from the player, check only against the enemies
			if (isPlayer)
			{
				//If the weapon isn't a grenade, do a normal collision check
				if (type != "GRENADE")
				{
					//iterate through enemy array when it exists
					//if (x > parentState.enemy.x && x < parentState.enemy.x + parentState.enemy.width && y > parentState.enemy.y && y < parentState.enemy.y + parentState.enemy.height)
					for (var i:int = 0; i < parentState.enemies.length; i++)	
					{
						if (this.hitTestObject(parentState.enemies[i]))
						{
							parentState.enemiesKilled++;
							parentState.dropWep(i);
							parentState.removeChild(parentState.enemies[i]);
							parentState.enemies[i] = new Enemy(parentState, parentState.hitler);
							//parentState.addChild(parentState.enemy);
							parentState.addChildAt(parentState.enemies[i], parentState.getChildIndex(parentState.player));
							isAlive = false;
						}
					}
				}
				//Otherwise it's a special case
			}
			//Otherwise we came from an enemy, check only for hitler
			else
			{
				if (this.hitTestObject(parentState.hitler) && type != "GRENADE")
				{
					isAlive = false;
					parentState.hitler.hurt()
				}
			}
		}
		
		private function checkCollisionsGrenade()
		{
			//Stop annoying duplicate variable warning
			var point1:Point;
			var point2:Point
			var distance;
			
			if (isPlayer)
			{
				for (var i:int = 0; i < parentState.enemies.length; i++)	
				{
					point1 = new Point(x, y);
					point2 = new Point(parentState.enemies[i].x, parentState.enemies[i].y);
					distance =  Point.distance(point1, point2);
					if (distance < 200)
					{
						parentState.enemiesKilled++;
						parentState.dropWep(i);
						parentState.removeChild(parentState.enemies[i]);
						parentState.enemies[i] = new Enemy(parentState, parentState.hitler);
						//parentState.addChild(parentState.enemy);
						parentState.addChildAt(parentState.enemies[i], parentState.getChildIndex(parentState.player));
					}
				}
			}
			else
			{
				point1 = new Point(x, y);
				point2 = new Point(parentState.hitler.x, parentState.hitler.y);
				
				distance =  Point.distance(point1, point2);
				//Cap the distance to the max distance
				if (distance > 350) distance = 350;
				
				var damagePercent = 1 - (distance / 350);
				var damage = 20 * damagePercent;
				parentState.hitler.hurt(damage);
			}
			
		
		}
		
		private function updateCollisions()
		{
			for (var i = 0; i < parentState.barrierArray.length; i++)
			{
				parentState.barrierArray[i].resolveCollisionsGrenade(this);
			}
			
		}
	}
}