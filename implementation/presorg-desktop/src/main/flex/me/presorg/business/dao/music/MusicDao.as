package me.presorg.business.dao.music
{
	import me.presorg.business.dao.GenericDao;
	import me.presorg.entity.music.Category;
	import me.presorg.entity.music.Music;
	
	import mx.collections.IList;
	
	import nz.co.codec.flexorm.criteria.Criteria;
	import nz.co.codec.flexorm.criteria.Junction;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Dao
	 */
	public class MusicDao extends GenericDao implements IMusicDao
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function MusicDao()
		{
			super( Music );
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		
		/**
		 * 
		 */ 
		public function getMusicsByCategory( musicCategory:Category ):IList
		{
			var criteria:Criteria = entityManager.createCriteria( Music );
			criteria.addEqualsCondition("categoryKey", musicCategory.key);
			return entityManager.fetchCriteria(criteria);
		}
		
		public function getAllByFilter( filter:String ):IList
		{
			var criteria:Criteria = entityManager.createCriteria( Music );
			
			var junction:Junction = criteria.createOrJunction();
			junction.addLikeCondition("title", filter);
			junction.addLikeCondition("description", filter);
			junction.addLikeCondition("categoryKey", filter);
			junction.addLikeCondition("lyricContent", filter);
			junction.addLikeCondition("chordsContent", filter);
			
			criteria.addJunction( junction );
			
			return entityManager.fetchCriteria(criteria);
		}
	}
}