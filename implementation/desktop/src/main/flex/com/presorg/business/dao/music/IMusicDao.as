package com.presorg.business.dao.music
{
	import com.presorg.business.dao.IGenericDao;
	import com.presorg.entity.music.Category;
	
	import mx.collections.IList;
	

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Dao
	 */
	public interface IMusicDao extends IGenericDao
	{
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		function getMusicsByCategory( musicCategory:Category ):IList;
		function getAllByFilter( filter:String ):IList;
	}
}