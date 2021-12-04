package com.asfdfdfd.ld24.hero
{
	import com.asfdfdfd.ld24.Coin;
	import com.asfdfdfd.ld24.world.GameOverWorld;
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Hero extends Entity
	{
		[Embed(source='assets/hero.png')]
		private static const BITMAP_HERO:Class;
		
		public static const WIDTH:int = 32;
		public static const HEIGHT:int = 32;
		
		private static const FRICTION:Number = 4;
		
		private static const HEALTH:Number = 1000;
		
		private static const GUN_TYPES:int = 4;
		
		[Embed(source='assets/coin_pick.mp3')] private static const PICK_SOUND:Class;
		
		[Embed(source='assets/hurt.mp3')] private static const HURT_SOUND:Class;
		
		private var _pickSfx:Sfx = new Sfx(PICK_SOUND);
		
		private var _hurtSfx:Sfx = new Sfx(HURT_SOUND);
		
		private var _speed:Point = new Point();
		
		private var _gun:HeroGun = new HeroGun01();
		
		private var _angle:Number = 0;
		private var _anglePrev:Number = 0;
		
		private var _health:Number = HEALTH;
		
		private var _engine:HeroEngineEntity;
		
		private var _gunType:int = 1;
		
		public function Hero(x:Number=0, y:Number=0, toX:Number=0, toY:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, new Image(BITMAP_HERO));
			
			setHitbox(WIDTH, HEIGHT, WIDTH/2, HEIGHT/2);
			(this.graphic as Image).originX = WIDTH / 2;
			(this.graphic as Image).originY = HEIGHT / 2;
			
			type = "Hero";
			
			layer = -10;
		}
		
		override public function added():void
		{
			super.added();
			
			_engine = new HeroEngineEntity();
			
			FP.world.add(_engine);
		}
		
		public function get health():Number
		{
			return _health;
		}
		
		public function set health(value:Number):void
		{
			_health = value;
		}		
		
		public function get gunType():uint
		{
			return _gunType;	
		}
		
		public function set gunType(value:uint):void
		{
			if (value > 4)
				value = 4;
			
			if (value < 1)
				value = 1;
			
			_gunType = value;
			
			if (value == 1)
				_gun = new HeroGun01();
			
			if (value == 2)
				_gun = new HeroGun02(new Point(x-14, y-5), new Point(x+10, y-5));
			
			if (value == 3)
				_gun = new HeroGun03();		
			
			if (value == 4)
				_gun = new HeroGun04();	
			
			_gun.rotate(_angle);
		}
		
		override public function update():void
		{
			super.update();
			
			checkKeyboardControls();
			
			if (Input.mouseDown)
				shoot();				
						
			moveTo(x + _speed.x * FP.elapsed, y + _speed.y * FP.elapsed);
			
			applyXFriction();
			applyYFriction();
		
			checkCoinsCollision();
		
			adjustCamera();	
			
			_gun.update();
			
			_anglePrev = _angle;
			
			_angle = FP.angle(x, y, world.mouseX, world.mouseY) - 90;
			(this.graphic as Image).angle = _angle;
			
			_gun.rotate(_angle);
			
			_engine.x = x;
			_engine.y = y+8;
			_engine.angle = _angle;
		}
		
		private function checkCoinsCollision():void
		{
			var coin:Entity = null;
			
			do
			{	
				coin = collide("Coin", x, y);
				
				if (coin)
				{
					_pickSfx.play();
					(coin as Coin).moveToTheCore();
				}
			}
			while(coin)
						
		}
		
		private function checkKeyboardControls():void
		{
			if (Input.check(Key.A))
				_speed.x -= 10;
			
			if (Input.check(Key.D))
				_speed.x += 10;
			
			if (Input.check(Key.S))
				_speed.y += 10;
			
			if (Input.check(Key.W))
				_speed.y -= 10;			
		}
		
		private function applyXFriction():void
		{
			if (_speed.x < 0)
			{
				_speed.x += FRICTION;
				
				if (_speed.x > 0)
					_speed.x = 0;
			}
			else if (_speed.x > 0)
			{
				_speed.x -= FRICTION;
				
				if (_speed.x < 0)
					_speed.x = 0;				
			}			
		}
		
		private function applyYFriction():void
		{
			if (_speed.y < 0)
			{
				_speed.y += FRICTION;
				
				if (_speed.y > 0)
					_speed.y = 0;
			}
			else if (_speed.y > 0)
			{
				_speed.y -= FRICTION;
				
				if (_speed.y < 0)
					_speed.y = 0;				
			}			
		}
		
		private function adjustCamera():void
		{
			FP.camera.x = x - FP.screen.width / 2;
			FP.camera.y = y - FP.screen.height / 2;
			
			if (FP.camera.x < 0)
				FP.camera.x = 0;
			
			if (FP.camera.y < 0)
				FP.camera.y = 0;	
			
			if (FP.camera.x > GameWorld.WIDTH - FP.screen.width)
				FP.camera.x = GameWorld.WIDTH -  FP.screen.width;
			
			if (FP.camera.y > GameWorld.HEIGHT - FP.screen.height)
				FP.camera.y = GameWorld.HEIGHT - FP.screen.height;				
		}
		
		private function shoot():void
		{			
			_gun.shoot(x - HeroBullet.WIDTH / 2, y - HeroBullet.HEIGHT / 2, world.mouseX, world.mouseY);
		}
		
		public function damage(value:Number):void
		{
			_health -= value;
			
			_hurtSfx.play();
			
			gunType--;
			
			if (_health <= 0)
				FP.world = new GameOverWorld();
		}
	}
}