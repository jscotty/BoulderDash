package PreLoader 
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
	public class PreLoader extends Sprite
	{
		
		private var _total:Number;
		private var _loaded:Number;
		private var _precentage:Number;
		private var _fadeCounter:Number = 0;
		
		private var _text:TextField;
		
		public function PreLoader(s:Stage) 
		{
			addEventListener(Event.ENTER_FRAME, loader, false, 0, true);
			
		}
		public function loader(e:Event):void
		{
			trace("Loading...");
			var tf:TextFormat = new TextFormat("Papyrus", 82, 0xFFFFFFFF,true); // variable voor de text style.
			_text = new TextField();
			_text.text = "Loading...";
			_text.y = 640; // text positie y
			_text.x = stage.stageWidth / 2.5; // text positie x
			addChild(_text);
			_text.selectable = false;
			_text.width = _text.textWidth + 300; // maximale grootte text
			_text.setTextFormat(tf);
			_text.visible = true;
			
			
			_total = this.loaderInfo.bytesTotal;
			_loaded = this.loaderInfo.bytesLoaded;
			_precentage = _loaded / _total;
			
			_precentage = Math.floor(_precentage * 100);
			
			if (_precentage <= 100) 
			{
						dispatchEvent(new Event("LoadDone"));
						removeEventListener(Event.ENTER_FRAME, loader);
			}
		}
		
	}

}