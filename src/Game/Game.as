package Game 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.net.getClassByAlias;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Game extends Sprite
	{
		private var _grid:Sprite;
		private var numColumns:Number = 22;
		private var numRows:Number = 40;
		private var cellHeight:Number = 34;
		private var cellWidth:Number = 34;
		
		private const dirt:uint = 0;
		private const wall:uint = 1;
		private const wall2:uint = 2;
		private const stone:uint = 3;
		private const diamond:uint = 4;
		private const player:uint = 5;
		
		private var _mapData:Array = [ //0 = dirt, 1 = wall, 2 = wall2 (same as wall but other texture), 3 = stones, 4 = diamonds, 5 = player, 6 = nothing
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
									[1,0,0,0,0,0,0,6,0,0,4,0,3,6,0,0,0,0,0,3,0,3,0,0,0,0,0,0,0,6,0,0,0,0,3,0,0,0,0,1],
									[1,0,3,5,3,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,3,4,0,0,3,0,0,0,0,6,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,6,0,0,3,0,0,0,0,0,3,0,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,1],
									[1,3,0,3,3,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,0,3,0,0,0,0,3,0,0,0,3,0,0,0,0,0,1],
									[1,3,0,6,3,0,0,0,0,0,0,0,0,0,6,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,3,0,1],
									[1,0,0,0,6,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,6,3,0,0,0,0,0,0,0,0,3,0,3,3,0,1],
									[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,3,0,0,3,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,3,4,0,0,0,0,0,0,6,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,6,3,0,0,3,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,6,0,0,3,0,0,3,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,6,0,4,0,0,0,0,3,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,4,0,0,0,0,0,0,0,0,0,3,0,0,4,0,6,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,3,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,3,1],
									[1,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];

		
									
		/*private var _map:Array;
			private var _stone:Stone;
			private var _wall:Wall;
			private var _wall2:Wall2;
			private var _diamond:Diamond;
			private var _dirt:Dirt;
			private var _player:Player;*/
			
		
		public function Game(s:Stage) 
		{
			_grid = new Sprite();
			_grid.graphics.clear();
			_grid.graphics.lineStyle(1, 0xffffff);
			
			//_player = new Player();
			
			/*_stone = new Stone();
			_wall = new Wall();
			_wall2 = new Wall2();
			_diamond = new Diamond();
			_dirt = new Dirt();*/
			
			
				//trace(_mapData);
        for (var row:Number = 0; row < numColumns; row++)
        {
            for (var col:Number = 0; col < numRows; col++)
            {
               // trace(col, row);
                _grid.graphics.moveTo(col * cellWidth, 0);
                _grid.graphics.lineTo(col * cellWidth, cellHeight * numRows);
                _grid.graphics.moveTo(0, row * cellHeight);
                _grid.graphics.lineTo(cellWidth * numColumns, row * cellHeight);
				addChild(_grid);
				_grid.y = 34;
				if (_mapData[row][col] == 0) 
				{
					var dirt = new Dirt();
					addChild(dirt);
					dirt.x = col * cellWidth  + 17;
					dirt.y = row * cellHeight  + 17 + 34;
					dirt.width = cellWidth;
					dirt.height = cellHeight;
				}
				if (_mapData[row][col] == 1) 
				{
					var wall = new Wall();
					addChild(wall);
					wall.x = col * cellWidth  + 17;
					wall.y = row * cellHeight + 17 + 34;
					wall.width = cellWidth;
					wall.height = cellHeight;
				}
				if (_mapData[row][col] == 2) 
				{
					var wall2 = new Wall2();
					addChild(wall2);
					wall2.x = col * cellWidth  + 17;
					wall2.y = row * cellHeight + 17 + 34;
					wall2.width = cellWidth;
					wall2.height = cellHeight;
				}
				if (_mapData[row][col] == 3) 
				{
					var stone = new Stone();
					addChild(stone);
					stone.x = col * cellWidth + 17;
					stone.y = row * cellHeight + 17 + 34;
					stone.width = cellWidth;
					stone.height = cellHeight;
				}
				if (_mapData[row][col] == 4) 
				{
					var diamond = new Diamond();
					addChild(diamond);
					diamond.x = col * cellWidth + 17;
					diamond.y = row * cellHeight + 17 + 34;
					diamond.width = cellWidth;
					diamond.height = cellHeight;
				}
				if (_mapData[row][col] == 5) 
				{
					var player = new Player();
					addChild(player);
					player.x = col * cellWidth + 17 ;
					player.y = row * cellHeight + 17 + 34;
					player.width = cellWidth;
					player.height = cellHeight;
				}
				
            }
        
			
		}
		
		
		/*_map = new Array(21);
			_map[0] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row1
			_map[1] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row2
			_map[2] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row3
			_map[3] = 	[_wall, _wall, _wall2, _player, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row4
			_map[4] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row5
			_map[5] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row6
			_map[6] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row7
			_map[7] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row8
			_map[8] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row9
			_map[9] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row10
			_map[10] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row11
			_map[11] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row12
			_map[12] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row13
			_map[13] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row14
			_map[14] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row15
			_map[15] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row16
			_map[16] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row17
			_map[17] =	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row18
			_map[18] =	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row19
			_map[19] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row20
			_map[20] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row21
			_map[21] = 	[_wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall, _wall]; //row22
			
			for ( var rows:int = 0; rows <= 21; rows++ )
			{
				for ( var column:int = 0; column <= 39; column++ )
				{
						addChild( _map[rows][column] );
						_map[rows][column].x = column * cellWidth + 34;
						_map[rows][column].y = rows * cellHeight - 34;
				} 
			}       */                                 // ik probeerde dit na uitleg van Jelle bij wiskunde, dit werkte niet het spawnde telkens 1 object. 
													//ik heb op stack overflow gevraagt hoe ik dit kon oplossen en kwam zo op de volgende oplossing
													// bedankt erwin
			
		}
	}

}