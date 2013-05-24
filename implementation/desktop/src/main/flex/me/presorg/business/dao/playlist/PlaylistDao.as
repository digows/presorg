package me.presorg.business.dao.playlist
{
	import me.presorg.business.dao.GenericDao;
	import me.presorg.entity.playlist.Playlist;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Dao
	 */
	public class PlaylistDao extends GenericDao implements IPlaylistDao
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function PlaylistDao()
		{
			super( Playlist );
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
	}
}