package com.asfdfdfd.ld24.hero
{
	import net.flashpunk.Sfx;

	public class HeroGun
	{
		[Embed(source='assets/hero_shoot.mp3')] private static const SHOOT_SOUND:Class;
		
		protected var _shootSfx:Sfx = new Sfx(SHOOT_SOUND);
		
		public function HeroGun()
		{
		}
		
		public function shoot(x:Number, y:Number, toX:Number, toY:Number):void
		{
		}
		
		public function rotate(angle:Number):void
		{
		}
		
		public function update():void
		{
		}
	}
}