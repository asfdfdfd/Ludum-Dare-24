package com.asfdfdfd.ld24.hero
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;

	public class HeroGun01 extends HeroGun
	{
		private static const TIME_BETWEEN_SHOTS:Number = 0.1;
		
		private var _timerBetweenShots:Number = 0;
		
		private var _allowShot:Boolean = true;
		
		public function HeroGun01()
		{
			super();
		}
		
		override public function shoot(x:Number, y:Number, toX:Number, toY:Number):void
		{
			super.shoot(x, y, toX, toY);
			
			if (_allowShot)
			{
				_shootSfx.play();
				
				FP.world.add(new HeroBullet(x, y, toX, toY));
				_allowShot = false;
			}
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