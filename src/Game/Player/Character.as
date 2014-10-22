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
		//private var _player:Player;
		private var _playerIdle:PlayerIdle;
		private var _playerStart:PlayerStart;
		private var _playerMove:PlayerMove;
		
		public function Character() 
		{
			
			_playerIdle = new PlayerIdle();		// idle
			addChild(_playerIdle);
			
			_playerStart = new PlayerStart();	// start movement
			addChild(_playerStart);
			
			_playerMove = new PlayerMove();		// move
			addChild(_playerMove);
			
			_playerStart.visible = true;	// start movement
			_playerMove.visible = false;	// move
			_playerIdle.visible = false;	// idle
		}
		
		
		public function anim(animNr:int):void
		{
			if (animNr == 0) { 						// anim0 = start
				_playerIdle.visible = false;
				_playerStart.visible = true;
				_playerMove.visible = false;
				
				_playerIdle.stop();
				_playerMove.stop();
				_playerStart.play();
				
			}
			else if (animNr == 1) { 				// anim1 = idle
				_playerIdle.visible = true;
				_playerStart.visible = false;
				_playerMove.visible = false;
				
				_playerIdle.play();
				_playerMove.stop();
				_playerStart.stop();
				
			}
			else if (animNr == 2) { 				// anim2 = walking
				_playerIdle.visible = false;
				_playerStart.visible = false;
				_playerMove.visible = true;
				
				_playerIdle.stop();
				_playerMove.play();
				_playerStart.stop();
				
			}
		}
		
	}

}