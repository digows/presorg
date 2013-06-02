package com.presorg.business.dao.music
{
	import com.presorg.business.dao.GenericDao;
	import com.presorg.entity.music.Video;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Dao
	 */
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	public class VideoDao extends GenericDao implements IVideoDao
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function VideoDao()
		{
			super( Video );
		}
		
		/*-------------------------------------------------------------------
		* 		 					 BEHAVIORS
		*-------------------------------------------------------------------*/
		/**
		 * 
		 */ 
		override public function insert( entity:Object ):Object
		{
			//Insert into database
			Video(entity).name = Video(entity).file.name;
			super.insert( entity );
			
			this.insertFile( Video(entity) );
			return entity;
		}

		/**
		 * 
		 */ 
		override public function update( entity:Object ):Object
		{
			//First of all we remove the old file
			this.removeFile( Video(entity) );

			//Update the database
			Video(entity).name = Video(entity).file.name;
			super.update( entity );
			
			//Copy the new one.
			this.insertFile( Video(entity) );
			return entity;
		}
		
		/**
		 * 
		 */ 
		override public function remove( entity:Object ):void
		{
			super.remove( entity );
			this.removeFile( Video(entity) );
		}
		
		/**
		 * 
		 */ 
		override public function findById( idLocal:Number ):Object
		{
			var video:Video = super.findById( idLocal ) as Video;
			video.file = File.applicationStorageDirectory.resolvePath( video.path );
			return video;
		}

		/**
		 * Copy the selected file to storage path.
		 */ 
		private function insertFile( video:Video ):void
		{
			const directory:File = File.applicationStorageDirectory.resolvePath( video.path );

			video.file.addEventListener(Event.COMPLETE, 
				function( event:Event ):void
				{
					dispatchEvent( event.clone() );			
				}
			);
			
			video.file.addEventListener(IOErrorEvent.IO_ERROR, 
				function( event:IOErrorEvent ):void
				{
					dispatchEvent( event.clone() );			
				}
			);
			
			video.file.copyToAsync( directory, true );
		}

		/**
		 * Removes the file
		 */ 
		private function removeFile( video:Video ):void
		{
			const directory:File = File.applicationStorageDirectory.resolvePath( video.path );

			directory.addEventListener(IOErrorEvent.IO_ERROR, 
				function( event:IOErrorEvent ):void
				{
					dispatchEvent( event.clone() );			
				}
			);
			
			directory.deleteFileAsync();
		}
	}
}