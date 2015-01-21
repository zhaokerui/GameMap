package xuewan.mapedit.layer
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import xuewan.mapedit.data.MapVO;

	public class EntityLayer extends Sprite
	{
		private var _data:MapVO;
		public function EntityLayer(data:MapVO)
		{
			super();
			_data = data;
		}
		/**
		 * 添加物品
		 * @param pt
		 * 
		 */		
		public function addEntity(vo:Entity):void
		{
			if(visible)
			{
				if(vo.parent==null)
				{
					this.addChild(vo);
					_data.entity.push(vo);
				}
			}
		}
		/**
		 * 删除物品
		 * @param index
		 */		
		public function removeEntity(vo:Entity):void
		{
			var len:uint=_data.entity.length;
			for(var i:int = 0 ; i <= len ; i++)
			{
				if(_data.entity[i]==vo)
				{
					_data.entity[i].destroy();
					_data.entity.splice(i,1);
					break;
				}
			}
		}
		public function destroy():void
		{
			var len:uint=_data.entity.length;
			for(var i:int = 0 ; i <= len ; i++)
			{
				_data.entity.pop().destroy();
			}
		}
	}
}