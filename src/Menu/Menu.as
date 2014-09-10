package Menu 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Menu extends Sprite 
	{
		
		private var _text:TextField;
		
		public function Menu(s:Stage) 
		{
			var tf:TextFormat = new TextFormat("Arial", 82, 0xffffff,true); // variable voor de text style.
			_text = new TextField();
			_text.text = "Menu";
			_text.y = 140; // text positie y
			_text.x = s.stageWidth / 2.5; // text positie x
			addChild(_text);
			_text.selectable = false;
			_text.width = _text.textWidth + 300; // maximale grootte text
			_text.setTextFormat(tf);
			_text.visible = true;
			
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, onHoover, false, 0, true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true); 
			
		}
		private function onClick(e:MouseEvent):void
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
		}
	}

}