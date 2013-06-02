package com.presorg;

import org.eclipse.jetty.webapp.WebAppContext;


/**
 * 
 * @author rodrigofraga
 */
public class Server extends org.eclipse.jetty.server.Server
{
    public Server( int port )
    {
    	super( port );
    }
    
	/**
	 * 
	 * @param args
	 * @throws Exception
	 */
	public static void main(String...args) throws Exception 
	{
		final WebAppContext handler = new WebAppContext();
		handler.setResourceBase(".");
		handler.setDescriptor("WEB-INF/web.xml");
		handler.setContextPath("/");
		//handler.setParentLoaderPriority(true);

		final Server server = new Server(8080);
		server.setHandler(handler);
		server.setStopAtShutdown(true);

		server.start();
		server.join();
	}
}