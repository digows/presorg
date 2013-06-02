package com.presorg.entity.music
{
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.IList;
	
	import spark.utils.TextFlowUtil;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Entity
	 */
	[Bindable]
	[RemoteClass]
	[Table(name="music")]
	public class Music
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		[Id]
		public var idLocal:Number;
		public var title:String;
		public var ocurrences:int;
		public var description:String;
		
		[OneToMany(type='com.apolloti.presorg.entity.music.Video', cascade="none", lazy='false')]
		public var videos:IList;
		[OneToMany(type='com.apolloti.presorg.entity.music.Audio', cascade="none", lazy='false')]
		public var audios:IList;
		//[OneToMany(type='com.apolloti.presorg.entity.music.Slide', cascade="none", lazy='false')]
		//public var slides:IList;

		[Transient]
		public var lyric:TextFlow = new TextFlow();
		[Transient]
		public var chords:TextFlow = new TextFlow();
		[Transient]
		public var category:Category;
		
		/*-------------------------------------------------------------------
		* 		 					 CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function Music()
		{
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		public function toString():String
		{
			return this.title;
		}
		
		/*-------------------------------------------------------------------
		* 		 				 GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */ 
		public function get categoryKey():String
		{
			if ( category )
				return this.category.key;
			
			return null;
		}
		public function set categoryKey( value:String ):void
		{
			for each ( var category:Category in Category.enums )
			{
				if ( category.key == value )
				{
					this.category = category;
					break;
				}
			}
		}
		
		/**
		 * 
		 */
		[Transient]
		public function get lyricString():String
		{
			return TextConverter.export( lyric, TextConverter.PLAIN_TEXT_FORMAT, ConversionType.STRING_TYPE ).toString();	
		}
		
		/**
		 * 
		 */
		public function get lyricContent():String
		{
			return TextConverter.export( lyric, TextConverter.TEXT_FIELD_HTML_FORMAT, ConversionType.STRING_TYPE ).toString();	
		}
		public function set lyricContent( value:String ):void
		{
			this.lyric = TextConverter.importToFlow( value, TextConverter.TEXT_FIELD_HTML_FORMAT );
		}
		
		/**
		 * 
		 */
		public function get chordsContent():String
		{
			return TextConverter.export( chords, TextConverter.TEXT_FIELD_HTML_FORMAT, ConversionType.STRING_TYPE ).toString();	
		}
		public function set chordsContent( value:String ):void
		{
			this.chords = TextConverter.importToFlow( value, TextConverter.TEXT_FIELD_HTML_FORMAT );
		}
	}
}