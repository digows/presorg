package com.presorg.controller
{			
	import com.presorg.business.dao.playlist.IAuthorDao;
	import com.presorg.entity.playlist.Author;
	import com.presorg.event.PresorgEvent;
	import com.presorg.ui.views.playlistmanager.AuthorForm;
	
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.PopUpManager;
	import mx.utils.ObjectUtil;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Controller
	 */
	public class AuthorController
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		public static const INSERT_STATE:String = "insert";
		public static const UPDATE_STATE:String = "update";
		
		//Model
		[Bindable]
		public var currentState:String;
		[Bindable]
		public var authors:IList;
		
		private var authorForm:AuthorForm;
		
		//Controller
		
		//Dao
		[Inject]
		public var authorDao:IAuthorDao;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		private const LOG:ILogger = Log.getLogger("com.presorg.controller.AuthorController");
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/	 	
		public function AuthorController()
		{
		}
		
		/*-------------------------------------------------------------------
		* 		 					BEHAVIORS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */ 
		public function initialize():void
		{
		}
		
		/**
		 * 
		 */ 
		public function changeToAdd():void
		{
			this.currentState = INSERT_STATE;
			
			this.authorForm = new AuthorForm();
			PopUpManager.addPopUp( authorForm, DisplayObject(FlexGlobals.topLevelApplication), true );
			PopUpManager.centerPopUp( authorForm );
			
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.AUTHOR_CHANGE_ENTITY, new Author()) );
		}
		
		/**
		 * 
		 */ 
		public function changeToUpdate( author:Author ):void
		{
			this.currentState = UPDATE_STATE;
			
			this.authorForm = new AuthorForm();
			PopUpManager.addPopUp( authorForm, DisplayObject(FlexGlobals.topLevelApplication), true );
			PopUpManager.centerPopUp( authorForm );
			
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.AUTHOR_CHANGE_ENTITY, ObjectUtil.copy(author)) );
		}
		
		/**
		 *
		 */
		public function insertAuthor( author:Author ):void
		{
			this.authorDao.insert( author );
			
			if ( authors )
				this.authors.addItem( author );
			
			PopUpManager.removePopUp( authorForm );
			
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.AUTHOR_ADDED, author) );
		}
		
		/**
		 *
		 */ 
		public function updateAuthor( author:Author ):void
		{
			this.authorDao.update( author );
			
			for each ( var a:Author in authors )
			{
				if ( a.idLocal == author.idLocal )
				{
					this.authors.setItemAt( author, authors.getItemIndex(a) );
					break;
				}
			}
			
			PopUpManager.removePopUp( authorForm );
		}
		
		/**
		 *
		 */ 
		public function removeAuthor( author:Author ):void
		{
			Alert.show("Are you sure you want to remove the author "+author.name+"?\nALL AUTHOR'S DATA WILL BE LOST!", "Please confirm.", Alert.YES | Alert.NO, null, closeHandler);
			
			function closeHandler( event:CloseEvent ):void
			{
				if ( event.detail == Alert.YES )
				{
					try
					{
						authorDao.remove( author );
						authors.removeItemAt( authors.getItemIndex(author) );
					}
					catch( error:Error )
					{
						Alert.show("We can not remove the author "+author.name+" because it has been used in playlists.", "Operation Canceled.");
						return;
					}
				}
			}
		}
		
		/**
		 * 
		 */
		public function fillAuthors():void
		{
			if ( authors == null )
			{
				this.authors = this.authorDao.getAll();	
			}
		}
		
		/*-------------------------------------------------------------------
		* 		 				GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
	}
}