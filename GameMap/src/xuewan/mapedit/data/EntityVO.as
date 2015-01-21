package xuewan.mapedit.data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class EntityVO
	{
		private var _image:Bitmap;
		public var name:String="";
		public var url:String="";
		public var x:int;
		public var y:int;
		public var sortX:int;
		public var sortY:int;
		public var sortRotation:int;
		public function EntityVO()
		{
		}
		
		public function set image(value:Bitmap):void
		{
			_image = value;
		}
		
		public function get image():Bitmap
		{
			return _image;
		}
		public function copyImage():Bitmap
		{
			if(_image==null)return null;
			var bitmapData:BitmapData = new BitmapData(_image.width,_image.height,true,0xffffff);
			bitmapData.draw(_image);
			return new Bitmap(bitmapData, "auto");    
		}
	}
}