package com.asfdfdfd.ld24.enemies
{
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	
	public class EnemyExplosionEntity extends Entity
	{
		private static const REMOVE_TIMER:int = 10000;
		
		private static const MAX_PARTICLES:int = 10;
		
		private var _emitter:Emitter;
				
		private var _partcilesCount:int = MAX_PARTICLES;
		
		private var _removeTimer:int = REMOVE_TIMER;
		
		public function EnemyExplosionEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			_emitter = new Emitter(particle, 8, 8);
////			_emitter.newType("animated", [0, 1, 2, 3]);
			_emitter.newType('enemy_explosion',[0]);
////			_emitter.setAlpha("animated", 1, 0);
//			_emitter.setMotion('enemy_explosion', 0, 0, 0.2, 360, 200, 1);
			_emitter.setMotion('enemy_explosion', 0,  0, 0.2, 360, 100, 0.5);			
////			_emitter.setMotion("animated", 0, 0, 0.4, 15, 5, 0.4);	
			_emitter.relative = false;

			super(x, y, _emitter, mask);			
		}
		
		private function get particle():BitmapData
		{
			return new BitmapData(3, 3, false, 0xed3d28);
		}
		
		override public function update():void
		{
			super.update();
			
			if (_partcilesCount)
			{
				_emitter.emit("enemy_explosion", x, y);
				_emitter.emit("enemy_explosion", x, y);
				_emitter.emit("enemy_explosion", x, y);
				
				_partcilesCount--;
			}
			
			_removeTimer--;
			
			if (!_removeTimer)
			{
				FP.world.remove(this);
			}
		}
	}
}