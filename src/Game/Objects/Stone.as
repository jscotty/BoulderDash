package Game.Objects 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Stone extends Sprite
	{
		private var _stone:StoneBall;
		
		public function Stone() 
		{
			_stone = new StoneBall();
			addChild(_stone);
		}
		
	}

}