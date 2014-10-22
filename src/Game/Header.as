package Game 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Header extends Sprite
	{
		private var _diamonds:TextField;
		public var diamondsToGo:uint = 15;
		private var _game:Game;
		private var _diamond:Diamond2;
		private var _header:BlackHeader;
		
		public function Header() 
		{
			_header = new BlackHeader();
			_header.x = 0;
			_header.y = 0;
			_header.height = 34;
			addChild(_header);
			
			for (var i:int = 0; i < 3; i++){
			_diamond = new Diamond2();
			_diamond.x = 20 + i * 30;
			_diamond.y = 20;
			addChild(_diamond);
			}
			
			var tf:TextFormat = new TextFormat("Commodore 64 Pixelized Regular", 34, 0xffffff,true); // variable voor de text style.
			_diamonds = new TextField();
			_diamonds.text = "" + diamondsToGo;
			_diamonds.y = 0; // text positie y
			_diamonds.x = 102; // text positie x
			addChild(_diamonds);
			_diamonds.width = _diamonds.textWidth + 50; // maximale grootte text
			_diamonds.setTextFormat(tf);
		}
		
	}

}