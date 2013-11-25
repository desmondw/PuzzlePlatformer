package
{
    import org.axgl.*;
    import org.axgl.collision.*;
	import org.axgl.particle.*;
	import org.axgl.render.*;
	import org.axgl.text.*;
    import org.axgl.tilemap.*;
	import org.axgl.util.*;
	import org.axgl.input.*;
 
    public class GameState extends AxState
	{
		public var soundModifier:Number = .5;
		public var musicModifier:Number = .4;
		
        private var tilemapCollider:AxCollisionGroup;
        
        private var tilemap:AxTilemap;
        private var player:Player;
		
		private var blockInHand:int = 0;
		private var blockInHandSprite:AxSprite;
		
		private var newPosPlayer:AxSprite
        
        override public function create():void
		{
            super.create();
			
            //Ax.music(Resource.MUSIC);
			
            //var background:AxSprite = new AxSprite(0, 0, Resource.BACKGROUND);
            //background.scroll.x = 0;
			//background.scroll.y = 0;
            //add(background);
            
			//generate tilemap from data
            tilemap = new AxTilemap().build(Resource.MAP_DATA, Resource.TILES, 8, 8, 1);
            add(tilemap);
			
			//initialize player held block data
			blockInHandSprite = new AxSprite(0, 0, Resource.TILES, 8, 8);
			blockInHandSprite.visible = false;
			add(blockInHandSprite);
            
			//initialize player
            player = new Player(120, 40, tilemap.width, tilemap.height);
            add(player);
            
            tilemapCollider = new AxCollider; //fuck if I know how this works
			
			//Ax.camera.follow(player);
			//Ax.camera.bounds = new AxRect(0, 0, tilemap.width, tilemap.height);
			
        }
        
        override public function update():void
		{
            super.update();
			
            Ax.collide(player, tilemap, null, tilemapCollider); //collision
			soundAdjustment(); //input for volume levels
			
			//update player held block graphical position
			blockInHandSprite.x = player.x - 1;
			blockInHandSprite.y = player.y - 9;
			
			//interact with blocks
			if (Ax.keys.pressed(AxKey.LEFT))
				blockInteraction(LEFT);
			if (Ax.keys.pressed(AxKey.RIGHT))
				blockInteraction(RIGHT);
			if (Ax.keys.pressed(AxKey.UP))
				blockInteraction(UP);
			if (Ax.keys.pressed(AxKey.DOWN))
				blockInteraction(DOWN);
        }
		
		//handles input to change volume levels for sound/music
		private function soundAdjustment():void 
		{
			if (Ax.keys.pressed(AxKey.PLUS) || Ax.keys.pressed(AxKey.NUMPADPLUS))
			{
				if (soundModifier + .1 > 1)
					soundModifier = 1;
				else
					soundModifier += .1;
			}
			if (Ax.keys.pressed(AxKey.MINUS) || Ax.keys.pressed(AxKey.NUMPADMINUS))
			{
				if (soundModifier - .1 < 0)
					soundModifier = 0;
				else
					soundModifier -= .1;
			}
			if (Ax.keys.pressed(AxKey.M))
			{
				if (musicModifier == 0)
					musicModifier = Resource.DEFUALT_MUSIC_MOD;
				else
					musicModifier = 0;
			}
		}
		
		//handles picking up and placing blocks
		private function blockInteraction(direction:uint):void
		{
			var tileX:int = player.center.x;
			var tileY:int = player.center.y;
			var tileGridX:int;
			var tileGridY:int;
			var movePlayerX:Number = 0;
			var movePlayerY:Number = 0;
			var pushPlayerX:Number = 0;
			var pushPlayerY:Number = 0;
			const PUSH_DISTANCE:int = 25;
			
			switch (direction) 
			{
				case DOWN:
					movePlayerY = -8; //move player ouf of blocks way
					pushPlayerY = -PUSH_DISTANCE; //pushback effect
					tileY = player.bottom + 4; //coordinate of block pickup/placement
				break;
				case UP:
					movePlayerY = 8;
					pushPlayerY = PUSH_DISTANCE;
					tileY = player.y - 4;
				break;
				case RIGHT:
					movePlayerX = -8;
					pushPlayerX = -PUSH_DISTANCE;
					tileX = player.right +  4;
				break;
				case LEFT:
					movePlayerX = 8;
					pushPlayerX = PUSH_DISTANCE;
					tileX = player.x - 4;
				break;
			}
			
			//translate block coordinates to tile grid coordinates
			tileGridX = Math.floor(tileX / tilemap.tileWidth);
			tileGridY = Math.floor(tileY / tilemap.tileHeight);
			
			//create a temp collision detection sprite for a placed block
			var newPosTile:AxSprite = new AxSprite(tileGridX * tilemap.tileWidth, tileGridY * tilemap.tileHeight);
			newPosTile.bounds(8, 8, 0, 0);
			//newPosTile.load(Resource.DEBUG)
			//add(newPosTile);
			
			//out of bounds - cancel
			if (tileX < 0 || tileX >= tilemap.width || tileY < 0 || tileY >= tilemap.height)
				return;
			
			//pickup block
			if (blockInHand == 0 && tilemap.getTileAt(tileGridX, tileGridY) != null) //no block held & block below player
			{
				blockInHand = tilemap.getTileAt(tileGridX, tileGridY).index; //set held block
				tilemap.setTileAt(tileGridX, tileGridY, 0); //remove block on grid
				
				//add block to hand
				blockInHandSprite.frame = blockInHand - 1;
				blockInHandSprite.visible = true;
				Ax.sound(Resource.BLOCK_PICKUP, soundModifier);
			}
			//place block
			else if (blockInHand != 0)
			{
				//temp bounding box of new player location
				newPosPlayer = new AxSprite(player.x, player.y);
				newPosPlayer.bounds(player.width, player.height, player.offset.x, player.offset.y);
				newPosPlayer.x += movePlayerX;
				newPosPlayer.y += movePlayerY;
				
				//if setting in open space, not on top of player, don't push back
				if  (tilemap.getTileAt(tileGridX, tileGridY) == null && !Ax.overlap(newPosTile, player)) //set in open space
				{
					tilemap.setTileAt(tileGridX, tileGridY, blockInHand); //set grid block
					
					//remove block from hand
					blockInHand = 0;
					blockInHandSprite.visible = false;
					Ax.sound(Resource.BLOCK_PLACE, soundModifier);
				}
				else //setting under player or against a block
				{
					if (Ax.overlap(newPosPlayer, tilemap) || !testPlayerOnScreen(newPosPlayer)) //verifies player wont be launched up inside a block
						Ax.sound(Resource.ERROR, soundModifier); //throw error sound, do nothing
					else
					{
						if (tilemap.getTileAt(tileGridX, tileGridY) == null) //set in open space
							tilemap.setTileAt(tileGridX, tileGridY, blockInHand); //add block to grid
						else //set against another block
							tilemap.setTileAtPixelCoordinates(player.center.x, player.center.y, blockInHand); //add block to grid
						
						//move player and give pushback effect
						player.x += movePlayerX;
						player.velocity.x = pushPlayerX;
						player.y += movePlayerY;
						player.velocity.y = pushPlayerY;
						
						//remove block from hand
						blockInHand = 0;
						blockInHandSprite.visible = false;
						Ax.sound(Resource.BLOCK_PLACE, soundModifier);
					}
				}
			}
		}
		
		//tests if given sprite is located entirely within the game borders
		public function testPlayerOnScreen(player:AxSprite):Boolean
		{
			if (player.left < tilemap.left)
				return false;
			if (player.right > tilemap.right)
				return false;
			if (player.top < tilemap.top)
				return false;
			if (player.bottom > tilemap.bottom)
				return false;
			return true;
		}
    }
}