package com.asfdfdfd.ld24
{
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	
	import com.asfdfdfd.ld24.world.GameWorld;
	import com.asfdfdfd.ld24.world.TitleScreenWorld;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	[SWF(width="800", height="600")]
	public class Game extends Engine
	{
		public static var Kongregate:*;
		
		public function Game()
		{
			super(800, 600);
			
//			FP.console.enable();
			FP.screen.color = 0xF1F0F6;
			
			loadKongregateAPI();
		}
		
		private function loadKongregateAPI():void
		{
			var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
			 
			var apiPath:String = paramObj.kongregate_api_path || 
				"http://www.kongregate.com/flash/API_AS3_Local.swf";
			
			Security.allowDomain(apiPath);
			
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);
		}
		
		private function loadComplete(event:Event):void
		{
			// Save Kongregate API reference
			Kongregate = event.target.content;
			
			// Connect to the back-end
			Kongregate.services.connect();
			
//			Kongregate.services.resizeGame(800, 600);
			
			FP.world = new TitleScreenWorld();
		}		
	}
}