package Game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.getClassByAlias;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import Game.Objects.Dirt;
	import Game.Objects.Stone;
	import Game.Objects.StoneHandler;
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
		
		public static var mapData:Array = [ //0 = dirt, 1 = wall, 2 = wall2 (same as wall but other texture), 3 = stones, 4 = diamonds, 5 = player, 6 = nothing, 7 end
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
									[1,0,6,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,6,6,0,0,0,0,4,0,0,0,3,0,3,3,0,0,7,1],
									[1,0,0,0,0,3,4,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,3,0,0,0,1],
									[1,0,0,0,6,0,0,3,0,6,0,0,3,0,3,3,0,0,0,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,6,0,0,3,1],
									[1,0,4,0,0,0,0,6,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,6,0,3,0,0,3,0,0,0,0,3,0,0,0,3,0,1],
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];

		public static var artTiles:Array = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
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
									[1,0,6,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,3,0,6,6,0,0,0,0,4,0,0,0,3,0,3,3,0,0,7,1],
									[1,0,0,0,0,3,4,0,0,3,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,3,0,0,0,1],
									[1,0,0,0,6,0,0,3,0,6,0,0,3,0,3,3,0,0,0,0,0,0,0,0,0,3,0,3,4,0,0,0,0,0,0,6,0,0,3,1],
									[1,0,4,0,0,0,0,6,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,6,0,3,0,0,3,0,0,0,0,3,0,0,0,3,0,1],
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];
									
		public static var mapData2:Array = [ //0 = dirt, 1 = wall, 2 = wall2 (same as wall but other texture), 3 = stones, 4 = diamonds, 5 = player, 6 = nothing, 7 end, 8 enemie
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
									[1,0,3,0,0,3,0,0,2,0,3,0,0,0,4,0,2,0,0,0,6,0,3,0,2,3,0,0,0,0,0,0,2,0,0,3,3,0,0,1],
									[1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,3,2,3,3,0,6,0,0,0,2,6,0,0,4,0,0,0,2,0,0,0,0,3,0,1],
									[1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1],
									[1,4,0,0,0,0,0,0,2,0,3,0,0,0,0,3,2,0,3,0,6,0,0,6,2,0,0,3,0,0,4,0,2,0,0,3,0,3,0,1],
									[1,0,0,0,0,0,0,0,2,0,3,0,0,0,0,3,2,0,3,0,6,3,0,0,2,0,0,0,0,0,3,0,2,0,0,0,6,0,0,1],
									[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,6,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1],
									[1,0,0,0,0,3,3,0,2,0,0,3,0,0,0,0,2,0,0,0,6,0,0,3,2,0,0,0,0,3,0,0,2,0,0,0,0,0,3,1],
									[1,0,0,0,0,0,0,0,2,0,0,6,0,0,0,0,2,0,0,0,6,0,0,0,2,0,0,0,0,3,0,6,2,0,0,0,0,0,3,1],
									[1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1],
									[1,3,0,0,3,0,0,0,2,0,0,0,0,3,0,0,2,0,0,3,6,0,0,0,2,0,0,0,0,0,0,4,2,3,0,0,0,0,0,1],
									[1,3,0,0,0,0,3,0,2,0,0,3,0,0,3,0,2,0,0,0,6,0,6,3,2,0,0,0,0,0,0,0,2,3,0,0,0,3,0,1],
									[1,0,3,0,0,0,0,0,2,0,0,0,3,0,0,0,2,0,0,0,6,0,6,3,2,0,0,0,0,0,0,0,2,6,3,0,0,3,0,1],
									[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,6,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1],
									[1,3,0,6,6,8,0,0,2,0,0,0,0,3,0,3,2,0,0,0,6,0,0,0,2,0,3,4,0,0,3,0,2,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,3,0,2,3,0,0,0,0,0,0,2,0,0,4,6,0,0,0,2,6,0,0,3,0,0,0,2,0,3,0,3,3,0,1],
									[1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1],
									[1,4,0,0,6,0,3,0,2,3,0,0,0,0,3,0,2,0,3,0,6,0,0,3,2,0,3,0,3,0,0,0,2,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,3,0,2,3,0,0,4,0,0,0,2,0,0,0,6,3,0,0,2,0,0,3,0,0,0,0,2,0,0,0,3,3,6,1],
									[1,0,4,0,0,0,6,3,2,0,0,3,0,0,0,0,2,0,5,4,6,3,0,0,2,0,6,0,0,0,0,0,2,0,0,0,3,3,6,1],
									[1,0,3,0,0,0,0,6,2,0,0,2,0,0,3,0,2,0,7,0,6,0,0,0,2,0,0,0,0,3,0,3,2,0,0,0,0,6,3,1],
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];
									
		public static var artTiles2:Array = [ //0 = dirt, 1 = wall, 2 = wall2 (same as wall but other texture), 3 = stones, 4 = diamonds, 5 = player, 6 = nothing
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
									[1,0,3,0,0,3,0,0,2,0,3,0,0,0,4,0,2,0,0,0,6,0,3,0,2,3,0,0,0,0,0,0,2,0,0,3,3,0,0,1],
									[1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,3,2,3,3,0,6,0,0,0,2,6,0,0,4,0,0,0,2,0,0,0,0,3,0,1],
									[1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1],
									[1,4,0,0,0,0,0,0,2,0,3,0,0,0,0,3,2,0,3,0,6,0,0,6,2,0,0,3,0,0,4,0,2,0,0,3,0,3,0,1],
									[1,0,0,0,0,0,0,0,2,0,3,0,0,0,0,3,2,0,3,0,6,3,0,0,2,0,0,0,0,0,3,0,2,0,0,0,6,0,0,1],
									[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,6,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1],
									[1,0,0,0,0,3,3,0,2,0,0,3,0,0,0,0,2,0,0,0,6,0,0,3,2,0,0,0,0,3,0,0,2,0,0,0,0,0,3,1],
									[1,0,0,0,0,0,0,0,2,0,0,6,0,0,0,0,2,0,0,0,6,0,0,0,2,0,0,0,0,3,0,6,2,0,0,0,0,0,3,1],
									[1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1],
									[1,3,0,0,3,0,0,0,2,0,0,0,0,3,0,0,2,0,0,3,6,0,0,0,2,0,0,0,0,0,0,4,2,3,0,0,0,0,0,1],
									[1,3,0,0,0,0,3,0,2,0,0,3,0,0,3,0,2,0,0,0,6,0,6,3,2,0,0,0,0,0,0,0,2,3,0,0,0,3,0,1],
									[1,0,3,0,0,0,0,0,2,0,0,0,3,0,0,0,2,0,0,0,6,0,6,3,2,0,0,0,0,0,0,0,2,6,3,0,0,3,0,1],
									[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,6,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1],
									[1,3,0,6,6,8,0,0,2,0,0,0,0,3,0,3,2,0,0,0,6,0,0,0,2,0,3,4,0,0,3,0,2,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,3,0,2,3,0,0,0,0,0,0,2,0,0,4,6,0,0,0,2,6,0,0,3,0,0,0,2,0,3,0,3,3,0,1],
									[1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1],
									[1,4,0,0,6,0,3,0,2,3,0,0,0,0,3,0,2,0,3,0,6,0,0,3,2,0,3,0,3,0,0,0,2,0,0,0,0,0,0,1],
									[1,0,0,0,0,0,3,0,2,3,0,0,4,0,0,0,2,0,0,0,6,3,0,0,2,0,0,3,0,0,0,0,2,0,0,0,3,3,6,1],
									[1,0,4,0,0,0,6,3,2,0,0,3,0,0,0,0,2,0,5,4,6,3,0,0,2,0,6,0,0,0,0,0,2,0,0,0,3,3,6,1],
									[1,0,3,0,0,0,0,6,2,0,0,2,0,0,3,0,2,0,7,0,6,0,0,0,2,0,0,0,0,3,0,3,2,0,0,0,0,6,3,1],
									[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];

		

		public var _player:Character;
		private var _dirt:Dirt;
		private var _wall:MovieClip;
		private var _wall2:MovieClip;
		private var _stone:Stone;
		private var _diamond:Diamond;
		
		private var indexX:uint;
		private var indexY:uint;
		
		private var indexStoneX:uint;
		private var indexStoneY:uint;
		
		private var _lastStepY:int;
		private var _lastStepX:int;
		
		private var count:int = 1;
		private var count2:int = 1;
		
		private var _startAnim:StartAnim;
		
		private var _movementX:int;
		private var _movementY:Number = 34;
		public var score:uint = 0;
		private var _zero:String = "0";
		
		public var moving:Boolean = false;
		
		private var _stoneHandler:StoneHandler;
		
		private var _header:Header;
		
		private var  _diamondCounter:TextField;
		private var tf:TextFormat;
		
		private var _startCoutner:uint;
		
		private var _end:End;
		
		private var _digSound:Sound;
		private var _digChannel:SoundChannel;
		
		private var _collecSound:Sound;
		private var _collectChannel:SoundChannel;
		
		private var _introSound:Sound;
		private var _introChannel:SoundChannel;
		
		private var _intro2Sound:Sound;
		private var _intro2Channel:SoundChannel;
		
		private var _intro3Sound:Sound;
		private var _intro3Channel:SoundChannel;
		private var _border:Border;
		
		private var walkCount:int;
		
		public function Game(s:Stage) 
		{
			_digSound = new Sound;
			_digChannel = new SoundChannel;
			
			_digSound.load(new URLRequest("dig.mp3"));
			
			_collecSound = new Sound;
			_collectChannel = new SoundChannel;
			
			_collecSound.load(new URLRequest("collect.mp3"));
			
			_introSound = new Sound;
			_introChannel = new SoundChannel;
			
			_introSound.load(new URLRequest("intro1.mp3"));
			_introChannel = _introSound.play(0, 1);
			
			_intro2Sound = new Sound;
			_intro2Channel = new SoundChannel;
			
			_intro2Sound.load(new URLRequest("intro.mp3"));
			
			_intro3Sound = new Sound;
			_intro3Channel = new SoundChannel;
			
			_intro3Sound.load(new URLRequest("intro2.mp3"));
			
			tf = new TextFormat("Commodore 64 Pixelized Regular", 34, 0xeff225, true); // variable voor de text style.
			//tf2 = new TextFormat("Commodore 64 Pixelized Regular", 34, 0xeff225, true); // variable voor de text style.
			
			
			
			
			if(Main.level == 1){
				//trace(mapData);
        for (row = 0; row < numRows; row++)  // Grid
        {
            for (col = 0; col < numColumns; col++)
            {
              
				
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
					_stone = new Stone();
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
				else if (mapData[row][col] == 7) 
				{
					_end = new End();
					artTiles[row][col] = _end;
					addChild(_end);
					_end.x = col * cellWidth + 17 + _movementX;
					_end.y = row * cellHeight + 17 + _movementY;
					_end.width = cellWidth;
					_end.height = cellHeight;
				}
            }
			
			
		}
		
			_player = new Character();
			_player.x = cellWidth * 3 + 17;
			_player.y = cellHeight * 3 + 17;
			_player.width = cellWidth;
			_player.height = cellHeight;
			_player.anim(0);
			addChild(_player);
			
			_header = new Header();
			_header.x = 0;
			_header.y = 0;
			addChild(_header);
			
			_diamondCounter = new TextField();
			addChild(_diamondCounter);
			_diamondCounter.text = "" + _zero + score;
			_diamondCounter.x = 185;
			_diamondCounter.width = _diamondCounter.textWidth + 50; // maximale grootte text
			_diamondCounter.setTextFormat(tf);
			
			_border = new Border();
			_border.x = 0;
			_border.y = 0;
			addChild(_border);
			
		} else if (Main.level == 2) {
			 for (row = 0; row < numRows; row++)  // Grid
        {
            for (col = 0; col < numColumns; col++)
            {
				
				if (mapData2[row][col] == 0) 
				{
					_dirt = new Dirt();
					artTiles2[row][col] = _dirt;
					addChild(_dirt);
					_dirt.x = col * cellWidth  + 17 + _movementX;
					_dirt.y = row * cellHeight + 17 + _movementY;
					_dirt.width = cellWidth;
					_dirt.height = cellHeight;
				}
				else if (mapData2[row][col] == 1) 
				{
					_wall = new WallTwo();
					artTiles2[row][col] = _wall;
					addChild(_wall);
					_wall.x = col * cellWidth  + 17 + _movementX;
					_wall.y = row * cellHeight + 17 + _movementY;
					_wall.width = cellWidth;
					_wall.height = cellHeight;
				}
				else if (mapData2[row][col] == 2) 
				{
					_wall2 = new WallTwo2();
					artTiles2[row][col] = _wall2;
					addChild(_wall2);
					_wall2.x = col * cellWidth  + 17 + _movementX;
					_wall2.y = row * cellHeight + 17 + _movementY;
					_wall2.width = cellWidth;
					_wall2.height = cellHeight;
				}
				else if (mapData2[row][col] == 3) 
				{
					_stone = new Stone();
					artTiles2[row][col] = _stone;
					addChild(_stone);
					_stone.x = col * cellWidth + 17  + _movementX;
					_stone.y = row * cellHeight + 17 + _movementY;
					_stone.width = cellWidth;
					_stone.height = cellHeight;
				}
				else if (mapData2[row][col] == 4) 
				{
					_diamond = new Diamond();
					artTiles2[row][col] = _diamond;
					addChild(_diamond);
					_diamond.x = col * cellWidth + 17 + _movementX;
					_diamond.y = row * cellHeight + 17 + _movementY;
					_diamond.width = cellWidth;
					_diamond.height = cellHeight;
				}
				
				else if (mapData2[row][col] == 7) 
				{
					_end = new End();
					artTiles2[row][col] = _end;
					addChild(_end);
					_end.x = col * cellWidth + 17 + _movementX;
					_end.y = row * cellHeight + 17 + _movementY;
					_end.width = cellWidth;
					_end.height = cellHeight;
				}
            }
        
			
		}
		
			_player = new Character();
			_player.x = cellWidth * 18 + 17;
			_player.y = cellHeight * 20 + 17;
			_player.width = cellWidth;
			_player.height = cellHeight;
			_player.anim(0);
			addChild(_player);
			
			_header = new Header();
			_header.x = _player.x - 330;
			_header.y = _player.y - 289;
			addChild(_header);
			
			_diamondCounter = new TextField();
			addChild(_diamondCounter);
			_diamondCounter.text = "" + _zero + score;
			_diamondCounter.x = _player.x - 330 + 185;
			_diamondCounter.y = _player.y - 289;
			_diamondCounter.width = _diamondCounter.textWidth + 50; // maximale grootte text
			_diamondCounter.setTextFormat(tf);
			
			
			_border = new Border();
			_border.x = 374 - 68;
			_border.y = 442 - 34;
			addChild(_border);
			
			_startAnim = new StartAnim();
			_startAnim.x = 374 - 68;
			_startAnim.y = 442 - 34;
			addChild(_startAnim);
		}
			
			
			_startAnim = new StartAnim();
			addChild(_startAnim);
			
			addEventListener(Event.ENTER_FRAME, camera);
			
			
			_player.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			
		}										

//////////////////////////////////////////////////////// UPDATE/LOOP \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

		private function update(e:Event):void 
		{
			//trace(_startCoutner);
			_startCoutner += count;
			if (_startCoutner >= 105) {
				_player._playerStart.play();
				playIntro1();
					
				_stoneHandler = new StoneHandler();
				addChild(_stoneHandler);
					
				if (_startCoutner >= 175) {
					stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
					stage.addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 0, true);
					_intro3Channel = _intro3Sound.play(0, 1);
					
					count = 0;
					_startCoutner = 0;
					
				}
				}
			//trace(_movementY);
			
			indexX = Math.floor(_player.x / 34);
			indexY = Math.floor(_player.y / 34);
			
			indexStoneX = Math.floor(_stone.x / 34);
			indexStoneY = Math.floor(_stone.y / 34);
			
			//trace(mapData[indexY - 1][indexX]);
			
			if (score == 10) 
			{
				_zero = "";
			}
			//trace(indexX + " " + indexY);
			//trace(artTiles[indexY - 1][indexX]);
			
			if (Main.level == 1) {
			if (mapData[indexY - 1][indexX] == 0)
			{
				removeChild(artTiles[indexY - 1][indexX]);
				mapData[indexY - 1][indexX] = 6;
				
				startDigEffect();
			}
			if (mapData[indexY - 1][indexX] == 4)
			{
				removeChild(artTiles[indexY - 1][indexX]);
				mapData[indexY - 1][indexX] = 6;
				score += 1;
				
				startCollectEffect();
				//trace(score);
				
				startDigEffect();
				
				_diamondCounter.text = "" + _zero + score;
				_diamondCounter.setTextFormat(tf);
				_diamondCounter.embedFonts;
				//_header.gainedDaimonds.text = "" + score;
			}
			
			if (mapData[indexY - 1][indexX] == 1)
			{
				_player.y = _lastStepY;
				_player.x = _lastStepX;
				
				_header.y = _lastStepY - 119;
				_header.x = _lastStepX - 119;
				
				_border.y = _lastStepY - 119;
				_border.x = _lastStepX - 119;
				
				_diamondCounter.y = _lastStepY - 119;
				_diamondCounter.x = _lastStepX - 119 + 185;
				
			}
			if (mapData[indexY - 1][indexX] == 2)
			{
				_player.y = _lastStepY;
				_player.x = _lastStepX;
				
				_header.y = _lastStepY - 119;
				_header.x = _lastStepX - 119;
				
				_border.y = _lastStepY - 119;
				_border.x = _lastStepX - 119;
				
				_diamondCounter.y = _lastStepY - 119;
				_diamondCounter.x = _lastStepX - 119 + 185;
				
			}
			if (mapData[indexY - 1][indexX] == 3)
			{
				_player.y = _lastStepY;
				_player.x = _lastStepX;
				
				_header.y = _lastStepY - 119;
				_header.x = _lastStepX - 119;
				
				_border.y = _lastStepY - 119;
				_border.x = _lastStepX - 119;
				
				_diamondCounter.y = _lastStepY - 119;
				_diamondCounter.x = _lastStepX - 119 + 185;
				
			}
			if (mapData[indexStoneY][indexStoneX] == 6)
			{
				artTiles[indexStoneY - 1 ][indexStoneX].y -= 34;
				
			}
			//trace(mapData[indexStoneY][indexStoneX]);
			
				
			} else if (Main.level == 2) {
				if (mapData2[indexY - 1][indexX] == 0)
			{
				removeChild(artTiles2[indexY - 1][indexX]);
				mapData2[indexY - 1][indexX] = 6;
				
				startDigEffect();
			}
			if (mapData2[indexY - 1][indexX] == 4)
			{
				removeChild(artTiles2[indexY - 1][indexX]);
				mapData2[indexY - 1][indexX] = 6;
				score += 1;
				
				startCollectEffect();
				//trace(score);
				
				startDigEffect();
				
				_diamondCounter.text = "" + _zero + score;
				_diamondCounter.setTextFormat(tf);
				_diamondCounter.embedFonts;
				//_header.gainedDaimonds.text = "" + score;
			}
			
			if (mapData2[indexY - 1][indexX] == 1)
			{
				_player.y = _lastStepY;
				_player.x = _lastStepX;
				
				_header.y = _lastStepY - 119;
				_header.x = _lastStepX - 119;
				
				_border.y = _lastStepY - 119;
				_border.x = _lastStepX - 119;
				
				_diamondCounter.y = _lastStepY - 119;
				_diamondCounter.x = _lastStepX - 119 + 185;
				
			}
			if (mapData2[indexY - 1][indexX] == 2)
			{
				_player.y = _lastStepY;
				_player.x = _lastStepX;
				
				_header.y = _lastStepY - 119;
				_header.x = _lastStepX - 119;
				
				_border.y = _lastStepY - 119;
				_border.x = _lastStepX - 119;
				
				_diamondCounter.y = _lastStepY - 119;
				_diamondCounter.x = _lastStepX - 119 + 185;
				
			}
			if (mapData2[indexY - 1][indexX] == 3)
			{
				_player.y = _lastStepY;
				_player.x = _lastStepX;
				
				_header.y = _lastStepY - 119;
				_header.x = _lastStepX - 119;
				
				_border.y = _lastStepY - 119;
				_border.x = _lastStepX - 119;
				
				_diamondCounter.y = _lastStepY - 119;
				_diamondCounter.x = _lastStepX - 119 + 185;
				
			}
			if (mapData2[indexStoneY][indexStoneX] == 6)
			{
				artTiles2[indexStoneY - 1 ][indexStoneX].y -= 34;
				
			}
			}
			var _playX1:int = 629;
			
			if (score >= 15) {
				if (mapData[indexY - 1][indexX] == 7)
				{
					_end.play();
					
					done();
					
				}
				
					//trace("won!");
			}
			
		}
		
		private function done():void 
		{
			_player.removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			removeEventListener(Event.ENTER_FRAME, camera);
			
			dispatchEvent(new Event("done"));
		}
		
		private function playIntro1():void 
		{
			count2 += 1;
			if (count2 <= 2) {
				_intro2Channel = _intro2Sound.play(1, 1);
			}
		}
		
		private function startCollectEffect():void 
		{
			_collectChannel = _collecSound.play(0,1);
		}
		
		private function startDigEffect():void 
		{
			_digChannel = _digSound.play(0,1);
		}
		
