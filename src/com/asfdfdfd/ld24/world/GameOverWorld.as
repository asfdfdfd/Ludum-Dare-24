package com.asfdfdfd.ld24.world
{
	import com.asfdfdfd.ld24.Game;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class GameOverWorld extends World
	{
		public function GameOverWorld()
		{
			super();
			
			try
			{
				Game.Kongregate.scores.submit(GameWorld.Scores);
//				Game.Kongregate.scores.submit("Score", GameWorld.Scores);
			}
			catch(e:Error)
			{
			}
			
			var textGameCaption:Text = new Text("GAME OVER");
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