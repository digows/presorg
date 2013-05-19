package me.presorg.controller
{			
	import me.presorg.business.dao.music.IAudioDao;
	import me.presorg.business.dao.music.IMusicDao;
	import me.presorg.business.dao.music.IVideoDao;
	import me.presorg.entity.music.Audio;
	import me.presorg.entity.music.Category;
	import me.presorg.entity.music.IMedia;
	import me.presorg.entity.music.Music;
	import me.presorg.entity.music.Video;
	import me.presorg.event.PresorgEvent;
	import me.presorg.ui.views.musicmanager.controls.ChordsEditor;
	import me.presorg.ui.views.musicmanager.controls.LyricEditor;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
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
	public class MusicController
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		public static const INSERT_STATE:String = "insert";
		public static const UPDATE_STATE:String = "update";
		public static const REMOVE_STATE:String = "remove";
		public static const LIST_STATE:String 	= "list";
		
		//Model
		[Bindable]
		public var currentState:String;
		[Bindable]
		public var categories:IList;
		[Bindable]
		public var isAudioCopying:Boolean;
		[Bindable]
		public var isVideoCopying:Boolean;
		
		//Controller
		[Inject]
		public var presorgController:PresorgController;
		
		//Dao
		[Inject]
		public var musicDao:IMusicDao;
		[Inject]
		public var audioDao:IAudioDao;
		[Inject]
		public var videoDao:IVideoDao;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		private const LOG:ILogger = Log.getLogger("me.presorg.controller.MusicController");
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/	 	
		public function MusicController()
		{
			this.categories = ObjectUtil.copy( Category.enums ) as IList;
			categories.addItemAt(new Category(0, "music.category.all"), 0);
		}
		
		/*-------------------------------------------------------------------
		* 		 					BEHAVIORS
		*-------------------------------------------------------------------*/
		
		/**
		 * 
		 */
		[PostConstruct]
		public function postConstruct():void
		{
			//Audio
			this.audioDao.addEventListener(Event.COMPLETE,
				function( event:Event ):void
				{
					isAudioCopying = false;
				}
			);
			this.audioDao.addEventListener(IOErrorEvent.IO_ERROR, 
				function( event:Event ):void
				{
					isAudioCopying = false;
					LOG.error( event.toString() );
				}
			);
			
			//Video
			this.videoDao.addEventListener(Event.COMPLETE,
				function( event:Event ):void
				{
					isVideoCopying = false;
				}
			);
			this.videoDao.addEventListener(IOErrorEvent.IO_ERROR, 
				function( event:Event ):void
				{
					isVideoCopying = false;
					LOG.error( event.toString() );
				}
			);
		}
		
		/**
		 * 
		 */ 
		public function changeToMusicManager():void
		{
			this.presorgController.currentState = PresorgController.MUSIC_MANAGER_STATE;
		}
		
		/**
		 * 
		 */ 
		public function changeToAddMusic():void
		{
			this.currentState = INSERT_STATE;
			this.presorgController.currentState = PresorgController.MUSIC_MANAGER_STATE;
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.MUSIC_CHANGE_ENTITY, new Music()) );
		}
		
		/**
		 * 
		 */ 
		public function changeToUpdate( music:Music ):void
		{
			this.currentState = UPDATE_STATE;
			this.presorgController.currentState = PresorgController.MUSIC_MANAGER_STATE;
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.MUSIC_CHANGE_ENTITY, music) );
		}
		
		/**
		 * 
		 */ 
		public function changeToList():void
		{
			this.currentState = LIST_STATE;
			this.presorgController.currentState = PresorgController.MUSIC_MANAGER_STATE;
		}
		
		/**
		 * 
		 */ 
		public function fillMusicsByCategory( musicCategory:Category ):void
		{
			if ( musicCategory == null ) return;
			
			if ( musicCategory.key == "music.category.all" )
			{
				musicCategory.musics = this.musicDao.getAll();
			}
			else
			{
				musicCategory.musics = this.musicDao.getMusicsByCategory( musicCategory );				
			}
			
			this.changeToList();
		}
		
		/**
		 * 
		 */
		public function fillMusicsByFilter(filter:String=null):void
		{
			this.changeToList();
			
			if ( filter == null || filter == "" )
				this.allMusicCategory.musics = this.musicDao.getAll();
			else
				this.allMusicCategory.musics = this.musicDao.getAllByFilter( filter );
			
			//CallLater
			setTimeout( handler, 30 );
			function handler():void
			{
				dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.MUSIC_SEARCH, filter) );						
			}
		}
		
		/**
		 *
		 */
		public function insertMusic( music:Music ):void
		{
			this.musicDao.insert( music );
			
			//Now we add visually
			if ( music.category.musics )
				music.category.musics.addItem( music );
			if ( allMusicCategory.musics )
				allMusicCategory.musics.addItem( music );
			
			this.currentState = UPDATE_STATE;
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.MUSIC_CHANGE_ENTITY, music) );
		}
		
		/**
		 *
		 */ 
		public function updateMusic( music:Music ):void
		{
			this.musicDao.update( music );
			this.currentState = UPDATE_STATE;
			this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.MUSIC_CHANGE_ENTITY, music) );
		}
		
		/**
		 *
		 */ 
		public function removeMusic( music:Music ):void
		{
			Alert.show("Are you sure you want to remove the music "+music.title+"?\nALL MUSIC'S DATA WILL BE LOST!", "Please confirm.", Alert.YES | Alert.NO, null, closeHandler);
			
			function closeHandler( event:CloseEvent ):void
			{
				if ( event.detail == Alert.NO ) return;
				
				try
				{
					musicDao.remove( music );					
				}
				catch ( error:Error )
				{
					Alert.show("We can not remove the music "+music.title+" because it has been used in playlists.", "Operation Canceled.");
					return;	
				}
				
				//Remove the audios
				for each ( var audio:Audio in music.audios )
				{
					audioDao.remove( audio );
				}
				
				//Remove the videos
				for each ( var video:Video in music.videos )
				{
					videoDao.remove( video );
				}
				
				//First of all, we remove from "All music" category;
				allMusicCategory.musics.removeItemAt( allMusicCategory.musics.getItemIndex(music) );
				//Now we remove from its category
				if ( music.category.musics )
				{
					music.category.musics.removeItemAt( music.category.musics.getItemIndex(music) );
				}
				
				this.dispatcher.dispatchEvent( new PresorgEvent(PresorgEvent.MUSIC_CHANGE_ENTITY, new Music()) );
				
				changeToList();
			}
		}
		
		/**
		 * 
		 */ 
		public function openMedia( media:IMedia ):void
		{
			if ( media is Audio )
			{
				media = Audio( audioDao.findById(media.idLocal) );				
			}
			else if ( media is Video )
			{
				media = Video( videoDao.findById(media.idLocal) );
			}
			
			media.file.openWithDefaultApplication();
		}
		
		/**
		 * 
		 */ 
		public function removeMedia( media:IMedia ):void
		{
			Alert.show("Are you sure you want to remove this file?", "Please confirm.", Alert.YES | Alert.NO, null, closeHandler);
			
			function closeHandler( event:CloseEvent ):void
			{
				if ( event.detail == Alert.NO ) return;
				
				if ( media is Audio )
				{
					audioDao.remove( media );
					Audio(media).music.audios.removeItemAt( Audio(media).music.audios.getItemIndex( media ) );
				}
				else if ( media is Video )
				{
					videoDao.remove( media );
					Video(media).music.videos.removeItemAt( Video(media).music.videos.getItemIndex( media ) );
				}				
			}
		}

		/**
		 * 
		 */ 
		public function browseToAddAudio( music:Music ):void
		{
			var audio:Audio = new Audio(NaN, music);
			audio.file = new File();
			audio.file.addEventListener(Event.SELECT, selectHandler );
			
			//TODO Add the file filter
			audio.file.browseForOpen("Select an Audio for music: "+music.title, [new FileFilter("Audio Files", "*.*;")]);
			function selectHandler( event:Event ):void
			{
				isAudioCopying = true;
				
				if ( isNaN(audio.idLocal) )
				{
					audioDao.insert( audio );
				}
				else
				{
					audioDao.update( audio );
				}
				
				if ( music.audios == null ) music.audios = new ArrayCollection();
				
				music.audios.addItem( audio );
			}
		}
		
		/**
		 * 
		 */ 
		public function browseToAddVideo( music:Music ):void
		{
			var video:Video = new Video(NaN, music);
			video.file = new File();
			video.file.addEventListener(Event.SELECT, selectHandler );
			
			//TODO Add the file filter
			video.file.browseForOpen("Select a Video for music: "+music.title, [new FileFilter("Video Files", "*.*;")]);
			function selectHandler( event:Event ):void
			{
				isVideoCopying = true;
				
				if ( isNaN(video.idLocal) )
				{
					videoDao.insert( video );
				}
				else
				{
					videoDao.update( video );
				}
				
				if ( music.videos == null ) music.videos = new ArrayCollection();
				
				music.videos.addItem( video );
			}
		}
		
		/**
		 * 
		 */ 
		public function displayLyricEditor( music:Music ):void
		{
			var lyricEditor:LyricEditor = new LyricEditor();
			lyricEditor.music = music;
			lyricEditor.height = DisplayObject(FlexGlobals.topLevelApplication).height-30;
			
			PopUpManager.addPopUp( lyricEditor, DisplayObject(FlexGlobals.topLevelApplication), true );
			PopUpManager.centerPopUp( lyricEditor );
		}
		
		/**
		 * 
		 */ 
		public function displayChordsEditor( music:Music ):void
		{
			var chordsEditor:ChordsEditor = new ChordsEditor();
			chordsEditor.music = music;
			chordsEditor.height = DisplayObject(FlexGlobals.topLevelApplication).height-30;
			
			PopUpManager.addPopUp( chordsEditor, DisplayObject(FlexGlobals.topLevelApplication), true );
			PopUpManager.centerPopUp( chordsEditor );
		}
		
		
		/*-------------------------------------------------------------------
		* 		 				GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
		public function get allMusicCategory():Category
		{
			return Category(categories.getItemAt(0));
		}
	}
}