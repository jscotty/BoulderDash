package Game.Objects 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Dirt extends Sprite
	{
		public var dirt:MovieClip;
		
		public function Dirt() 
		{
			if(Main.level == 1){
			dirt = new Dirts();
			addChild(dirt);
			
			}else if (Main.level == 2) {
			dirt = new Dirts2();
			addChild(dirt);
				
			}
			
			
		}
		
		
	}

}