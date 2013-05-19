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
	public interface IMedia
	{
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		function toString():String;
		
		/*-------------------------------------------------------------------
		* 		 				 GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */
		function get idLocal():Number;
		function set idLocal( value:Number ):void;
		
		/**
		 * 
		 */
		function get name():String;
		function set name( value:String ):void;

		/**
		 * 
		 */
		[Transient]
		function get file():File;
		function set file( value:File ):void;
		
		/**
		 * 
		 */
		[Transient]
		function get extension():String;
		
		/**
		 * 
		 */
		[Transient]
		function get path():String;
	}
}