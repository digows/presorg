package com.presorg.entity.music
{
	
	
	/**
	 * @author Rodrigo P. Fraga
	 * @since 02/04/2011
	 * @version 1.0
	 * @category Entity
	 */
	public class Slide
	{	
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		[Id]
		public var idLocal:Number;
		public var text:String;
		public var background:String;
		public var position:int;
		//public var type:SlideType;
		public var music:Music;
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function Slide()
		{
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------
		* 		 				 GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
	}
}