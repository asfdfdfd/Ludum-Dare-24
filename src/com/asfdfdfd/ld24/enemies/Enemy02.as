package com.asfdfdfd.ld24.enemies
{
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	public class Enemy02 extends Enemy
	{
		[Embed(source='assets/enemy_02.png')]
		private static const BITMAP:Class;
		
		private static const WIDTH:int = 32;
		private static const HEIGHT:int = 32;
		
		private static const HEALTH:Number = 5;
		
		private static const SPEED:Number = 100;
		
		private static const TIME_BETWEEN_BURSTS:Number = 2;
		private static const TIME_BETWEEN_BULLETS:Number = 0.2;
		
		private static const BULLETS_IN_BURST:uint = 3;
		
		private var _speed:Point = new Point();
		
		private var _timerBetweenBursts:Number = 0;
		private var _timerBetweenBullets:Number = 0;
		
		private var _bulletsShootedInBurst:Number = 0;
				
		public function Enemy02(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(HEALTH, x, y, new Image(BITMAP), mask);
			
			setHitbox(WIDTH, HEIGHT, WIDTH/2, HEIGHT/2);
			(this.graphic as Image).originX = WIDTH / 2;
			(this.graphic as Image).originY = HEIGHT / 2;
		}
		
		override public function update():void
		{
			super.update();
			
			var toX:Number = GameWorld.HeroInstance.x;
			var toY:Number = GameWorld.HeroInstance.y;
			
			var deltaX:Number = toX - x;
			var deltaY:Number = toY - y;
			
			_speed = new Point(deltaX, deltaY);
			_speed.normalize(SPEED);
			
			x += _speed.x * FP.elapsed;
			y += _speed.y * FP.elapsed;	
			
			shoot();
			
			(graphic as Image).angle = FP.angle(x, y, GameWorld.HeroInstance.x, GameWorld.HeroInstance.y) - 90;
		}
		
		private function shoot():void
		{
			if (_timerBetweenBursts <= 0)
			{
				if (_timerBetweenBullets <= 0)
				{
					_shootSfx.play();
					
					FP.world.add(new Enemy02Bullet(x + WIDTH / 2 - Enemy02Bullet.WIDTH / 2, y + HEIGHT / 2 - Enemy02Bullet.HEIGHT / 2, GameWorld.HeroInstance.x, GameWorld.HeroInstance.y));
					
					_timerBetweenBullets += TIME_BETWEEN_BULLETS;
					
					_bulletsShootedInBurst++;
					
					if (_bulletsShootedInBurst == BULLETS_IN_BURST)
					{
						_timerBetweenBursts += TIME_BETWEEN_BURSTS;
						_bulletsShootedInBurst = 0;
					}
				}
				else
				{
					_timerBetweenBullets -= FP.elapsed;
				}
			}
			else
			{
				_timerBetweenBursts -= FP.elapsed;
			}
		}
		
		override public function get scores():uint
		{
			return 300;
		}		
	}
}