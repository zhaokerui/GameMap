package xuewan.mapedit.utils
{
	import xuewan.mapedit.data.EntityVO;
	import xuewan.mapedit.data.MapVO;
	import xuewan.mapedit.layer.Entity;

	public class MapFile
	{
		public function MapFile()
		{
		}
		public static function encode(data:MapVO,entityXml:XML):String
		{
			var xml:XML = new XML("<map></map>");
			xml.@name = data.name;
			xml.@type = data.mapType;
			xml.@width = data.width * data.tileWidth;
			xml.@height = data.height * data.tileHeight;
			xml.@gridWidth = data.tileWidth;
			xml.@gridHeight = data.tileHeight;
			//background
			xml.appendChild(<background />);
			xml.background.appendChild(<skin />);
			xml.background.skin.@background = data.swfPath;
			xml.background.skin.appendChild(<gridWidth />);
			xml.background.skin.gridWidth = data.tileWidth;
			xml.background.skin.appendChild(<gridHeight />);
			xml.background.skin.gridHeight = data.tileHeight;
			//objects
			xml.appendChild(<objects />);
			var ov:EntityVO;
			var node:XML;
			var len:uint=data.entity.length;
			for(var i:uint=0;i<len;i++)
			{
				ov = data.entity[i].data;
				node = new XML(<object />);
				node.@url = ov.url;
				node.@x = ov.x;
				node.@y = ov.y;
				node.@sortX = ov.sortX;
				node.@sortY = ov.sortY;
				node.@sortRotation = ov.sortRotation;
				xml.objects.appendChild(node);
			}
			//entity
			if(entityXml)
				xml.appendChild(entityXml);
			//grid
			xml.appendChild(new XML("<grid>"+data.getGridData()+"</grid>"));
			return xml.toXMLString();
		}
		public static function decode(value:String):MapVO
		{
			var xml:XML = new XML(value);
			var name:String = xml.@name;
			var w:uint = xml.@width;
			var h:uint = xml.@height;
			var tw:uint = xml.@gridWidth;
			var th:uint = xml.@gridHeight;
			var type:uint = xml.@type;
			var data:MapVO = new MapVO(name,type,w/tw,h/th,tw,th);
			data.entity=[];
			var ov:EntityVO;
			var node:XML;
			var len:uint=xml.objects.object.length();
			for(var i:uint=0;i<len;i++)
			{
				node = xml.objects.object[i];
				ov = new EntityVO();
				ov.x = node.@x;
				ov.y = node.@y;
				ov.sortX = node.@sortX;
				ov.sortX = node.@sortY;
				ov.sortRotation = node.@sortRotation;
				data.entity.push(new Entity(ov));
			}
			data.setGridData(xml.grid[0]);
			data.entityXml = xml.entity[0];
			return data;
		}
		public static function publish(data:MapVO):String
		{
			var xml:XML = new XML("<map></map>");
			xml.@name = data.name;
			xml.@width = data.width * data.tileWidth;
			xml.@height = data.height * data.tileHeight;
			xml.@gridWidth = data.tileWidth;
			xml.@gridHeight = data.tileHeight;
			//background
			xml.appendChild(<background />);
			xml.background.appendChild(<skin />);
			xml.background.skin.@background = data.swfPath;
			xml.background.skin.appendChild(<gridWidth />);
			xml.background.skin.gridWidth = data.tileWidth;
			xml.background.skin.appendChild(<gridHeight />);
			xml.background.skin.gridHeight = data.tileHeight;
			//objects
			xml.appendChild(<objects />);
			var ov:EntityVO;
			var node:XML;
			var len:uint=data.entity.length;
			for(var i:uint=0;i<len;i++)
			{
				ov = data.entity[i].data;
				node = new XML(<object />);
				node.@url = ov.url;
				node.@x = ov.x;
				node.@y = ov.y;
				node.@sortX = ov.sortX;
				node.@sortY = ov.sortY;
				node.@sortRotation = ov.sortRotation;
				xml.objects.appendChild(node);
			}
			//grid
			xml.appendChild(new XML("<grid>"+data.getGridData()+"</grid>"));
			return xml.toXMLString();
		}
	}
}