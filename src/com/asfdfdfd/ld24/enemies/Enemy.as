package com.asfdfdfd.ld24.enemies
{
	import com.asfdfdfd.ld24.Coin;
	import com.asfdfdfd.ld24.hero.Hero;
	import com.asfdfdfd.ld24.upgrades.GunUpgradeEntity;
	import com.asfdfdfd.ld24.upgrades.HealthUpgradeEntity;
	import com.asfdfdfd.ld24.world.GameWorld;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;

	public class Enemy extends Entity
	{
		[Embed(source='assets/explosion.mp3')] private static const EXPLOSION_SOUND:Class;
		
		private var _health:Number;
		
		private static const DAMAGE:Number = 300;
		
		private var _explosionSfx:Sfx = new Sfx(EXPLOSION_SOUND);
		
		[Embed(source='assets/enemy_shoot.mp3')] private static const SHOOT_SOUND:Class;
		
		protected var _shootSfx:Sfx = new Sfx(SHOOT_SOUND);
		
		public function Enemy(health:Number, x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			_health = health;
			
			type = "Enemy";
		}
		
		public function hit(value:Number):void
		{
			_health -= value;
			
			if (_health <= 0)
			{
				FP.rand(6) == 5 ? (FP.rand(2) == 0 ? FP.world.add(new GunUpgradeEntity(x, y)) : FP.world.add(new HealthUpgradeEntity(x, y))): FP.world.add(new Coin(x, y));
				
				FP.world.remove(this);
				
				GameWorld.Scores += scores;
				
				FP.world.add(new EnemyExplosionEntity(x, y));
				
				_explosionSfx.play();
			}
		}
		
		public function get scores():uint
		{
			return 0;
		}
		
		override public function update():void
		{
			var hero:Entity = collide("Hero", x, y);
			
			if (hero)
			{
				(hero as Hero).damage(DAMAGE);
				
				FP.world.remove(this);
								
				_explosionSfx.play();
				
				FP.world.add(new EnemyExplosionEntity(x, y));
			}				
		}
	}
}