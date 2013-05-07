package
{
	import flash.display.MovieClip;
	import flash.utils.*;

	public class WeaponDropped extends MovieClip
	{
		public var clip;
		public var type;
		public var parentState;
		public var grounded:Boolean;
		
		public var currentTime = 0;
		public var killTime;
		public var lifeTime = 3000;
		
		public var alive:Boolean = true;
		
		public function WeaponDropped(_type, _parentState)
		{
			currentTime = getTimer();
			killTime = currentTime + lifeTime;
			parentState = _parentState;
			type = _type;
			x = parentState.enemy.x;
			y = parentState.enemy.y;
			switch(type)
			{
				case "GUN": clip = new Gun(); break;
				case "GRENADE": clip = new Grenade(); break;
			}
			addChild(clip);
		}
		public function update()
		{
			if (alive)
			{
				currentTime = getTimer()
				if (!grounded)
				{
					y+= 8;
					y -= 50;
					for (var i = 0; i < parentState.barrierArray.length; i++)
					{
						parentState.barrierArray[i].resolveCollisionsSimple(this);
					}
					y += 50;
				}
				
				if (currentTime > killTime)
				{
					alive = false;
					visible = false;
				}
				
			}
			else
			{
				visible = false;
			}
			
		}
	}
}