package Game 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.getClassByAlias;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import Game.Objects.Dirt;
	import Game.Player.Character;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author justin Bieshaar
	 */
	public class Game extends Sprite
	{
		private var _grid:Sprite;
		private var numColumns:Number = 40;
		private var numRows:Number = 22;
		private var cellHeight:Number = 34;
		private var cellWidth:Number = 34;
		
		private const dirt:uint = 0;
		private const wall:uint = 1;
		private const wall2:uint = 2;
		private const stone:uint = 3;
		private const diamond:uint = 4;
		private const player:uint = 5;
		
		private var row:Number;
		private var col:Number;
		
		public var mapData:Array = [ //0 = dirt, 1 = wall, 2 = wall2 (same as wall but other texture), 3 = stones, 4 = diamonds, 5 = player, 6 = nothing
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
									[1,0,0,0,0,0,0,6,0,0,4,0,3,6,0,0,0,0,0,3,0,3,0,0,0,0,0,0,0,6,0,0,0,0,3,0,0,0,0,1],
									[1,0,3,6,3,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,3,4,0,0,3,0,0,0,0,6,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,6,0,0,3,0,0,0,0,0,3,0,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,1],
									[1,3,0,3,3,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,0,3,0,0,0,0,3,0,0,0,3,0,0,0,0,0,1],
									[1,3,0,6,3,0,0,0,0,0,0,0,0,0,6,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,3,0,1],
									[1,0,0,0,6,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,6,3,0,0,0,0,0,0,0,0,3,0,3,3,0,1],
									[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,3,0,0,3,0,1],
									[1,0,6,0,0,0,3,0,0,4,6,0,0,3,6,3,0,0,0,0,0,0,0,0,0,0,0,4,0,3,4,0,0,0,0,0,0,6,0,1],
									[1,0,0,4,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,6,3,0,0,3,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,3,0,0,3,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,3,6,0,0,3,0,0,3,0,0,0,0,0,0,0,0,1],
									[1,0,3,0,0,0,0,0,3,0,0,0,0,0,0,0,3,3,3,0,0,0,0,0,0,0,0,3,0,0,6,0,4,0,0,0,0,3,0,1],
									[1,0,4,0,0,6,0,0,3,0,6,6,0,0,0,0,3,0,3,4,0,0,4,0,0,0,0,0,0,0,0,0,3,0,0,4,0,6,0,1],
									[1,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,6,3,0,0,3,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,3,1],
									[1,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1],
									[1,6,3,0,0,0,0,0,0,0,0,0,3,0,0,0,4,0,0,0,0,3,0,0,0,0,0,3,0,0,0,3,0,0,0,0,0,0,0,1],
									[1,6,3,0,0,0,0,0,0,0,0,0,6,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,3,0,0,0,1],
									[1,0,6,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,6,6,0,0,0,0,4,0,0,0,3,0,3,3,0,0,0,1],
									[1,0,0,0,0,3,4,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,3,0,0,0,1],
									[1,0,0,0,6,0,0,3,0,6,0,0,3,0,3,3,0,0,0,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,6,0,0,3,1],
									[1,0,4,0,0,0,0,6,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,6,0,3,0,0,3,0,0,0,0,3,0,0,0,3,0,1],
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];

		public var artTiles:Array = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
									[1,0,0,0,0,0,0,6,0,0,4,0,3,6,0,0,0,0,0,3,0,3,0,0,0,0,0,0,0,6,0,0,0,0,3,0,0,0,0,1],
									[1,0,3,6,3,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,3,4,0,0,3,0,0,0,0,6,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,0,0,0,0,0,6,0,0,3,0,0,0,0,0,3,0,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,1],
									[1,3,0,3,3,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,0,3,0,0,0,0,3,0,0,0,3,0,0,0,0,0,1],
									[1,3,0,6,3,0,0,0,0,0,0,0,0,0,6,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,3,0,1],
									[1,0,0,0,6,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,6,3,0,0,0,0,0,0,0,0,3,0,3,3,0,1],
									[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,3,0,0,3,0,1],
									[1,0,6,0,0,0,3,0,0,4,6,0,0,3,6,3,0,0,0,0,0,0,0,0,0,0,0,4,0,3,4,0,0,0,0,0,0,6,0,1],
									[1,0,0,4,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,6,3,0,0,3,0,0,0,0,0,0,0,0,1],
									[1,0,0,0,3,0,0,3,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,3,6,0,0,3,0,0,3,0,0,0,0,0,0,0,0,1],
									[1,0,3,0,0,0,0,0,3,0,0,0,0,0,0,0,3,3,3,0,0,0,0,0,0,0,0,3,0,0,6,0,4,0,0,0,0,3,0,1],
									[1,0,4,0,0,6,0,0,3,0,6,6,0,0,0,0,3,0,3,4,0,0,4,0,0,0,0,0,0,0,0,0,3,0,0,4,0,6,0,1],
									[1,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,6,3,0,0,3,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,3,1],
									[1,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1],
									[1,6,3,0,0,0,0,0,0,0,0,0,3,0,0,0,4,0,0,0,0,3,0,0,0,0,0,3,0,0,0,3,0,0,0,0,0,0,0,1],
									[1,6,3,0,0,0,0,0,0,0,0,0,6,3,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,3,0,0,0,1],
									[1,0,6,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,6,6,0,0,0,0,4,0,0,0,3,0,3,3,0,0,0,1],
									[1,0,0,0,0,3,4,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,3,0,0,0,1],
									[1,0,0,0,6,0,0,3,0,6,0,0,3,0,3,3,0,0,0,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,6,0,0,3,1],
									[1,0,4,0,0,0,0,6,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,6,0,3,0,0,3,0,0,0,0,3,0,0,0,3,0,1],
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];
									

		public var _player:Player;
		private var _dirt:Dirt;
		private var _wall:Wall;
		private var _wall2:Wall2;
		private var _stone:StoneBall;
		private var _diamond:Diamond;
		
		private var indexX:uint;
		private var indexY:uint;
		private var _movementX:int;
		private var _movementY:Number = 34;
		public var score:uint = 0;
		private var _zero:String = "0";
		
		private var _header:Header;
		
		private var  _diamondCounter:TextField;
		private var tf:TextFormat;
		
									
		/*private var _map:Array;
			private var _stone:Stone;
			private var _wall:Wall;
			private var _wall2:Wall2;
			private var _diamond:Diamond;
			private var _dirt:Dirt;
			private var _player:Player;*/
			
		
		public function Game(s:Stage) 
		{
			
			tf = new TextFormat("Commodore 64 Pixelized Regular", 34, 0xeff225, true); // variable voor de text style.
			//tf2 = new TextFormat("Commodore 64 Pixelized Regular", 34, 0xeff225, true); // variable voor de text style.
			
			_grid = new Sprite();
			_grid.graphics.clear();
			_grid.graphics.lineStyle(1, 0xffffff);
			
			
			
				//trace(mapData);
        for (row = 0; row < numRows; row++)  // Grid
        {
            for (col = 0; col < numColumns; col++)
            {
               // trace(col, row);
                _grid.graphics.moveTo(col * cellWidth, 0);
                _grid.graphics.lineTo(col * cellWidth, cellHeight * numRows);
                _grid.graphics.moveTo(0, row * cellHeight);
                _grid.graphics.lineTo(cellWidth * numColumns, row * cellHeight);
				addChild(_grid);
				_grid.y = 34;
				
				if (mapData[row][col] == 0) 
				{
					_dirt = new Dirt();
					artTiles[row][col] = _dirt;
					addChild(_dirt);
					_dirt.x = col * cellWidth  + 17 + _movementX;
					_dirt.y = row * cellHeight + 17 + _movementY;
					_dirt.width = cellWidth;
					_dirt.height = cellHeight;
				}
				else if (mapData[row][col] == 1) 
				{
					_wall = new Wall();
					artTiles[row][col] = _wall;
					addChild(_wall);
					_wall.x = col * cellWidth  + 17 + _movementX;
					_wall.y = row * cellHeight + 17 + _movementY;
					_wall.width = cellWidth;
					_wall.height = cellHeight;
				}
				else if (mapData[row][col] == 2) 
				{
					_wall2 = new Wall2();
					artTiles[row][col] = _wall2;
					addChild(_wall2);
					_wall2.x = col * cellWidth  + 17 + _movementX;
					_wall2.y = row * cellHeight + 17 + _movementY;
					_wall2.width = cellWidth;
					_wall2.height = cellHeight;
				}
				else if (mapData[row][col] == 3) 
				{
					_stone = new StoneBall();
					artTiles[row][col] = _stone;
					addChild(_stone);
					_stone.x = col * cellWidth + 17  + _movementX;
					_stone.y = row * cellHeight + 17 + _movementY;
					_stone.width = cellWidth;
					_stone.height = cellHeight;
				}
				else if (mapData[row][col] == 4) 
				{
					_diamond = new Diamond();
					artTiles[row][col] = _diamond;
					addChild(_diamond);
					_diamond.x = col * cellWidth + 17 + _movementX;
					_diamond.y = row * cellHeight + 17 + _movementY;
					_diamond.width = cellWidth;
					_diamond.height = cellHeight;
				}
				
            }
        
			
		}
			_player = new Player();
			_player.x = cellWidth * 3 + 17;
			_player.y = cellHeight * 3 + 17;
			_player.width = cellWidth;
			_player.height = cellHeight;
			addChild(_player);
			
			_header = new Header();
			addChild(_header);
			
			_diamondCounter = new TextField();
			addChild(_diamondCounter);
			_diamondCounter.text = "" + _zero + score;
			_diamondCounter.x = 10;
			_diamondCounter.width = _diamondCounter.textWidth + 50; // maximale grootte text
			_diamondCounter.setTextFormat(tf);
			
			_player.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			s.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
			s.addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 0, true);
			
			s.addEventListener(Event.ENTER_FRAME, camera, false, 0, true);
			
		}										

