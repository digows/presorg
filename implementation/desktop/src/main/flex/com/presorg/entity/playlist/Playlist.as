package com.presorg.entity.playlist
{
	import com.presorg.entity.music.Music;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.formatters.DateFormatter;
	import mx.formatters.Formatter;
	import mx.utils.ObjectUtil;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Entity
	 */
	[Bindable]
	[RemoteClass]
	[Table(name="playlist")]
	public class Playlist
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		[Id]
		public var idLocal:Number;
		public var createdAt:Date;
		
		[ManyToOne]
		public var author:Author;
		
		[ManyToMany(type='com.apolloti.presorg.entity.music.Music', cascade="all", lazy='false')]
		public var musics:IList;
		
		/*-------------------------------------------------------------------
		* 		 					 CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function Playlist()
		{
			this.createdAt = new Date();
			this.musics = new ArrayCollection();
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------
		* 		 				 GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
		[Transient]
		public function get summary():String
		{
			const formatter:DateFormatter = new DateFormatter();
			const dataString:String = formatter.format( createdAt );
			
			if ( musics )
				return dataString +" - "+ author.name+" - Musics Selected ("+musics.length+")";
			else
				return dataString +" - "+ author.name+" - Musics Selected (0)";
		}
	}
}