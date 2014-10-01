package Game.Objects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Dirt extends Sprite
	{
		public var dirt:Dirts;
		
		public function Dirt() 
		{
			dirt = new Dirts();
			addChild(dirt);
			
		}
		
		
	}

}