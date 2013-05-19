package me.presorg.business.dao.music
{
	import me.presorg.business.dao.GenericDao;
	import me.presorg.entity.music.Audio;
	
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
	public class AudioDao extends GenericDao implements IAudioDao
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/
		public function AudioDao()
		{
			super( Audio );
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
			Audio(entity).name = Audio(entity).file.name;
			super.insert( entity );
			
			this.insertFile( Audio(entity) );
			return entity;
		}

		/**
		 * 
		 */ 
		override public function update( entity:Object ):Object
		{
			//First of all we remove the old file
			this.removeFile( Audio(entity) );

			//Update the database
			Audio(entity).name = Audio(entity).file.name;
			super.update( entity );
			
			//Copy the new one.
			this.insertFile( Audio(entity) );
			return entity;
		}
		
		/**
		 * 
		 */ 
		override public function remove( entity:Object ):void
		{
			super.remove( entity );
			this.removeFile( Audio(entity) );
		}
		
		/**
		 * 
		 */ 
		override public function findById( idLocal:Number ):Object
		{
			var audio:Audio = super.findById( idLocal ) as Audio;
			audio.file = File.applicationStorageDirectory.resolvePath( audio.path );
			return audio;
		}

		/**
		 * Copy the selected file to storage path.
		 */ 
		private function insertFile( audio:Audio ):void
		{
			const directory:File = File.applicationStorageDirectory.resolvePath( audio.path );

			audio.file.addEventListener(Event.COMPLETE, 
				function( event:Event ):void
				{
					dispatchEvent( event.clone() );			
				}
			);
			
			audio.file.addEventListener(IOErrorEvent.IO_ERROR, 
				function( event:IOErrorEvent ):void
				{
					dispatchEvent( event.clone() );			
				}
			);
			
			audio.file.copyToAsync( directory, true );
		}

		/**
		 * Removes the file
		 */ 
		private function removeFile( audio:Audio ):void
		{
			const directory:File = File.applicationStorageDirectory.resolvePath( audio.path );

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