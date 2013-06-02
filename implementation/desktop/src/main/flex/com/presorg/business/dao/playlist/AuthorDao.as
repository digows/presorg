package com.presorg.business.dao.playlist
{
	import com.presorg.business.dao.GenericDao;
	import com.presorg.entity.playlist.Author;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Dao
	 */
	public class AuthorDao extends GenericDao implements IAuthorDao
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function AuthorDao()
		{
			super( Author );
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
	}
}