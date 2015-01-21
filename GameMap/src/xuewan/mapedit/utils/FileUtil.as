package xuewan.mapedit.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import xuewan.mapedit.data.MapVO;

	public class FileUtil
	{
		private var _file:File;
		private var _loader:Loader;

		public function get data():MapVO
		{
			return _data;
		}

		public function get entityXml():XML
		{
			return _entityXml;
		}

		private var _fun:Function;
		private var _fileStream:FileStream;
		private var _mapFilePath:String = "";
		private var _entityXml:XML;
		/**
		 * 使用的正则 
		 */
		public const regex:RegExp = /^((\w)?:)?([^.]+)?(\.(\w+)?)?/; 
		/**
		 * 分隔符
		 */
		public var separator:String;
		/**
		 * 驱动器名
		 */
		public var drive:String;
		
		/**
		 * 目录数组
		 */
		public var paths:Array;
		
		/**
		 * 文件名
		 */
		public var filename:String;
		
		/**
		 * 扩展名
		 */
		public var extension:String;
		private var _data:MapVO;
		public function FileUtil(fun:Function)
		{
			_fun = fun;
		}
		public function getFilePath(v:String):void
		{
			separator = (v.indexOf("\\")!=-1) ? "\\" : "/";
			
			var data:Array = regex.exec(v);
			drive = data[2];
			paths = (data[3] as String).split(separator);
			if (paths[0]=="")
				paths.shift();
			filename = paths.pop();
			
			extension = data[5];
		}
		/**
		 * 打开文件
		 * 
		 */		
		public function openFile():void
		{
			_file = new File();
			_file.browseForOpen("open",[new FileFilter("*.jpg;*.gif;*.png","*.jpg;*.gif;*.png")]);
			_file.addEventListener(Event.SELECT,onSelectHandler);
			
		}
		private function onSelectHandler(event :Event):void
		{
			if(event.currentTarget.nativePath)
			{
				getFilePath(event.currentTarget.nativePath);
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadCompleteHandler);
				_loader.load(new URLRequest(event.currentTarget.nativePath));
			}
		}
		private function onLoadCompleteHandler(event:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoadCompleteHandler);
			_fun(event.target as LoaderInfo);
		}
		public function getBitmap(img:DisplayObject):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData(img.width,img.height,true,0xffffff);
			bitmapData.draw(img);
			return new Bitmap(bitmapData, "auto");    
		}
		public function openMap():void
		{
			var file:File = new File();
			var filter:FileFilter = new FileFilter("地图项目文件 (*.xml)","*.xml");
			
			file.addEventListener(Event.SELECT, openSelect);
			file.browseForOpen("选择要打开的文件", [filter]);
		}
		private function openSelect(event:Event):void
		{
			var uldr:URLLoader = new URLLoader();
			uldr.addEventListener(Event.COMPLETE, readFileData);
			uldr.load(new URLRequest(event.currentTarget.url));
			_mapFilePath =  String(event.currentTarget.url).slice(0,-4);
		}
		private function readFileData(event:Event):void
		{
			_data = MapFile.decode(event.currentTarget.data);
		
			_fun(null);
		}
		/**
		 * 保存文件
		 * 
		 */		
		public function saveMap(data:MapVO,entityXml:XML):void
		{
			_data = data;
			_entityXml = entityXml;
			if(_data==null)return;
			var file:File = new File();
			
			file.addEventListener(Event.SELECT, saveSelect);
			file.browseForSave("请选择保存文件的位置和文件名");
		}
		private function saveSelect(event:Event):void
		{
			_fileStream = new FileStream();
			_fileStream.open(new File(event.currentTarget.url), FileMode.WRITE);
			_fileStream.writeUTFBytes(MapFile.encode(_data,_entityXml));
			_fileStream.close();
		}
		/**
		 * 发布文件
		 * 
		 */		
		public function publishMap(data:MapVO):void
		{
			_data = data;
			_entityXml = entityXml;
			if(_data==null)return;
			var file:File = new File();
			
			file.addEventListener(Event.SELECT, publishSelect);
			file.browseForSave("请选择保存文件的位置和文件名");
		}
		private function publishSelect(event:Event):void
		{
			_fileStream = new FileStream();
			_fileStream.open(new File(event.currentTarget.url), FileMode.WRITE);
			_fileStream.writeUTFBytes(MapFile.publish(_data));
			_fileStream.close();
		}
	}
}