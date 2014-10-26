package Menu 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Menu extends Sprite 
	{
		
		private var _text:TextField;
		private var _background:MenuBG;
		private var _backgroundWall:BgMenuWall;
		
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		private var _border:Border;
		
		public function Menu(s:Stage) 
		{
			_sound = new Sound;
			_soundChannel = new SoundChannel;
			
			_sound.load(new URLRequest("theme.mp3"));
			_soundChannel = _sound.play(0, 99999);
			
			_backgroundWall = new BgMenuWall();
			addChild(_backgroundWall);
			
			_background = new MenuBG();
			addChild(_background);
			/*var tf:TextFormat = new TextFormat("Arial", 42, 
			0xffffff,true); // variable voor de text style.
			_text = new TextField();
			_text.text = "start";
			_text.y = 340; // text positie y
			_text.x = s.stageWidth / 3.5; // text positie x
			addChild(_text);
			_text.selectable = false;
			_text.width = _text.textWidth + 300; // maximale grootte text
			_text.setTextFormat(tf);
			_text.visible = true;*/
			
			s.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
			
			/*addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, onHoover, false, 0, true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true); */
			
			_border = new Border();
			_border.x = 0;
			_border.y = 1;
			addChild(_border);
			
		}										
		
		public function keyDown(e:KeyboardEvent):void
		{   
			dispatchEvent(new Event("startGame"));
			_soundChannel.stop();
		}
		
		/*private function onClick(e:MouseEvent):void
		{
			if (e.target == _text)
			{
				dispatchEvent(new Event("startGame"));
			}
		}
		
		private function onHoover(e:MouseEvent):void
		{
			if (e.target == _text)
			{
				_text.alpha = 0.7;
			}
		}
		private function onOut(e:MouseEvent):void
		{
			if (e.target == _text)
			{
				_text.alpha = 1;
			}
		}*/
	}

}