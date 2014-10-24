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
		
		private var _mapData2 = Game.Game.mapData2;
		private var _artTiles2 = Game.Game.artTiles2;
		
		private var row:int;
		private var col:int;
		
			private var numRows:int = 22;
			private var numColumns:int = 40;
			private var cool:Number = 0;
		
		public function StoneHandler() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			if (Main.level == 1) {
			
			//trace("hallo");
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
			
			} else if (Main.level == 2) {
				for (var k:int = 0; k < 5; k++){
			for (row = 0; row < numRows; row++)  // Grid
			{
				for (col = 0; col < numColumns; col++)
				{
					if (_mapData2[row][col] == 3) 
					{
						var count2:int = 1;
						while (checkNextRow(row+count,col) && count2 < _mapData2.length)
						{
							count2++;
							
						}						
						//trace(count);
					}
				}
			}
			}
			
			}
		}
		
		private function checkNextRow(nextrow:int, col:int):Boolean 
		{
			if (Main.level == 1){
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
				
			} else if (Main.level == 2) {
				if(nextrow < _mapData2.length){
					if (_mapData2[nextrow][col] == 6)
					{
						//trace("row: " +nextrow + " col: " + col + " 6 gevnden");
						_artTiles2[row][col].y += 34;
						_mapData2[row + 1][col] = 3;
						_mapData2[row][col] = 6;
						return true;			
					}
				}
				//trace("row: " +nextrow+" col: "+col+" 6 NIET gevnden");
				return false; 
			}
			return false; 
		}
		
	}

}