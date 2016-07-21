package org.varianus.ovoplayer_remote;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.Socket;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.util.Base64;

/**
 *         ref. http://www.myandroidsolutions.com/2013/03/31/android-tcp-connection-enhanced/
 *         ref. http://www.darksleep.com/player/SocketExample/
 */

/*Draft java code by "Lazarus Android Module Wizard" */
/*https://github.com/jmpessoa/lazandroidmodulewizard*/
/*jControl template*/

public class jTCPSocketClient {

    private long  pascalObj = 0;      // Pascal Object
    Controls controls;    
    private Context  context   = null;
    
    private String SERVER_IP = "" ;//"192.168.0.100"   
    private int SERVER_PORT;
       
    // message to send to the server
    private String mServerMessage;
    
    private boolean mRun = false;
    // used to send messages
    private PrintWriter mBufferOut;
    // used to read messages from the server
    private BufferedReader mBufferIn;
    private Socket mSocket;
    
    //TCPSocketClientTask task;
           	
    public jTCPSocketClient(Controls _ctrls, long _Self) { //Add more others news "_xxx" params if needed!
    	   //super(_ctrls.activity);
 	       context   = _ctrls.activity;
    	   pascalObj = _Self;
    	   controls  = _ctrls; 	
    }

    public void jFree() {
       //free local objects...
        mBufferOut= null;;
        mBufferIn= null;
        mSocket= null;    	
    }
   
    /**
     * Sends the message entered by client to the server
     */
    
    public void SendMessage(String message) {
    	
        if (mBufferOut != null && !mBufferOut.checkError()) {
            mBufferOut.print(message);
            mBufferOut.flush();
        }
       else { Log.i("OVOVOOVO_JAVA", "BUFFER OUT ERROR");}      
    }
     
    //write others [public] methods code here......
    //GUIDELINE: please, preferentially, init all yours params names with "_", ex: int _flag, String _hello ...
         
    public void Connect(String _serverIP, int _serverPort) {
    	  
          SERVER_IP = _serverIP;          //IP address
          SERVER_PORT = _serverPort;       //port number;
          Boolean connected = false;
          if (mSocket != null) {
        	  try {
				mSocket.close();
				mSocket = null;
			  } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			  }
          }
          
          try {
              InetAddress serverAddr = InetAddress.getByName(SERVER_IP);
			  mSocket = new Socket(serverAddr, SERVER_PORT);
                          connected = true;
		  } catch (IOException e) {
			  // TODO Auto-generated catch block
		      e.printStackTrace();
		  }
          if (connected) {
             new TCPSocketClientTask().execute();   
             try {
               mBufferOut = new PrintWriter(new BufferedWriter(new OutputStreamWriter(mSocket.getOutputStream())), true);
               mBufferIn = new BufferedReader(new InputStreamReader(mSocket.getInputStream()));              
	     } catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	       }
             controls.pOnTCPSocketClientConnected(pascalObj);         
          }
      }
            
     public void Connect(String _serverIP, int _serverPort, String _login) {    	  
    	 Connect(_serverIP,_serverPort);
    	 SendMessage(_login);       	  
      }
     
      public void CloseConnection(String _finalMessage) {                
          mRun = false;        
                        
          if (mBufferOut != null) {
               mBufferOut.flush();
          }
          if (_finalMessage.equals("")) 
              SendMessage("client_closed");
          else SendMessage(_finalMessage);
      }
      
      public void CloseConnection() {
      	CloseConnection("client_closed");
      }
                  
      class TCPSocketClientTask extends AsyncTask<String, String, String> {
        private  int fromByteArray(byte[] bytes) {
            return (bytes[0] & 0xFF) << 16 | (bytes[1] & 0xFF) << 8 | (bytes[2] & 0xFF);
            }
      	
          @Override
          protected String doInBackground(String... message) {               
              mRun = true;
              while (mRun) {
                    if ( mSocket!= null && !mSocket.isClosed()) {             		
                        try {                    	
    	                    //in this while the client listens for the messages sent by the server
                            if (mBufferIn != null)   {
                                char[] charSize = new char[4];
                                mServerMessage = null;
                                int readCnt = mBufferIn.read(charSize, 0, 4);
                              //   Log.i("OVOVOOVO_JAVA", "SIZE_"+String.valueOf(charSize));
                                if (readCnt  > 3) {
                                   byte[] buff = Base64.decode(String.valueOf(charSize), Base64.DEFAULT);
                                   int DataSize = fromByteArray(buff);
                               //    Log.i("OVOVOOVO_JAVA", "TO_READ_"+Integer.toString(DataSize));
                                   StringBuilder sb = new StringBuilder();
                                   int remains = DataSize;
                                   while (remains > 0) {
                                         char[] Data = new char[Math.min(remains, 2048)];
                                         readCnt = mBufferIn.read(Data, 0, Math.min(remains, 2048));
                                   //      Log.i("OVOVOOVO_JAVA", "READED_"+Integer.toString(readCnt));
                                   //      Log.i("OVOVOOVO_JAVA", "DATA_"+String.valueOf(Data));
                                         sb.append(Data, 0, readCnt);
                                         remains = remains - readCnt ;
                                      }
                                   mServerMessage =  sb.toString();
//                                   Log.i("OVOVOOVO_JAVA", "DATA_"+mServerMessage);

                                   } 
                                else 
                                   { Log.i("OVOVOOVO_JAVA", "NO_DATA_"+String.valueOf(charSize));

                                     mRun = false;
                                   }
                                }
                            else
                              { Log.e("OVOVOOVO_JAVA", "BUFFER IN ERROR");}

    	                    if (mServerMessage != null )                     	
    	                       	 publishProgress(mServerMessage);
    					} catch (IOException e) {
    						// TODO Auto-generated catch block
    						Log.e("jTCPSocketClient", "Error_doInBackground", e);
    						e.printStackTrace();
    					}                                 	                                         
               	    }        	        	             
              }
              return null;
          }

          @Override
          protected void onProgressUpdate(String... values) {
              super.onProgressUpdate(values);
              controls.pOnTCPSocketClientMessageReceived(pascalObj ,values);
          }
          
          @Override
          protected void onPostExecute(String values) {    	  
            super.onPostExecute(values);   	  
            try {                	         	   
     			mSocket.close();
     	    } catch (IOException e) {
     			// TODO Auto-generated catch block
     			e.printStackTrace();
     	    }            
          }
        }            
}


