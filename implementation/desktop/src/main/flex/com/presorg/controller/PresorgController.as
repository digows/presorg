package com.presorg.controller
{			
	import com.presorg.beans.*;
	
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.utils.ObjectUtil;

	/**
	 * @author Rodrigo P. Fraga
	 * @since 12/02/2011
	 * @version 1.0
	 * @category Controller
	 */
	public class PresorgController
	{
		/*-------------------------------------------------------------------
		* 		 					ATTRIBUTES
		*-------------------------------------------------------------------*/
		public static const SEARCH_STATE:String = "search";
		public static const MUSIC_MANAGER_STATE:String = "musicManager";
		public static const playlist_MANAGER_STATE:String = "playlistManager";
		
		//Model
		[Bindable]
		public var currentState:String;
		
		public static const beanProviders:Array = [DaoBeans, ServiceBeans, ControllerBeans];
		
		private const LOG:ILogger = Log.getLogger("com.presorg.controller.PresorgController");
		
		/*-------------------------------------------------------------------
		* 		 					CONSTRUCTOR
		*-------------------------------------------------------------------*/	 	
		public function PresorgController()
		{
		}
		
		/*-------------------------------------------------------------------
		* 		 					BEHAVIORS
		*-------------------------------------------------------------------*/
		public function initialize():void
		{
		}
		
		public function changeToSearch():void
		{
			this.currentState = PresorgController.SEARCH_STATE;
		}
		
		/*-------------------------------------------------------------------
		*				 		     HANDLERS
		*-------------------------------------------------------------------*/
		public static function defaultFaultHandler( event:FaultEvent ):void
		{
			Alert.show( ObjectUtil.toString(event.fault) );
		}
		
		/*-------------------------------------------------------------------
		* 		 				GETTERS AND SETTERS
		*-------------------------------------------------------------------*/
	}
}