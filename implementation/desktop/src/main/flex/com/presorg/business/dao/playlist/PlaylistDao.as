package com.presorg.business.dao.playlist
{
	import com.presorg.business.dao.GenericDao;
	import com.presorg.entity.playlist.Playlist;

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