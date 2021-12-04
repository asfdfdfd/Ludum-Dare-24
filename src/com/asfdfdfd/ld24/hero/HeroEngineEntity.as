package com.asfdfdfd.ld24.hero
{
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	
	public class HeroEngineEntity extends Entity
	{		
		private var _emitter:Emitter;

		public function HeroEngineEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			_emitter = new Emitter(particle, 8, 8);
////			_emitter.newType("animated", [0, 1, 2, 3]);
			_emitter.newType('hero_engine',[0]);
////			_emitter.setAlpha("animated", 1, 0);
//			_emitter.setMotion('enemy_explosion', 0, 0, 0.2, 360, 200, 1);
//			_emitter.setMotion('hero_engine', 0,  0, 0.2, 360, 100, 0.5);			
////			_emitter.setMotion("animated", 0, 0, 0.4, 15, 5, 0.4);	
			_emitter.relative = false;

			super(x, y, _emitter, mask);	
			
			layer = -9;
		}
		
		public function set angle(value:Number):void
		{
			FP.rotateAround(this, GameWorld.HeroInstance, value);
			_emitter.setMotion('hero_engine', value - 90, 0, 0.2, 5, 5, 0.5);
		}
		
		private function get particle():BitmapData
		{
			return new BitmapData(3, 3, false, 0xed3d28);
		}

		override public function update():void
		{
			super.update();
			
			_emitter.emit("hero_engine", x, y);
			_emitter.emit("hero_engine", x-1, y);
		}
	}
}