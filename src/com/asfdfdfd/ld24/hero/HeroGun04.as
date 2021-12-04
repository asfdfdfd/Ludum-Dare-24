package com.asfdfdfd.ld24.hero
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;

	public class HeroGun04 extends HeroGun
	{
		private static const TIME_BETWEEN_SHOTS:Number = 0.05;
		
		private var _timerBetweenShots:Number = 0;
		
		private var _allowShot:Boolean = true;
		
		public function HeroGun04()
		{
			super();
		}
		
		override public function shoot(x:Number, y:Number, toX:Number, toY:Number):void
		{
			super.shoot(x, y, toX, toY);
			
			if (_allowShot)
			{		
				var point:Object = {x:x, y:y};
				
				var endpoint1:Object = {x:toX, y:toY};
				
				FP.rotateAround(endpoint1, point, -40);
				FP.world.add(new HeroBullet(x, y, endpoint1.x, endpoint1.y));
				
				var endpoint2:Object = {x:toX, y:toY};
				
				FP.rotateAround(endpoint2, point, -30);
				FP.world.add(new HeroBullet(x, y, endpoint2.x, endpoint2.y));
				
				FP.world.add(new HeroBullet(x, y, toX, toY));
				
				var endpoint3:Object = {x:toX, y:toY};
				
				FP.rotateAround(endpoint3, point, 40);
				FP.world.add(new HeroBullet(x, y, endpoint3.x, endpoint3.y));
				
				var endpoint4:Object = {x:toX, y:toY};
				
				FP.rotateAround(endpoint4, point, 30);
				FP.world.add(new HeroBullet(x, y, endpoint4.x, endpoint4.y));				
				
				_allowShot = false;
				
				_shootSfx.play();
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