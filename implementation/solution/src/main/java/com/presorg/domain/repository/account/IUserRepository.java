
package com.presorg.domain.repository.account;

import com.presorg.domain.entity.account.User;
import com.presorg.domain.repository.IDataRepository;

/**
 * @author Rodrigo P. Fraga
 * @since 02/07/2012
 * @version 1.0
 * @category Repository
 */
public interface IUserRepository extends IDataRepository<User, Long>
{
	/*-------------------------------------------------------------------
	 *				 		     BEHAVIORS
	 *-------------------------------------------------------------------*/
	/**
	 * 
	 * @return
	 */
	public User findByUsername( String username );
	/**
	 * 
	 */
	public User findById( Long id);
}