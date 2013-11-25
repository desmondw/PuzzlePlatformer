package
{
    import org.axgl.Ax;
	import org.axgl.AxRect;
    import org.axgl.AxSprite;
	import org.axgl.AxVector;
	import org.axgl.input.AxKey;
 
    public class Player extends AxSprite
	{
		private static const DRAG:uint = 80;
		private static const ACCELERATION:uint = 140;
		private static const ACCEL_TURN_MOD:Number = 1.3;
		private static const MAX_VELOCITY:uint = 80;
		
        public function Player(x:Number, y:Number, worldWidth:Number, worldHeight:Number)
		{
            super(x, y);
			
			worldBounds = new AxRect(0, 0, worldWidth, worldHeight);
			maxVelocity = new AxVector(MAX_VELOCITY, MAX_VELOCITY);
			drag.x = DRAG;
			drag.y = DRAG;
			//maxVelocity = new AxVector(75, 150);
			//drag.x = 200;
			//acceleration.y = 200;
            
            load(Resource.PLAYER, 8, 8);
			bounds(6, 7, 1, 1);
        }
        
        override public function update():void
		{
			movement();
			
            super.update();
        }
		
		private function movement():void
		{
			//acceleration.y = 200;
			acceleration.x = 0;
			acceleration.y = 0;
			
			if (Ax.keys.down(AxKey.D))
			{
				if (velocity.x < 0)
					acceleration.x = ACCELERATION * ACCEL_TURN_MOD;
				else
					acceleration.x = ACCELERATION;
				facing = RIGHT;
			}
			else if (Ax.keys.down(AxKey.A))
			{
				if (velocity.x > 0)
					acceleration.x = -ACCELERATION * ACCEL_TURN_MOD;
				else
					acceleration.x = -ACCELERATION;
				facing = LEFT;
			}
				
			if (Ax.keys.down(AxKey.W))
			{
				if (velocity.y < 0)
					acceleration.y = -ACCELERATION * ACCEL_TURN_MOD;
				else
					acceleration.y = -ACCELERATION;
			}
			else if (Ax.keys.down(AxKey.S))
			{
				if (velocity.y < 0)
					acceleration.y = ACCELERATION * ACCEL_TURN_MOD;
				else
					acceleration.y = ACCELERATION;
			}
		}
    }
}