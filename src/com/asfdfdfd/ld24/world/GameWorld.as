package com.asfdfdfd.ld24.world
{
	import com.asfdfdfd.ld24.Core;
	import com.asfdfdfd.ld24.Crosshair;
	import com.asfdfdfd.ld24.HealthTextEntity;
	import com.asfdfdfd.ld24.ScoresTextEntity;
	import com.asfdfdfd.ld24.enemies.Enemy01;
	import com.asfdfdfd.ld24.enemies.Enemy02;
	import com.asfdfdfd.ld24.enemies.Enemy03;
	import com.asfdfdfd.ld24.hero.Hero;
	
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class GameWorld extends World
	{
		public static const WIDTH:Number = 640 * 2;
		public static const HEIGHT:Number = 480 * 2;
		
		private static const ENEMY01_RESPAWN_TIME:Number = 5;
		private static const ENEMY02_RESPAWN_TIME:Number = 7;
		private static const ENEMY03_RESPAWN_TIME:Number = 20;
		
		private var _enemy01RespawnTimer:Number = 0;
		private var _enemy02RespawnTimer:Number = 0;
		private var _enemy03RespawnTimer:Number = 0;
		
		public static var HeroInstance:Hero;
		public static var CoreInstance:Core;
		
		public static var Scores:uint = 0;
		
		public function GameWorld()
		{
			super();
				
			Scores = 0;
			
			CoreInstance = new Core(WIDTH / 2 - Core.WIDTH / 2, HEIGHT / 2 - Core.HEIGHT / 2);
			add(CoreInstance);
				
			HeroInstance = new Hero(WIDTH / 2 - Hero.WIDTH / 2, HEIGHT / 2 - Hero.HEIGHT / 2);
			add(HeroInstance);
			
			add(new HealthTextEntity(0, 0));
			
			add(new ScoresTextEntity(FP.screen.width - 150, 0));
		}
		
		override public function update():void
		{
			super.update();
			
//			checkGunTypeSwitch();
			
			checkEnemy01Respawn();
			
			if (CoreInstance.level >= 2)
				checkEnemy02Respawn();
			
			if (CoreInstance.level >= 3)
				checkEnemy03Respawn();			
		}
		
		private function checkGunTypeSwitch():void
		{
			if (Input.check(Key.NUMPAD_1))
				HeroInstance.gunType = 1;
			
			if (Input.check(Key.NUMPAD_2))
				HeroInstance.gunType = 2;		
			
			if (Input.check(Key.NUMPAD_3))
				HeroInstance.gunType = 3;	
			
			if (Input.check(Key.NUMPAD_4))
				HeroInstance.gunType = 4;			
		}
		
		private function checkEnemy01Respawn():void
		{
			if (_enemy01RespawnTimer <= 0)
			{					
				respawnEnemy01();
				
				if (CoreInstance.level == 2)
					respawnEnemy01();
				
				_enemy01RespawnTimer = ENEMY01_RESPAWN_TIME;
			}
			else
			{
				_enemy01RespawnTimer -= FP.elapsed;
			}			
		}
		
		private function respawnEnemy01():void
		{
			var rndPoint:Point = getRandomEnemyPosition();
			add(new Enemy01(rndPoint.x, rndPoint.y));
		}
		
		private function getRandomEnemyPosition():Point
		{
			var rndWidth:Number = 0;
			var rndHeight:Number = 0;
			
			while (true)
			{
				rndWidth =  Math.random() * WIDTH;
				
				if (rndWidth <= 200 || rndWidth >= WIDTH - 200)
					rndHeight = Math.random() * HEIGHT;
				else
					rndHeight = (Math.random() * 10 >= 5) ? Math.random() * 100 : (HEIGHT - Math.random() * 100); 
				
				if (Point.distance(new Point(HeroInstance.x, HeroInstance.y), new Point(rndWidth, rndHeight)) >= 200)
					break;
			}
			
			return new Point(rndWidth, rndHeight);
		}
		
		private function checkEnemy02Respawn():void
		{
			if (_enemy02RespawnTimer <= 0)
			{
				var rndPoint:Point = getRandomEnemyPosition();
				
				add(new Enemy02(rndPoint.x, rndPoint.y));
				
				_enemy02RespawnTimer = ENEMY02_RESPAWN_TIME;
			}
			else
			{
				_enemy02RespawnTimer -= FP.elapsed;
			}			
		}
		
		private function checkEnemy03Respawn():void
		{
			if (_enemy03RespawnTimer <= 0)
			{
				var rndPoint:Point = getRandomEnemyPosition();
				
				add(new Enemy03(rndPoint.x, rndPoint.y));
				
				_enemy03RespawnTimer = ENEMY03_RESPAWN_TIME;
			}
			else
			{
				_enemy03RespawnTimer -= FP.elapsed;
			}			
		}		
	}
}