//////////////////////////////////////////////////////// UPDATE/LOOP \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

		private function update(e:Event):void 
		{
			
			trace(_movementY);
			
			indexX = Math.floor(_player.x / 34);
			indexY = Math.floor(_player.y / 34);
			
			if (score == 10) 
			{
				_zero = "";
			}
			//trace(indexX + " " + indexY);
			//trace(artTiles[indexY - 1][indexX]);
			//trace(mapData[indexY - 1][indexX]);
			
			if (mapData[indexY - 1][indexX] == 0)
			{
				removeChild(artTiles[indexY - 1][indexX]);
				mapData[indexY - 1][indexX] = 6;
			}
			if (mapData[indexY - 1][indexX] == 4)
			{
				removeChild(artTiles[indexY - 1][indexX]);
				mapData[indexY - 1][indexX] = 6;
				score += 1;
				trace(score);
				
				
				_diamondCounter.text = "" + _zero + score;
				_diamondCounter.x = 10; // text positie x
				_diamondCounter.setTextFormat(tf);
				//_header.gainedDaimonds.text = "" + score;
			}
			
			if (mapData[indexY - 1][indexX] == 1)
			{
				_player.y += 34;
			}
			
		}
		
//////////////////////////////////////////////////////// KEYBOARD EVENTS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

		
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37 || e.keyCode == 38 || e.keyCode == 39 || e.keyCode == 40) 
			{
				_player.y -= 0;
			}
			//trace("X " + _movementX + " - " + "Y " + _movementY);
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			//trace(e.keyCode); // up:38, down:40,right:39,left:37
			
			if (e.keyCode == 38) // KEY UP!
			{
				_player.y -= 34;
				_movementY -= 34;
				
				//movement();
				
			}
			if (e.keyCode == 40) // KEY DOWN!
			{
				_player.y += 34;
				_movementY += 34;
				//movement();
			}
			if (e.keyCode == 39) // KEY RIGHT!
			{
				_player.x += 34;
				_movementX += 34;
			}
			if (e.keyCode == 37) // KEY LEFT!
			{
				_player.x -= 34;
				_movementX -= 34;
			}
		}
		
		private function camera(e:Event):void
		{
			root.scrollRect = new Rectangle(_player.x - 119, _player.y - 119, stage.stageWidth, stage.stageHeight);
		
		}
		
	
		
	}

}

//////////////////////////////////////////////////////// ERRORS maar nieuwe oplossing  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

		
			/*_stone = new Stone();
			_wall = new Wall();
			_wall2 = new Wall2();
			_diamond = new Diamond();*/
			//artTiles = new Array();
			//_dirt = new Array;
		
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