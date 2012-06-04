package flashjack
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starlingBox.game.common.Input;
	
	/**
	 * @author YopSolo
	 *
	 */
	
	public class Hero extends Personnage
	{
		[Embed(source="../../media/kliff_complete_v2/kliff.xml",mimeType="application/octet-stream")]
		private const SpriteSheetXML:Class;
		[Embed(source="../../media/kliff_complete_v2/kliff.png")]
		private const SpriteSheet:Class;
		
		public function Hero()
		{
			WIDTH = 32;
			HEIGHT = 64;
			HALF_WIDTH = 16;
			HALF_HEIGHT = 32;
			_aabb = new Rectangle(0, 0, 32, 64);
			
			var texture:Texture = Texture.fromBitmap(new SpriteSheet() as Bitmap, true, true);
			var xml:XML = XML(new SpriteSheetXML);
			
			var tAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			_stand = new MovieClip(tAtlas.getTextures("stand"), 15);
			_stand.pivotX = 35;
			_stand.pivotY = 188;
			_walk = new MovieClip(tAtlas.getTextures("walk"), 15);
			_walk.pivotX = 35;
			_walk.pivotY = 187;
			_jump = new MovieClip(tAtlas.getTextures("jump"), 18);
			_jump.pivotX = 28;
			_jump.pivotY = 150;
			_jump.loop = false;
			_fall = new MovieClip(tAtlas.getTextures("fall"), 10);
			_fall.pivotX = 28;
			_fall.pivotY = 170;
			
			_anim = _stand;
			state = STAND;
			
			init();
		}
		
		override protected function init():void
		{
			state = FALL;
			_posx = Constants.HERO_DEF_X;
			_posy = Constants.HERO_DEF_Y;
			_dx = .0;
			_dy = 5.0;
			_onGround = false;
		}
		
		override protected function changeVelocity():void
		{
			if (Input.isDown(Input.KEY_RIGHT))
			{
				_dx = Constants.HERO_WALKING_SPEED;
			}
			else if (Input.isDown(Input.KEY_LEFT))
			{
				_dx = -(Constants.HERO_WALKING_SPEED);
			}
			else
			{
				_dx = 0;
			}
			
			if (_onGround && Input.isDown(Input.KEY_A))
			{
				// _anim jump
				_onGround = false;
				_dy = -(Constants.HERO_JUMPING_ABILITY);
			}
			_dy += Constants.GRAVITY;
			
			super.changeVelocity();
		}
	
	}

}