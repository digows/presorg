package me.presorg.entity.music
{
	import flash.filesystem.File;
	
	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Entity
	 */
	[Bindable]
	[RemoteClass]
	[Table(name="audio")]
	public class Audio implements IMedia
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		public static const DIRECTORY:String = "audios";
		
		[Id]
		public var idLocal:Number;
		public var name:String;
		
		[ManyToOne]
		public var music:Music;
		
		[Transient]
		public var file:File;
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function Audio( idLocal:Number=NaN, music:Music=null )
		{
			this.idLocal = idLocal;
			this.music = music;
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		public function toString():String
		{
			return this.name;
		}
		
		/*-------------------------------------------------------------------
		* 		 				 GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */
		[Transient]
		public function get extension():String
		{
			if ( name == null ) return null;
			
			const index:int = name.lastIndexOf('.');
			
			if ( index == -1 ) return "";
			
			return name.substring( index+1 );
		}
		
		/**
		 * 
		 */
		[Transient]
		public function get path():String
		{
			if ( extension )
				return DIRECTORY+"/"+idLocal+"."+extension;
			else
				return DIRECTORY+"/"+idLocal;
		}
	}
}