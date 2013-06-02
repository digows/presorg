package com.presorg.entity.playlist
{
	import mx.collections.IList;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Entity
	 */
	[Bindable]
	[RemoteClass]
	[Table(name="author")]
	public class Author
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		[Id]
		public var idLocal:Number;
		public var name:String;
		public var birthday:Date; 
		
		/*-------------------------------------------------------------------
		* 		 					 CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function Author()
		{
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
	}
}