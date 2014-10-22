package Game.Objects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Game.Game;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class StoneHandler extends Sprite
	{
		private var _mapData = Game.Game.mapData;
		private var _artTiles = Game.Game.artTiles;
		
		private var row:int;
		private var col:int;
		
		
		public function StoneHandler() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			
			var numRows:int = 22;
			var numColumns:int = 40;
			var cool:Number = 0;
			
			trace("hallo");
			/*_mapData = Game.Game.mapData;
			_artTiles = Game.Game.artTiles;*/
			for (var j:int = 0; j < 5; j++){
			for (row = 0; row < numRows; row++)  // Grid
			{
				for (col = 0; col < numColumns; col++)
				{
					if (_mapData[row][col] == 3) 
					{
						var count:int = 1;
						while (checkNextRow(row+count,col) && count < _mapData.length)
						{
							count++;
							
						}						
						//trace(count);
					}
				}
			}
			}
		}
		
		private function checkNextRow(nextrow:int, col:int):Boolean 
		{
			if(nextrow < _mapData.length){
				if (_mapData[nextrow][col] == 6)
				{
					//trace("row: " +nextrow + " col: " + col + " 6 gevnden");
					_artTiles[row][col].y += 34;
					_mapData[row + 1][col] = 3;
					_mapData[row][col] = 6;
					return true;			
				}
			}
		//	trace("row: " +nextrow+" col: "+col+" 6 NIET gevnden");
			return false; 
			
		}
		
	}

}