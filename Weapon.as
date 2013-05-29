package
{
	import flash.display.MovieClip;
	import flash.utils.*
	
	public class Weapon extends MovieClip
	{
		public var currentTime = 0;
		public var cooldownOverTime = 0;
		//The time between attacking depending on the weapon
		const knifeCooldown = 50;
		const gunCooldown = 1000;
		const grenadeCooldown = 1000;
		
		//The time between attacking for AI. They have to wait longer
		const knifeCooldownAi = 1500;
		const gunCooldownAi = 2000;
		const grenadeCooldownAi = 3000;
		
		//Ammo for each of the weapons - Knife is supposed to be infinite
		const knifeAmmo = 99999;
		const gunAmmo = 5;
		const grenadeAmmo = 1;
		
		public var type:String; //KNIFE, GUN, GRENADE, RANDOM
		public var isPlayer:Boolean;
		public var ammo;
		
		public var refToOwner;
		public var parentState;
		
		public function Weapon(_type, _isPlayer, _owner, _parentState)
		{

			type = _type;
			isPlayer = _isPlayer
			refToOwner = _owner;
			parentState = _parentState;
			//Set the gun type if random was a type
			if (type == "RANDOM")
			{
				var r = int(Math.random()*3);
				switch (r)
				{
					case 0:		type = "KNIFE";		break;
					case 1:		type = "GUN";		break;
					case 2:		type = "GRENADE";	break;
				}
			}
			//Set the ammo based on the weapon type
			switch (type)
			{
				case "KNIFE": 	ammo = knifeAmmo; break;
				case "GUN": 	ammo = gunAmmo; break;
				case "GRENADE": ammo = grenadeAmmo; break;
			}
		}
		
		public function update()
		{
			currentTime = getTimer();
			
			x = refToOwner.x + (refToOwner.width/2);
			y = refToOwner.y + (refToOwner.height/2);

			for (var i:int = 0; i < parentState.bullets.length; i++)
			{
				parentState.bullets[i].update();
			}
			
			if (ammo <= 0)
			{
				refToOwner.weaponDepleted();
			}
		}
		
		public function fire()
		{
			if (currentTime > cooldownOverTime)
			{
				parentState.bullets.push(new Bullet(parent.x, parent.y, type, isPlayer, refToOwner.directionFacing, parentState))
				parentState.addChildAt(parentState.bullets[parentState.bullets.length-1], parentState.getChildIndex(parentState.player));
				//Reset the cooldown
				if (isPlayer)
				{
					ammo--;
					switch (type)
					{
						case "KNIFE":	cooldownOverTime = currentTime + knifeCooldown;		break;
						case "GUN":		cooldownOverTime = currentTime + gunCooldown;		break;
						case "GRENADE":	cooldownOverTime = currentTime + grenadeCooldown; 	break;
					}
				}
				else
				{
					switch (type)
					{
						case "KNIFE":	cooldownOverTime = currentTime + knifeCooldownAi; 	break;
						case "GUN":		cooldownOverTime = currentTime + gunCooldownAi;		break;
						case "GRENADE":	cooldownOverTime = currentTime + grenadeCooldownAi;	break;
					}
				}
			}
		}				
	}
}