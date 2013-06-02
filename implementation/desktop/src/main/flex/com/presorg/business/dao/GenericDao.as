package com.presorg.business.dao
{
	import flash.events.EventDispatcher;
	
	import mx.collections.IList;
	
	import nz.co.codec.flexorm.EntityManager;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Dao
	 */
	public class GenericDao extends EventDispatcher implements IGenericDao
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		protected var clazz:Class;
		
		[Inject("entityManager")]
		public var entityManager:EntityManager;
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function GenericDao( clazz:Class )
		{
			this.clazz = clazz;
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		public function insert( entity:Object ):Object
		{
			return this.entityManager.save( entity );
		}
		
		public function update( entity:Object ):Object
		{
			return this.entityManager.save( entity );
		}
		
		public function remove( entity:Object ):void
		{
			this.entityManager.remove( entity );
			
			if ( entityManager.loadItem(clazz, entity.idLocal ) )
			{
				throw new Error("Error removing entity "+clazz.toString());
			}
		}
		
		public function getAll():IList
		{
			return this.entityManager.findAll( clazz );
		}
		
		public function findById( idLocal:Number ):Object
		{
			return entityManager.loadItem(clazz, idLocal);
		}
	}
}