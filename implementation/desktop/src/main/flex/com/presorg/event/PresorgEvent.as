package com.presorg.event
{
	import flash.events.Event;
	
	import mx.utils.DescribeTypeCache;
	import mx.utils.ObjectUtil;
	
	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Event
	 */
	public dynamic class PresorgEvent extends Event
	{
		/*-------------------------------------------------------------------
		* 		 					EVENTS
		*-------------------------------------------------------------------*/
		public static const MUSIC_CHANGE_ENTITY:String 		= "Music.changeEntity";
		public static const MUSIC_SEARCH:String 		= "Music.search";
		
		public static const AUTHOR_CHANGE_ENTITY:String 	= "Author.changeEntity";
		public static const AUTHOR_ADDED:String 			= "Author.added";
		
		public static const playlist_CHANGE_ENTITY:String 	= "playlist.changeEntity";
		public static const playlist_REMOVE_MUSIC:String 	= "playlist.removeMusic";
		public static const playlist_MOVE_MUSIC_UP:String 	= "playlist.moveMusicUp";
		public static const playlist_MOVE_MUSIC_DOWN:String = "playlist.moveMusicDown";
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function PresorgEvent( type:String, data:Object=null )
		{
			super(type, false, false);
			
			if ( data == null ) return;
			
			//Now we create dynamically the atributtes in the event instance
			if ( ObjectUtil.isDynamicObject(data) )
			{
				for ( var field:String in data )
				{
					this[field] = data[field];
				}				
			}
			else
			{
				this["data"] = data;
			}
		}
		
		/*-------------------------------------------------------------------
		* 		 					BEHAVIORS
		*-------------------------------------------------------------------*/
	}
}