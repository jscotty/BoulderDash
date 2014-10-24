package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Game.Game;
	import Menu.Menu;
	import PreLoader.PreLoader;
	
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Main extends Sprite 
	{
		public static var _stage:Stage;
		private var _mainMenu:Menu;
		private var _preLoader:PreLoader;
		private var _game:Game;
		
		public static var level:int = 2;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			_stage = stage;
			
			_preLoader = new PreLoader(stage);
			addChild(_preLoader);
			
			_preLoader.addEventListener("LoadDone",  openMenu); // voor snelle skip zet op menu anders op adds
			
		}
		private function openMenu(e:Event):void
		{
			removeChild(_preLoader);
			trace("Menu");
			
			_mainMenu = new Menu(stage);
			addChild(_mainMenu);
			
			_mainMenu.addEventListener("startGame", openGame);
		}
		
		private function openGame(e:Event):void
		{
			
			trace("Game");
			_game = new Game(stage);
			addChild(_game);
			
			
			_mainMenu.removeEventListener(KeyboardEvent.KEY_DOWN, _mainMenu.keyDown);
			_mainMenu.removeEventListener("startGame" , openGame);
			removeChild(_mainMenu);
			_mainMenu = null;
			
			
		}
		
	}
	
}