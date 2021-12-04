package com.asfdfdfd.ld24.hero
{
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;

	public class HeroGun02 extends HeroGun
	{
		private static const TIME_BETWEEN_SHOTS:Number = 0.1;
		
		private var _timerBetweenShots:Number = 0;
		
		private var _allowShot:Boolean = true;
		
		private var _barrel1Pos:Point;
		private var _barrel2Pos:Point
		
		public function HeroGun02(barrel1Pos:Point, barrel2Pos:Point)
		{
			super();
			
			_barrel1Pos = barrel1Pos;
			_barrel2Pos = barrel2Pos;
		}
		
		override public function shoot(x:Number, y:Number, toX:Number, toY:Number):void
		{
			super.shoot(x, y, toX, toY);
			
			if (_allowShot)
			{
				var deltaX:Number = toX - x;
				var deltaY:Number = toY - y;
				
				FP.world.add(new HeroBullet(_barrel1Pos.x, _barrel1Pos.y, _barrel1Pos.x + deltaX, _barrel1Pos.y + deltaY));
				FP.world.add(new HeroBullet(_barrel2Pos.x, _barrel2Pos.y, _barrel2Pos.x + deltaX, _barrel2Pos.y + deltaY));
				
				_allowShot = false;
				
				_shootSfx.play();
			}
		}

		override public function rotate(angle:Number):void
		{
			_barrel1Pos = new Point(GameWorld.HeroInstance.x-14, GameWorld.HeroInstance.y-5);
			_barrel2Pos = new Point(GameWorld.HeroInstance.x+10, GameWorld.HeroInstance.y-5)
			
			FP.rotateAround(_barrel1Pos, GameWorld.HeroInstance, angle);
			FP.rotateAround(_barrel2Pos, GameWorld.HeroInstance, angle);
		}
		
		override public function update():void
		{
			super.update();
			
			if (_timerBetweenShots <= 0)
			{				
				_allowShot = true;
				_timerBetweenShots = TIME_BETWEEN_SHOTS;
			}
			else
			{
				_timerBetweenShots -= FP.elapsed;	
			}			
		}		
	}
}