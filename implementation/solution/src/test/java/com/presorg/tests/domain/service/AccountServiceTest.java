package com.presorg.tests.domain.service;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.presorg.domain.entity.account.User;
import com.presorg.domain.service.AccountService;
import com.presorg.tests.AbstractTest;

/**
 * @author Rodrigo P. Fraga
 * @since 23/11/2012
 * @version 1.0
 * @category Test
 */
public class AccountServiceTest extends AbstractTest
{
	/*-------------------------------------------------------------------
	 * 		 					ATTRIBUTES
	 *-------------------------------------------------------------------*/
	//Service
	/**
	 * 
	 */
	@Autowired
	private AccountService accountService;
	
	/*-------------------------------------------------------------------
	 * 		 					  	TESTS
	 *-------------------------------------------------------------------*/
	/**
	 * 
	 */
	@Test
	public void loadUserByUsername() 
	{
		final User user = (User) this.accountService.loadUserByUsername("admin");
		Assert.assertNotNull(user);
		
		System.out.println(user);
	}
}