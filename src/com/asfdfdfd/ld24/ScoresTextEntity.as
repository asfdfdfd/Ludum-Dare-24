package com.asfdfdfd.ld24
{
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;
	
	public class ScoresTextEntity extends Entity
	{
		private var _text:Text;
		
		public function ScoresTextEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			_text = new Text("Scores: " + GameWorld.Scores);
			_text.color = 0x000000;
			_text.scrollX = 0;
			_text.scrollY = 0;
			
			super(x, y, _text, mask);
			
			layer = -999;
		}
		
		override public function update():void
		{
			super.update();
						
			_text.text = "Scores: " + GameWorld.Scores;			
		}
	}
}