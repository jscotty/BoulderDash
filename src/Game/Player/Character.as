package Game.Player 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Character extends MovieClip
	{
		public var player:Player;
		
		public function Character() 
		{
			
			player = new Player();
			addChild(player);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		private function keyUp(e:KeyboardEvent):void 
		{
			
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			trace(e.keyCode);
		}
		
		
		private function update(e:Event):void
		{
			
		}
		
	}

}