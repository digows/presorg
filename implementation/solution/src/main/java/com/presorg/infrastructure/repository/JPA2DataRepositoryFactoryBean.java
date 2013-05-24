package com.presorg.infrastructure.repository;

import java.io.Serializable;

import javax.persistence.EntityManager;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.support.JpaEntityInformation;
import org.springframework.data.jpa.repository.support.JpaRepositoryFactory;
import org.springframework.data.jpa.repository.support.JpaRepositoryFactoryBean;
import org.springframework.data.repository.core.RepositoryMetadata;
import org.springframework.data.repository.core.support.RepositoryFactorySupport;

/**
 * @author Rodrigo P. Fraga 
 * @since 01/07/2012
 * @version 1.0
 * @category RepositoryFactoryBean
 */
public class JPA2DataRepositoryFactoryBean<T extends JpaRepository<S, ID>, S, ID extends Serializable> extends JpaRepositoryFactoryBean<T, S, ID>
{
	/*-------------------------------------------------------------------
	 * 		 					 BEHAVIORS
	 *-------------------------------------------------------------------*/
	/**
	 * Returns a {@link RepositoryFactorySupport}.
	 * 
	 * @param entityManager
	 * @return
	 */
	@Override
	protected RepositoryFactorySupport createRepositoryFactory( EntityManager entityManager )
	{
		return new JPA2RepositoryFactory(entityManager);
	}

	/**
	 * @author Rodrigo P. Fraga 
	 * @since 08/12/2011
	 * @version 1.0
	 * @category RepositoryFactory
	 */
	private static class JPA2RepositoryFactory extends JpaRepositoryFactory
	{
		public JPA2RepositoryFactory(EntityManager entityManager)
		{
			super(entityManager);
		}

		/**
		 * Callback to create a {@link JpaRepository} instance with the given {@link EntityManager}
		 * 
		 * @param <T>
		 * @param <ID>
		 * @param entityManager
		 * @see #getTargetRepository(RepositoryMetadata)
		 * @return
		 */
		@Override
		@SuppressWarnings({ "unchecked", "rawtypes" })
		protected <T, ID extends Serializable> JpaRepository<?, ?> getTargetRepository( RepositoryMetadata metadata, EntityManager entityManager )
		{
			JpaEntityInformation<T, Serializable> entityInformation = (JpaEntityInformation<T, Serializable>) getEntityInformation(metadata.getDomainType());
			return new JPA2DataRepository( entityInformation.getJavaType(), entityManager );
		}
		
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * org.springframework.data.repository.support.RepositoryFactorySupport#
		 * getRepositoryBaseClass()
		 */
		@Override
		protected Class<?> getRepositoryBaseClass(RepositoryMetadata metadata) 
		{
			return JPA2DataRepository.class;
		}
	}
}
