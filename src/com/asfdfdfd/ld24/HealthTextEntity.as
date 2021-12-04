package com.asfdfdfd.ld24
{
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;
	
	public class HealthTextEntity extends Entity
	{
		private var _text:Text;
		
		public function HealthTextEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			_text = new Text("Health: " + GameWorld.HeroInstance.health);
			_text.color = 0x000000;
			_text.scrollX = 0;
			_text.scrollY = 0;
			
			super(x, y, _text, mask);
			
			layer = -999;
		}
					
		override public function update():void
		{
			super.update();
						
			_text.text = "Health: " + GameWorld.HeroInstance.health;			
		}
	}
}