package com.presorg.domain.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.presorg.domain.entity.account.User;
import com.presorg.domain.repository.account.IUserRepository;


/**
 * @author Rodrigo P. Fraga 
 * @since 22/11/2012
 * @version 1.0
 * @category Service
 */
@Service
@Transactional
public class AccountService implements UserDetailsService
{
	/*-------------------------------------------------------------------
	 * 		 					ATTRIBUTES
	 *-------------------------------------------------------------------*/
	//Repositories
	/**
	 * 
	 */
	@Autowired
	private IUserRepository userRepository;
	
	//
	/**
	 * 
	 */
	@Autowired
	private AuthenticationManager authenticationManager;
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
	
	/*-------------------------------------------------------------------
	 *				 		     BEHAVIORS
	 *-------------------------------------------------------------------*/
	
	
	//------------
	//Query Services
	//-------------
	/**
	 * 
	 */
	@Transactional(readOnly = true)
	public long countUsers()
	{
		return this.userRepository.count();
	}
	
	/**
	 * Method used by the Spring authentication provider component.
	 * Call the repository to see if the given username exists in
	 * the database. If it doesn't exist, throws an exception.
	 * 
	 * @param username The username to be found
	 * @return The UserDetails found
	 * @throws UsernameNotFoundException
	 */
	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername( String username ) throws UsernameNotFoundException
	{
		final User user = this.userRepository.findByUsername(username);
		
		if ( user == null )
		{
			throw new UsernameNotFoundException("Username not found.");
		}
		
		return user;
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = true)
	public User findUserById(Long id)
	{
		return this.userRepository.findById(id);
	}
}