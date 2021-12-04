package com.asfdfdfd.ld24
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	public class Crosshair extends Entity
	{
		[Embed(source='assets/crosshair.png')]
		private static const BITMAP_CROSSHAIR:Class;
		
		private static const WIDTH:int = 8;
		private static const HEIGHT:int = 8;
						
		public function Crosshair(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, new Image(BITMAP_CROSSHAIR), mask);
		}
		
		override public function update():void
		{
			x = Input.mouseX - WIDTH / 2 + FP.camera.x;
			y = Input.mouseY - HEIGHT / 2 + FP.camera.y;
		}
	}
}