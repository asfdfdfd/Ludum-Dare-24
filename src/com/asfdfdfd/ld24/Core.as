package com.asfdfdfd.ld24
{
	import com.asfdfdfd.ld24.hero.Hero;
	import com.asfdfdfd.ld24.hero.HeroBullet;
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Core extends Entity
	{
		[Embed(source='assets/core.png')]
		private static const BITMAP_CORE:Class;
		
		public static const WIDTH:int = 128;
		public static const HEIGHT:int = 128;
		
		private static const LEVEL_02_COINS:uint = 3;
		private static const LEVEL_03_COINS:uint = 15;
		
		private var _coins:int = 0;
		
		private var _textCoins:Text;
		private var _textEntityCoins:Entity;
				
		public function Core(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, new Image(BITMAP_CORE), mask);
		}
				
		override public function added():void
		{
			super.added();
			
			_textCoins = new Text("Evolution: 0");
			_textCoins.color = 0x000000;
			
			_textEntityCoins = new Entity(x + 10, y + 55, _textCoins);
			_textEntityCoins.layer = -999;
			
			FP.world.add(_textEntityCoins);			
		}
		
		public function addCoin():void
		{
			_coins++;
			
			_textCoins.text = "Evolution: " + _coins;
		}
		
		public function get level():int
		{
			if (_coins >= LEVEL_03_COINS)
				return 3;
			
			if (_coins >= LEVEL_02_COINS)
				return 2;
			
			return 1;
		}
		
		override public function update():void
		{
			super.update();
						
//			levelUp();
		}
		
		private function levelUp():void
		{
			if (Input.check(Key.RIGHT_SQUARE_BRACKET))
			{
				if (_coins < LEVEL_03_COINS)
					_coins = LEVEL_03_COINS;
			}			
		}
	}
}