package
{
    public class Resource
	{
		public static var DEFAULT_SOUND_MOD:Number = .5;
		public static var DEFUALT_MUSIC_MOD:Number = .4;
		
		public static const TILES_PER_ROW:uint = 4;
		
		public static const STONE:uint = 1;
		public static const DIRT:uint = 2;
		public static const METAL:uint = 3;
		public static const GRASS:uint = 4;
		public static const WOOD:uint = 5;
		public static const LEAVES:uint = 6;
		public static const CLOUD:uint = 7;
		public static const VOLCANO:uint = 8;
		
		//graphics
        [Embed(source = "/debugOutline.png")] public static const DEBUG:Class;
        [Embed(source = "/tiles.png")] public static const TILES:Class;
        [Embed(source = "/background.png")] public static const BACKGROUND:Class;
        [Embed(source = "/player.png")] public static const PLAYER:Class;
        [Embed(source = "/particle.png")] public static const PARTICLE:Class;
		
		//sounds
		[Embed(source = "/pickupBlock.mp3")] public static const BLOCK_PICKUP:Class;
		[Embed(source = "/placeBlock.mp3")] public static const BLOCK_PLACE:Class;
		[Embed(source = "/jump.mp3")] public static const JUMP:Class;
		[Embed(source = "/error.mp3")] public static const ERROR:Class;
		[Embed(source = "/simplex.mp3")] public static const MUSIC:Class;
        
		public static const MAP_DATA:String = "1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0\n" +
											"0,0,0,0,0,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,0,0,0,0\n" +
											"0,0,0,0,0,7,7,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,8,4,4,2,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,1,2,4,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,2,1,3,1,2,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,1,2,2,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5\n" +
											"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5";
    }
}