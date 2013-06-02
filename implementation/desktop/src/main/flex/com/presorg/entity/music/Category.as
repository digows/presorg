package com.presorg.entity.music
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.resources.ResourceManager;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Entity
	 */
	[RemoteClass]
	public class Category
	{
		/*-------------------------------------------------------------------
		* 		 					  ENUMS
		*-------------------------------------------------------------------*/
		public static const SPIRITUAL:Category 		= new Category(1, "music.category.spiritual");
		public static const ANIMATED:Category 		= new Category(2, "music.category.animated");
		public static const TRANSITION:Category 	= new Category(3, "music.category.transition");
		
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		public var ordinal:int;
		public var key:String;

		[Bindable]
		public var musics:IList;

		[Transient]
		public static const enums:IList = new ArrayCollection();
		
		//Static Block
		{
			enums.addItem( ANIMATED );
			enums.addItem( TRANSITION );
			enums.addItem( SPIRITUAL );
		}
		
		/*-------------------------------------------------------------------
		* 		 					 CONSTRUCTOR
		*-------------------------------------------------------------------*/
		
		/**
		 * 
		 */
		public function Category( ordinal:int=0, key:String=null )
		{
			this.key = key;
			this.ordinal = ordinal;
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */ 
		public function toString():String
		{
			return this.name;
		}
		
		/*-------------------------------------------------------------------
		* 		 				GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */
		public function get name():String
		{
			return ResourceManager.getInstance().getString("Presorg", key);
		}
	}
}