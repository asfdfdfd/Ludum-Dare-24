package com.asfdfdfd.ld24.upgrades
{
	import com.asfdfdfd.ld24.hero.Hero;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	
	public class GunUpgradeEntity extends Entity
	{
		[Embed(source='assets/upgrade_gun.png')]
		private static const BITMAP:Class;
		
		public static const WIDTH:int = 32;
		public static const HEIGHT:int = 32;
		
		[Embed(source='assets/upgrade_pickup.mp3')] private static const PICK_SOUND:Class;
		
		private var _pickSfx:Sfx = new Sfx(PICK_SOUND);		

		public function GunUpgradeEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, new Image(BITMAP), mask);
			
			setHitbox(WIDTH, HEIGHT);
			
			type = "GunUpgrade";
		}
		
		override public function update():void
		{
			var hero:Entity = collide("Hero", x, y);
			
			if (hero)
			{
				_pickSfx.play();
				
				FP.world.remove(this);
				
				(hero as Hero).gunType++;
			}			
		}
	}
}