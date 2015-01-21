package xuewan.mapedit.layer
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import xuewan.mapedit.data.EntityVO;

	public class EntityImage extends UIComponent
	{
		private var _image:Bitmap;
		private var _data:EntityVO;
		public function EntityImage()
		{
			super();
			this.width = 145;
			this.height = 48;
			this.buttonMode=true;
			this.doubleClickEnabled=true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK,onClick);
		}
		public function addEntity(vo:EntityVO):void
		{
			_data = vo;
			if(_image&&_image.parent)
			{
				_image.parent.removeChild(_image);
			}
			_image = vo.image;
			if(_image.parent==null)
			{
				_image.scaleX *= 141 / _image.width;
				_image.scaleY *= 44 / _image.height;
				_image.x = 1;
				_image.y = 1;
				addChild(_image);
			}
		}
		private function onClick(evt:MouseEvent):void
		{
			if(_data)
				GameMap.instance.viewGame.addEntity(new Entity(_data));
		} 
		public function destroy():void
		{
			this.removeEventListener(MouseEvent.DOUBLE_CLICK,onClick);
		}
	}
}