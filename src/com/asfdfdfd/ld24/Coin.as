package com.asfdfdfd.ld24
{
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class Coin extends Entity
	{
		[Embed(source='assets/coin.png')]
		private static const BITMAP:Class;
		
		private static const WIDTH:int = 16;
		private static const HEIGHT:int = 16;
		
		private static const MOVE_TO_CORE_TIME:Number = 0.4;
		
		private static const SCORES:uint = 100;
		
		private static const TIME_DISSAPPEAR:Number = 5;
		
		private var _motion:LinearMotion = null;
		
		private var _dissappearTimer:Number = TIME_DISSAPPEAR;
				
		public function Coin(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, new Image(BITMAP), mask);
			
			setHitbox(WIDTH, HEIGHT);
			
			type = "Coin";
		}
		
		public function moveToTheCore():void
		{
			type = "DeadCoin";
			
			_motion = new LinearMotion(movedToTheCore);
			_motion.setMotion(x, y, GameWorld.CoreInstance.x + Core.WIDTH / 2, GameWorld.CoreInstance.y + Core.HEIGHT / 2, MOVE_TO_CORE_TIME);
			
			addTween(_motion, true);	
			
			GameWorld.Scores += SCORES;
		}
		
		private function movedToTheCore():void
		{
			FP.world.remove(this);
			
			GameWorld.CoreInstance.addCoin();
		}
		
		override public function update():void
		{
			super.update();
			
			if (_motion)
			{
				x = _motion.x;
				y = _motion.y;
			}
			
			_dissappearTimer -= FP.elapsed;
			
			if (_dissappearTimer <= 0)
			{
				FP.world.remove(this);
			}
		}
	}
}