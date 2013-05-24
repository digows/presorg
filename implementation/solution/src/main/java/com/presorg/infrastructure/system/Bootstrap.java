package com.presorg.infrastructure.system;

import java.util.logging.Logger;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.authentication.encoding.PasswordEncoder;

import com.presorg.domain.entity.account.User;
import com.presorg.domain.repository.account.IUserRepository;


/**
 * @author Rodrigo P. Fraga
 * @since 22/11/2012
 * @version 1.0
 * @category Bootstrap
 */
public class Bootstrap
{
	/**
	 * 
	 */
	private static final Logger LOG = Logger.getLogger(Bootstrap.class.getName());
	
	/*-------------------------------------------------------------------
	 *				 		     ATTRIBUTES
	 *-------------------------------------------------------------------*/
	
	/**
	 * 
	 */
	@Autowired
	private PasswordEncoder passwordEncoder;
	/**
	 * 
	 */
	@Autowired
	private SaltSource saltSource;
	
	//Repositories
	/**
	 * 
	 */
	@Autowired
	private IUserRepository userRepository;

	/*-------------------------------------------------------------------
	 *				 		     BEHAVIORS
	 *-------------------------------------------------------------------*/
	/**
	 * @throws Exception 
	 * 
	 */
	@PostConstruct
	public void postConstruct() throws Exception 
	{
		//now, we verify the default users.
		if ( this.userRepository.count() == 0 )
		{
			LOG.info("Bootstraping users...");

			User user = new User(1L);
			user.setUsername("admin");
			user.setPassword( this.passwordEncoder.encodePassword("admin", saltSource.getSalt(user) ) );
			user.setFullName("Administrador de Sistemas");
			user = this.userRepository.insert( user );
				
			LOG.info("Default users were added.");
		}
	}
}
