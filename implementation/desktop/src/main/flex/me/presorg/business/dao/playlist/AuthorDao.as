package me.presorg.business.dao.playlist
{
	import me.presorg.business.dao.GenericDao;
	import me.presorg.entity.playlist.Author;

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