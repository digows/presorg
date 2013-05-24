package com.presorg.domain.entity.account;

import java.io.Serializable;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.presorg.domain.entity.EntityAbstract;


/**
 * @author Rodrigo P. Fraga
 * @since 15/08/2012
 * @version 1.2
 * @category Entity
 */
@Entity
@Table(name = "USER")
public class User extends EntityAbstract implements Serializable, UserDetails
{	
	private static final long serialVersionUID = -5715887944293245071L;
	
	/*-------------------------------------------------------------------
	 *				 		     ATTRIBUTES
	 *-------------------------------------------------------------------*/
	// Basic Information
	/**
	 * 
	 */
	@NotEmpty
	@Column(nullable=false, length=144)
	private String fullName;
	/**
	 * 
	 */
	@NotEmpty
	@Column(unique=true, nullable=false, length=144)
	private String username;
	/**
	 * 
	 */
	@Column(length=144)
	private String password;
	
	/*-------------------------------------------------------------------
	 * 		 					CONSTRUCTORS
	 *-------------------------------------------------------------------*/
	/**
	 * 
	 * @param id
	 */
	public User()
	{
		super();
	}

	/**
	 * 
	 * @param id
	 */
	public User( Long id )
	{
		super( id );
	}
	
	/**
	 * 
	 * @param password
	 */
	public User( String username, String password )
	{
		super();
		this.username = username;
		this.password = password;
	}
	
	/*-------------------------------------------------------------------
	 *				 		     BEHAVIORS
	 *-------------------------------------------------------------------*/
	/**
	 * 
	 */
	public static User getAuthenticatedUser()
	{
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		if ( authentication != null && authentication.getPrincipal() instanceof User )
		{
			return (User) authentication.getPrincipal();
		}
		
		return null;
	}
	
	/* 
	 *
	 * (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result
				+ ((fullName == null) ? 0 : fullName.hashCode());
		result = prime * result
				+ ((password == null) ? 0 : password.hashCode());
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}

	/* 
	 *
	 * (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals( Object obj )
	{
		if ( this == obj )
			return true;
		if ( !super.equals(obj) )
			return false;
		if ( getClass() != obj.getClass() )
			return false;
		User other = (User) obj;
		if ( fullName == null )
		{
			if ( other.fullName != null )
				return false;
		}
		else
			if ( !fullName.equals(other.fullName) )
				return false;
		if ( password == null )
		{
			if ( other.password != null )
				return false;
		}
		else
			if ( !password.equals(other.password) )
				return false;
		if ( username == null )
		{
			if ( other.username != null )
				return false;
		}
		else
			if ( !username.equals(other.username) )
				return false;
		return true;
	}

	/*-------------------------------------------------------------------
	 *						GETTERS AND SETTERS
	 *-------------------------------------------------------------------*/
	/**
	 *
	 * @return the fullName
	 */
	public String getFullName()
	{
		return fullName;
	}

	/**
	 *
	 * @param fullName the fullName to set
	 */
	public void setFullName( String fullName )
	{
		this.fullName = fullName;
	}

	/**
	 *
	 * @return the username
	 */
	public String getUsername()
	{
		return username;
	}

	/**
	 *
	 * @param username the username to set
	 */
	public void setUsername( String username )
	{
		this.username = username;
	}

	/**
	 *
	 * @return the password
	 */
	public String getPassword()
	{
		return password;
	}

	/**
	 *
	 * @param password the password to set
	 */
	public void setPassword( String password )
	{
		this.password = password;
	}

	/* 
	 *
	 * (non-Javadoc)
	 * @see org.springframework.security.core.userdetails.UserDetails#getAuthorities()
	 */
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities()
	{
		return null;
	}

	/* 
	 *
	 * (non-Javadoc)
	 * @see org.springframework.security.core.userdetails.UserDetails#isAccountNonExpired()
	 */
	@Override
	public boolean isAccountNonExpired()
	{
		return true;
	}

	/* 
	 *
	 * (non-Javadoc)
	 * @see org.springframework.security.core.userdetails.UserDetails#isAccountNonLocked()
	 */
	@Override
	public boolean isAccountNonLocked()
	{
		return true;
	}

	/* 
	 *
	 * (non-Javadoc)
	 * @see org.springframework.security.core.userdetails.UserDetails#isCredentialsNonExpired()
	 */
	@Override
	public boolean isCredentialsNonExpired()
	{
		return true;
	}

	/* 
	 *
	 * (non-Javadoc)
	 * @see org.springframework.security.core.userdetails.UserDetails#isEnabled()
	 */
	@Override
	public boolean isEnabled()
	{
		return true;
	}
}