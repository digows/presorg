package com.presorg.business.dao
{
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Dao
	 */
	public interface IGenericDao extends IEventDispatcher
	{
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		function insert( entity:Object ):Object;
		function update( entity:Object ):Object;
		function remove( entity:Object ):void;
		function getAll():IList;
		function findById( idLocal:Number ):Object;
	}
}