//////////////////////////////////////////////////////// KEYBOARD EVENTS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

		
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37 || e.keyCode == 38 || e.keyCode == 39 || e.keyCode == 40) 
			{
				_player.y -= 0;
				_player.anim(1);
				
				walkCount = 0;
			}
			//trace("X " + _movementX + " - " + "Y " + _movementY);
			
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			//trace(e.keyCode); // up:38, down:40,right:39,left:37
			
				if (e.keyCode == 38 || e.keyCode == 87) // KEY UP!
				{
					walkCount += 1;
					if(walkCount == 1){
					_player.y -= 34;
					_movementY -= 34;
					_player.anim(2);
					
					_header.y -= 34;
					_diamondCounter.y -= 34;
					_border.y -= 34;
					
					//movement();
					_stoneHandler = new StoneHandler();
					addChild(_stoneHandler);
					
					_lastStepY = _player.y + 34;
					_lastStepX = _player.x;
					
					walkCount += 1;
					}
					
					//trace("X: " + _player.x + " / Y: " + _player.y);
					//trace("X: " + _lastStepX + " / Y: " + _lastStepY + "   // Last step");
					
				}
				if (e.keyCode == 40 || e.keyCode == 83) // KEY DOWN!
				{
					
					walkCount += 1;
					if(walkCount == 1){
					_player.y += 34;
					_movementY += 34;
					_player.anim(2);
					
					_header.y += 34;
					_diamondCounter.y += 34;
					_border.y += 34;
					
					
					//movement();
					_stoneHandler = new StoneHandler();
					addChild(_stoneHandler);
					
					_lastStepY = _player.y - 34;
					_lastStepX = _player.x;
					
					
					walkCount += 1;
				
					//trace("X: " + _player.x + " / Y: " + _player.y);
					//trace("X: " + _lastStepX + " / Y: " + _lastStepY + "   // Last step");
					}
				}
				if (e.keyCode == 39 || e.keyCode == 68) // KEY RIGHT!
				{
					walkCount += 1;
					if (walkCount == 1){
					_player.x += 34;
					_movementX += 34;
					_player.anim(2);
					_player.scaleX = 1;
					
					_header.x += 34;
					_diamondCounter.x += 34;
					_border.x += 34;
					
					
					_stoneHandler = new StoneHandler();
					addChild(_stoneHandler);
					
					_lastStepY = _player.y;
					_lastStepX = _player.x - 34;
					
					walkCount += 2;
					
					//trace("X: " + _player.x + " / Y: " + _player.y);
					//trace("X: " + _lastStepX + " / Y: " + _lastStepY + "   // Last step");
					}
				}
				if (e.keyCode == 37 || e.keyCode == 65) // KEY LEFT!
				{
					
					walkCount += 1;
					if (walkCount == 1){
					_player.x -= 34;
					_movementX -= 34;
					_player.anim(2);
					_player.scaleX = -1;
					
					_header.x -= 34;
					_diamondCounter.x -= 34;
					_border.x -= 34;
					
					
					_stoneHandler = new StoneHandler();
					addChild(_stoneHandler);
					
					_lastStepY = _player.y;
					_lastStepX = _player.x + 34;
					
					walkCount += 2;
					
					//trace("X: " + _player.x + " / Y: " + _player.y);
					//trace("X: " + _lastStepX + " / Y: " + _lastStepY + "   // Last step");
					}
				}
		}
		
		private function camera(e:Event):void
		{
			if(Main.level == 1) root.scrollRect = new Rectangle(_player.x - 119, _player.y - 119, stage.stageWidth, stage.stageHeight);
			if(Main.level == 2) root.scrollRect = new Rectangle(_player.x - 323, _player.y - 289, stage.stageWidth, stage.stageHeight);
		}
		private function cameraTwo(e:Event):void
		{
			root.scrollRect = new Rectangle(_player.x - 578, _player.y - 119, stage.stageWidth, stage.stageHeight);
		
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