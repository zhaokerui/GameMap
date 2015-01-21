package xuewan.mapedit.layer
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import flashk.core.DragManager;
	
	import xuewan.core.LayoutManager;
	import xuewan.mapedit.data.EntityVO;

	public class Entity extends Sprite
	{
		private var _view:EntityInfo;
		private var _data:EntityVO;
		public function Entity(data:EntityVO)
		{
			super();
			_data = data;
			if(_data==null)
			{
				this.graphics.beginFill(0);
				this.graphics.drawCircle(30,30,20);
				this.graphics.endFill();
			}else{
				var image:Bitmap=_data.copyImage();
				if(image==null)
				{
					this.graphics.beginFill(0);
					this.graphics.drawCircle(30,30,20);
					this.graphics.endFill();
				}else{
					addChild(image);
				}
			}
			this.x = 100;
			this.y = 100;
			DragManager.register(this);
			this.doubleClickEnabled=true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK,onClick);
		}

		public function get data():EntityVO
		{
			_data.x = int(this.x);
			_data.y = int(this.y);
			return _data;
		}

		public function destroy():void
		{
			if(this.parent)
				this.parent.removeChild(this);
			if(_view)
			{
				DragManager.unregister(_view);
				onClose(null);
				_view = null;
			}
			this.removeEventListener(MouseEvent.DOUBLE_CLICK,onClick);
			DragManager.unregister(this);
		}
		private function onClick(evt:MouseEvent):void
		{
			if(_view==null)
			{
				_view = new EntityInfo();
				DragManager.register(_view);
			}
			if(_view.parent==null)
			{
				GameMap.instance.topLayer.addChild(_view);
				LayoutManager.toCenter(_view);
				if(_data)
				{
					_view.txtName.text = _data.name;
					_view.txtX.text = int(this.x).toString();
					_view.txtY.text = int(this.y).toString();
				}
				_view.closeButton.addEventListener(MouseEvent.CLICK,onClose);
				_view.btnEdit.addEventListener(MouseEvent.CLICK,onEdit);
			}
		}
		private function onClose(evt:MouseEvent):void
		{
			if(_view&&_view.parent)
			{
				_view.parent.removeChild(_view);
				_view.closeButton.removeEventListener(MouseEvent.CLICK,onClose);
				_view.btnEdit.removeEventListener(MouseEvent.CLICK,onEdit);
			}
		}
		private function onEdit(evt:MouseEvent):void
		{
			this.x = int(_view.txtX.text);
			this.y = int(_view.txtY.text);
			if(_data)
			{
				_data.name = _view.txtName.text;
				_data.sortX = int(_view.txtOffsetX.text);
				_data.sortY = int(_view.txtOffsetX.text);
			}
		}
	}
}