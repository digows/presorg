package com.presorg.domain.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.Repository;

import com.presorg.domain.entity.IEntity;


/**
 * 
 * @author Rodrigo P. Fraga
 * @since 01/07/2012
 * @version 1.0
 * @category Repository
 */
@NoRepositoryBean
public interface IDataRepository<Entity extends IEntity<ID>, ID extends Serializable> extends Repository<Entity, ID>
{
	//------------
	// Save
	//------------
	/**
	 * 
	 * @param entity
	 */
	public Entity insert( Entity entity );
	
	/**
	 * 
	 * @param entity
	 */
	public Entity update( Entity entity );
	
	/**
	 * 
	 * @param entity
	 * @return
	 */
	public Entity save( Entity entity );
	
	//------------
	// Remove
	//------------
	/**
	 * 
	 * @param entity
	 */
	public void remove( Entity entity );
	
	/**
	 * Deletes the entity with the given id.
	 * 
	 * @param id
	 */
	public void remove( ID id );
	
	/**
	 * 
	 * @param entities
	 */
	public void remove( List<Entity> entities );
	
	/**
	 * Deletes all entities managed by the repository.
	 */
	public void removeAll();
	
	//------------
	// Query
	//------------
	/**
	 * 
	 * @param id
	 * @param lock
	 * @return
	 */
	public Entity findById( ID id, boolean lock );
	
	//------------
	// Utility
	//------------
	/**
	 * Returns the number of entities available.
	 *
	 * @return the number of entities
	 */
	public long count();
	
	/**
	 * Returns whether an entity with the given id exists.
	 *
	 * @param id
	 * @return true if an entity with the given id exists, alse otherwise
	 * @throws IllegalArgumentException if primaryKey is {@code null}
	 */
	public boolean exists(ID id);
}