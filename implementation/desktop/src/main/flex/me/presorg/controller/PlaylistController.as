package me.presorg.controller
{			
	import me.presorg.business.dao.music.IMusicDao;
	import me.presorg.business.dao.playlist.IAuthorDao;
	import me.presorg.business.dao.playlist.IPlaylistDao;
	import me.presorg.entity.music.Music;
	import me.presorg.entity.playlist.Playlist;
	import me.presorg.event.PresorgEvent;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectUtil;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Controller
	 */
	public class PlaylistController
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		public static const INSERT_STATE:String = "insert";
		public static const UPDATE_STATE:String = "update";
		public static const LIST_STATE:String 	= "list";
		
		//Model
		[Bindable]
		public var currentState:String;
		[Bindable]
		public var playlists:IList;
		[Bindable]
		public var musics:IList;
		
		//Controller
		[Inject]
		public var presorgController:PresorgController;
		[Inject]
		public var authorController:AuthorController;
		
		//Dao
		[Inject]
		public var musicDao:IMusicDao;
		[Inject]
		public var authorDao:IAuthorDao;
		[Inject]
		public var playlistDao:IPlaylistDao;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		private const LOG:ILogger = Log.getLogger("me.presorg.controller.PlaylistController");
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/	 	
		public function PlaylistController()
		{
		}
		
		/*-------------------------------------------------------------------
		* 		 					BEHAVIORS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */ 
		public function changeToPlaylistManager():void
		{
			this.presorgController.currentState = PresorgController.playlist_MANAGER_STATE;
			
			if ( musics == null )
				this.fillMusicsByFilter();
			
			this.authorController.fillAuthors();
			
			this.fillPlaylists();
		}
		
		/**
		 * 
		 */ 
		public function changeToAdd():void
		{
			this.currentState = INSERT_STATE;
			this.presorgController.currentState = PresorgController.playlist_MANAGER_STATE;
			this.fillMusicsByFilter();
			this.authorController.fillAuthors();
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.playlist_CHANGE_ENTITY, new Playlist()) );
		}
		
		/**
		 * 
		 */ 
		public function changeToList():void
		{
			this.fillPlaylists();
			this.presorgController.currentState = PresorgController.playlist_MANAGER_STATE;
			this.currentState = LIST_STATE;
		}
		
		/**
		 * 
		 */ 
		public function changeToUpdate( playlist:Playlist ):void
		{
			this.presorgController.currentState = PresorgController.playlist_MANAGER_STATE;
			this.currentState = UPDATE_STATE;
			
			//CallLater
			setTimeout( handler, 30 );
			function handler():void
			{
				dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.playlist_CHANGE_ENTITY, ObjectUtil.copy(playlist)) );						
			}
		}
		
		/**
		 *
		 */
		public function insertPlaylist( playlist:Playlist ):void
		{
			this.playlistDao.insert( playlist );

			//Update visually.
			if ( playlists )
			{
				this.playlists.addItem( playlist );
			}

			this.changeToUpdate( playlist );

			//Now we update the musics ocurrences
			for each ( var music:Music in playlist.musics )
			{
				music.ocurrences++;
				this.musicDao.update( music );
			}
		}
		
		/**
		 *
		 */ 
		public function updatePlaylist( playlist:Playlist ):void
		{
			var oldplaylist:Playlist = Playlist(playlistDao.findById( playlist.idLocal ));
			
			this.playlistDao.update( playlist );
			this.currentState = UPDATE_STATE;
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.playlist_CHANGE_ENTITY, playlist) );
			
			//Now we update the musics ocurrences
			var aux:Boolean;
			for each ( var m1:Music in playlist.musics )
			{
				aux = true;
				
				for each ( var m2:Music in oldplaylist.musics )
				{
					if ( m1.idLocal == m2.idLocal )
					{
						aux = false;
						break;
					}
				}
				
				if ( aux )
				{
					m1.ocurrences++;
					this.musicDao.update( m1 );
				}
			}
			
			//Update visually.
			if ( playlists )
			{
				for each ( var p:Playlist in playlists )
				{
					if ( p.idLocal == playlist.idLocal )
					{
						this.playlists.setItemAt( playlist, playlists.getItemIndex( p ) );
						break;
					}
				}
			}
		}
		
		/**
		 * 
		 */ 
		public function removePlaylist( playlist:Playlist ):void
		{
			Alert.show("Are you sure you want to remove this playlist? \nALL playlist's DATA WILL BE LOST!", "Please confirm.", Alert.YES | Alert.NO, null, closeHandler);
			
			function closeHandler( event:CloseEvent ):void
			{
				if ( event.detail == Alert.NO ) return;
				
				try
				{
					playlistDao.remove( playlist );					
				}
				catch ( error:Error )
				{
					Alert.show("We can not remove the playlist because it has been used.", "Operation Canceled.");
					return;	
				}
				
				//Now we remove visually
				if ( playlists )
				{
					playlists.removeItemAt( playlists.getItemIndex(playlist) );
				}
				
				changeToList();
			}
		}
		
		/**
		 * 
		 */ 
		public function copyMusicsToPlaylist( playlist:Playlist, musics:IList ):void
		{
			if ( playlist.musics != null && playlist.musics.length > 0 )
			{
				ArrayCollection(playlist.musics).addAll( musics );
			}
			else
			{
				playlist.musics = musics;	
			}
		}
		
		/**
		 * 
		 */ 
		public function removeMusicFromPlaylist( playlist:Playlist, music:Music ):void
		{
			playlist.musics.removeItemAt( playlist.musics.getItemIndex(music) );
		}
		
		/**
		 * 
		 */ 
		public function moveMusicToUp( playlist:Playlist, music:Music ):void
		{
			var index:int = playlist.musics.getItemIndex(music);
			
			if ( index > 0 )
			{
				playlist.musics.removeItemAt( index );
				playlist.musics.addItemAt( music, index-1);
			}
		}

		/**
		 * 
		 */ 
		public function moveMusicToDown( playlist:Playlist, music:Music ):void
		{
			var index:int = playlist.musics.getItemIndex(music);
			
			if ( index < playlist.musics.length-1 )
			{
				playlist.musics.removeItemAt( index );
				playlist.musics.addItemAt( music, index+1);
			}
		}

		/**
		 * 
		 */
		public function generatePPSFile( playlist:Playlist ):void
		{
			var lyrics:String = new String();
			for each ( var music:Music in playlist.musics )
			{
				lyrics = "\n\n"+lyrics+music.lyricString;
			}
			
			var file:File = File.desktopDirectory.resolvePath(playlist.summary+".ppt");
			var stream:FileStream = new FileStream();
			stream.addEventListener(Event.CLOSE, closeStreamHandler);
			stream.openAsync( file, FileMode.WRITE);
			stream.writeUTFBytes( lyrics );
			stream.close();
			
			
			function closeStreamHandler( event:Event ):void
			{
				file.openWithDefaultApplication();
			}
		}

		/**
		 * 
		 */
		public function fillPlaylists():void
		{
			if ( playlists == null )
			{
				this.playlists = this.playlistDao.getAll();
			}
		}

		/**
		 * 
		 */
		public function fillMusicsByFilter(filter:String=null):void
		{
			if ( filter == null || filter == "" )
				this.musics = this.musicDao.getAll();
			else
				this.musics = this.musicDao.getAllByFilter( filter );
		}
		
		/*-------------------------------------------------------------------
		* 		 				GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
	}
}