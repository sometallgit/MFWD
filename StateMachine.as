package
{
	import flash.display.MovieClip;
	
	public class StateMachine extends MovieClip
	{
		private var refToDocClass;
		public var mouseIsPressed:Boolean = false;
		
		
		public function StateMachine(documentClass = null)
		{
			//Give me a reference/pointer to the document class so I can access the variables and functions in the document class
			refToDocClass = documentClass;
		}
		
		public function update()
		{
		}
		
		public function endLevel()
		{
			trace("The current state has no endLevel() defined");
		}
		
		public function keyPressed(key)
		{
			
		}
		
		public function keyReleased(key)
		{
		
		}
		
		public function mousePressed()
		{
			mouseIsPressed = true;
		}
		
		public function mouseReleased()
		{
			mouseIsPressed = false;
		}
		
		public function test()
		{
			trace("parent");
			trace(refToDocClass);
		}
		
	}
}