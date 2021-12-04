package com.asfdfdfd.ld24.enemies
{
	import com.asfdfdfd.ld24.enemies.Enemy;
	import com.asfdfdfd.ld24.enemies.Enemy01;
	import com.asfdfdfd.ld24.hero.Hero;
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class Enemy02Bullet extends Entity
	{
		[Embed(source='assets/enemy_bullet.png')]
		private static const BITMAP_HERO_BULLET:Class;
		
		public static const WIDTH:int = 8;
		public static const HEIGHT:int = 8;
				
		private static const SPEED:Number = 300;
		
		private static const DAMAGE:Number = 100;
		
		private var _speed:Point;
		
		public function Enemy02Bullet(x:Number, y:Number, toX:Number, toY:Number)
		{
			super(x, y, new Image(BITMAP_HERO_BULLET));
		
			var deltaX:Number = toX - x;
			var deltaY:Number = toY - y;
			
			_speed = new Point(deltaX, deltaY);
			_speed.normalize(SPEED);
			
			type = "Enemy02Bullet";
		}
		
		override public function update():void
		{
			super.update();
			
			if (x < 0 || y < 0 || x > GameWorld.WIDTH || y > GameWorld.HEIGHT)
			{
				FP.world.remove(this);
				return;
			}
			
			x += _speed.x * FP.elapsed;
			y += _speed.y * FP.elapsed;		
			
			var hero:Entity = collide("Hero", x, y);
			
			if (hero)
			{
				(hero as Hero).damage(DAMAGE);
				
				FP.world.remove(this);
			}
		}
	}
}