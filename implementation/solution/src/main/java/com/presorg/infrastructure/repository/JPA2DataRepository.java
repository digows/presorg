package com.presorg.infrastructure.repository;

import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.NoResultException;

import org.springframework.data.jpa.repository.support.JpaEntityInformation;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;
import org.springframework.transaction.annotation.Transactional;

import com.presorg.domain.entity.IEntity;
import com.presorg.domain.repository.IDataRepository;


/**
 * @author Rodrigo P. Fraga 
 * @since 01/07/2012
 * @version 1.0
 * @category Repository
 */
public class JPA2DataRepository<Entity extends IEntity<ID>, ID extends Serializable> extends SimpleJpaRepository<Entity, ID> implements IDataRepository<Entity, ID>
{
	/*-------------------------------------------------------------------
	 * 		 					ATTRIBUTES
	 *-------------------------------------------------------------------*/
	/**
	 * 
	 */
	private Class<Entity> entityClass;
	
	/**
	 * 
	 */
	private final EntityManager entityManager;
	
	/**
	 * 
	 */
	private Logger LOG = Logger.getLogger(this.getClass().getName());
	
	/*-------------------------------------------------------------------
	 * 		 					CONSTRUCTORS
	 *-------------------------------------------------------------------*/
	/**
	 * 
	 */
	public JPA2DataRepository( JpaEntityInformation<Entity, ?> entityInformation, EntityManager entityManager )
	{
		super( entityInformation, entityManager );
		this.entityManager = entityManager;
		this.entityClass = entityInformation.getJavaType();
	}
	
	/**
	 * 
	 */
	public JPA2DataRepository( Class<Entity> entityClass, EntityManager entityManager )
	{
		super( entityClass, entityManager );
		this.entityManager = entityManager;
		this.entityClass = entityClass;
	}
	
	/*-------------------------------------------------------------------
	 * 		 					 BEHAVIORS
	 *-------------------------------------------------------------------*/
	//------------
	// Save
	//------------
	/**
	 *
	 */
	@Override
	@Transactional
	public Entity insert( Entity entity )
	{
		entity.setId(null);
		this.entityManager.persist(entity);
		return entity;
	}
	
	/**
	 *
	 */
	@Override
	@Transactional
	public Entity update( Entity entity )
	{
		entity = this.entityManager.merge( entity );
		return entity;
	}
	
	/**
	 * 
	 * @param entities
	 * @return
	 */
	@Override
	public Entity save( Entity entity )
	{
		return super.save( entity );
	}
	
	//------------
	// Remove
	//------------
	/**
	 * 
	 */
	@Override
	public void remove( Entity entity )
	{
		 super.delete( entity );
		 super.flush();
	}
	
	/**
	 * 
	 */
	@Override
	public void remove( ID id )
	{
		super.delete( id );
		super.flush();
	}
	
	/**
	 * 
	 */
	@Override
	public void remove( List<Entity> entities )
	{
		super.delete( entities );
		super.flush();
	}
	
	/**
	 * 
	 */
	@Override
	public void removeAll()
	{
		super.deleteAll();
	}
	
	//------------
	// Query
	//------------
	/**
	 * 
	 */
	@Override
	public Entity findById( ID id, boolean lock )
	{
		final Entity entity = (Entity) super.findOne(id);
		
		if ( lock )
		{
			this.entityManager.lock( entity, LockModeType.WRITE );
			this.entityManager.refresh( entity );
		}
		
		if ( entity == null )
		{
			LOG.log(Level.INFO, "The " + entityClass.getSimpleName()+ " was not found.");
			throw new NoResultException("The " + entityClass.getSimpleName() + " with ID: " + id + " was not found.");
		}
		
		return entity;
	}
}