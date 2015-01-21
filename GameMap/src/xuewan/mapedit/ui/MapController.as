package xuewan.mapedit.ui
{
	import flash.events.MouseEvent;
	
	import flashk.core.DragManager;
	
	import xuewan.core.LayoutManager;
	import xuewan.mapedit.data.MapVO;

	public class MapController
	{
		private var _view:NewMap;
		public function MapController()
		{
		}
		private function init():void
		{
			if(_view==null)
			{
				_view = new NewMap();	
				DragManager.register(_view);
			}
		}
		public function show():void
		{
			init();
			if(_view.parent==null)
			{
				GameMap.instance.topLayer.addChild(_view);
				LayoutManager.toCenter(_view);
				_view.btnNew.addEventListener(MouseEvent.CLICK,onNew);
				_view.closeButton.addEventListener(MouseEvent.CLICK,onClose);
			}
			
		}
		public function close():void
		{
			if(_view&&_view.parent)
			{
				_view.parent.removeChild(_view);
				_view.btnNew.removeEventListener(MouseEvent.CLICK,onNew);
				_view.closeButton.removeEventListener(MouseEvent.CLICK,onClose);
			}
			
		}
		public function destroy():void
		{
			if(_view != null)
			{
				DragManager.unregister(_view);
				_view = null;
			}
		}
		/**
		 * 新建文件 
		 * @param evt
		 * 
		 */		
		private function onNew(evt:MouseEvent):void
		{
			var name:String = _view.txtName.text;
			var w:uint = uint(_view.txtWidth.text);
			var h:uint = uint(_view.txtHeight.text);
			var gw:uint = uint(_view.txtGridWidth.text);
			var gh:uint = uint(_view.txtGridHeight.text);
			var type:uint = 0;
			if(_view.cbType.selectedItem)
				type = uint(_view.cbType.selectedItem.value);
			var vo:MapVO = new MapVO(name,type,w,h,gw,gh);
			GameMap.instance.viewGame.initMap(vo);
			
			close();
		}
		private function onClose(evt:MouseEvent):void
		{
			close();
		}
	}
}