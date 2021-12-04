package com.asfdfdfd.ld24.enemies
{
	import com.asfdfdfd.ld24.Game;
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Enemy01 extends Enemy
	{
		[Embed(source='assets/enemy_01.png')]
		private static const BITMAP_ENEMY_01:Class;
		
		private static const WIDTH:int = 32;
		private static const HEIGHT:int = 32;
		
		private static const HEALTH:Number = 4;
		
		private static const SPEED:Number = 200;
				
		private var _speed:Point = new Point();
				
		public function Enemy01(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(HEALTH, x, y, new Image(BITMAP_ENEMY_01), mask);
			
			setHitbox(WIDTH, HEIGHT);
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
		}
		
		override public function get scores():uint
		{
			return 200;
		}
	}
}