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
	
	public class Enemy03 extends Enemy
	{
		[Embed(source='assets/enemy_03.png')]
		private static const BITMAP:Class;
		
		private static const WIDTH:int = 32;
		private static const HEIGHT:int = 32;
		
		private static const HEALTH:Number = 10;
		
		private static const SPEED:Number = 100;
		
		private static const ROTATION_SPEED:Number = 150;
		
		private static const TIME_BETWEEN_BURSTS:Number = 2;
		private static const TIME_BETWEEN_BULLETS:Number = 0.05;
		
		private static const BULLETS_IN_BURST:uint = 5;
		
		private var _speed:Point = new Point();
		
		private var _barrel1Pos:Point;
		private var _barrel2Pos:Point;
		private var _barrel3Pos:Point;
		private var _barrel4Pos:Point;
		
		private var _barrel1PosE:Point;
		private var _barrel2PosE:Point;
		private var _barrel3PosE:Point;
		private var _barrel4PosE:Point;		
				
		private var _angle:Number = 0;
		
		private var _timerBetweenBursts:Number = 0;
		private var _timerBetweenBullets:Number = 0;
		
		private var _bulletsShootedInBurst:Number = 0;
		
		public function Enemy03(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
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
						
			_angle += FP.elapsed * ROTATION_SPEED;
			
			_barrel1Pos = new Point(x - WIDTH / 2, y);
			_barrel2Pos = new Point(x, y - HEIGHT / 2);
			_barrel3Pos = new Point(x + WIDTH / 2, y);
			_barrel4Pos = new Point(x, y + HEIGHT / 2);		
			
			_barrel1PosE = new Point(x - WIDTH, y);
			_barrel2PosE = new Point(x, y - HEIGHT);
			_barrel3PosE = new Point(x + WIDTH, y);
			_barrel4PosE = new Point(x, y + HEIGHT);				
			
			shoot();
		}
		
		private function shoot():void
		{
			if (_timerBetweenBursts <= 0)
			{
				if (_timerBetweenBullets <= 0)
				{
					_shootSfx.play();
					
					FP.rotateAround(_barrel1Pos, this, _angle);
					FP.rotateAround(_barrel2Pos, this, _angle);
					FP.rotateAround(_barrel3Pos, this, _angle);
					FP.rotateAround(_barrel4Pos, this, _angle);
					
					FP.rotateAround(_barrel1PosE, this, _angle);
					FP.rotateAround(_barrel2PosE, this, _angle);
					FP.rotateAround(_barrel3PosE, this, _angle);
					FP.rotateAround(_barrel4PosE, this, _angle);			
					
					FP.world.add(new Enemy02Bullet(_barrel1Pos.x, _barrel1Pos.y, _barrel1PosE.x, _barrel1PosE.y));
					FP.world.add(new Enemy02Bullet(_barrel2Pos.x, _barrel2Pos.y, _barrel2PosE.x, _barrel2PosE.y));
					FP.world.add(new Enemy02Bullet(_barrel3Pos.x, _barrel3Pos.y, _barrel3PosE.x, _barrel3PosE.y));
					FP.world.add(new Enemy02Bullet(_barrel4Pos.x, _barrel4Pos.y, _barrel4PosE.x, _barrel4PosE.y));
					
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
			return 400;
		}		
	}
}