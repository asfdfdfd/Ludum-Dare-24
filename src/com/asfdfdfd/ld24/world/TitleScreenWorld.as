package com.asfdfdfd.ld24.world
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class TitleScreenWorld extends World
	{
		public function TitleScreenWorld()
		{
			super();
			
			var textGameCaption:Text = new Text("COREVOLUTION");
			textGameCaption.size = 100;
			textGameCaption.color = 0x000000;
			textGameCaption.align = "center";
			textGameCaption.width = FP.screen.width;
			
			var entityGameCaption:Entity = new Entity(0, FP.screen.height / 2 - textGameCaption.height / 2, textGameCaption);
			add(entityGameCaption);
			
			var textClickToContinue:Text = new Text("Click to play...");
			textClickToContinue.size = 24;
			textClickToContinue.color = 0x000000;
			textClickToContinue.align = "center";
			textClickToContinue.width = FP.screen.width;
			
			var entityClickToContinue:Entity = new Entity(0, FP.screen.height - textClickToContinue.height, textClickToContinue);
			add(entityClickToContinue);
		}
		
		override public function update():void
		{
			if (Input.mousePressed)
			{
				FP.world = new GameWorld();
			}
		}
	}
}