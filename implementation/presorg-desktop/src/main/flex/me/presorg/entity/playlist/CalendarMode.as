package me.presorg.entity.playlist
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	/**
	 * @author Rodrigo P. Fraga (rodrigo@apollo-ti.com)
	 * @since 23/07/2009
	 * @version 1.0
	 * @category Enum
	 */
	[Bindable]
	public class CalendarMode
	{
		/*-------------------------------------------------------------------
	 	* 		 				 	ATTRIBUTES
	 	*-------------------------------------------------------------------*/
	 	public static const DAY:String = "day";
	 	public static const WEEK:String = "week";
	 	public static const MONTH:String = "month";

		public static const values:IList = new ArrayCollection();
			
		//Static Block
		{
	 		values.addItem( DAY );
	 		values.addItem( WEEK );
	 		values.addItem( MONTH );
		}
		
		/*-------------------------------------------------------------------
	 	* 		 				 	CONSTRUCTOR
	 	*-------------------------------------------------------------------*/
	 	
		/*-------------------------------------------------------------------
	 	* 		 				 	BEHAVIORS
	 	*-------------------------------------------------------------------*/
	 	
		/*-------------------------------------------------------------------
	 	* 		 				 	HANDLERS
	 	*-------------------------------------------------------------------*/
	 	
		/*-------------------------------------------------------------------
	 	* 		 				 GETTERS AND SETTERS
	 	*-------------------------------------------------------------------*/
	}
}