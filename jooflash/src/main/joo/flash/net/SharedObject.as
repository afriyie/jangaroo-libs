package flash.net {
import flash.events.EventDispatcher;

/**
 * property AsyncErrorEvent.type =
 * @eventType flash.events.AsyncErrorEvent.ASYNC_ERROR
 */
[Event(name="asyncError", type="flash.events.AsyncErrorEvent")]
/**
 * property NetStatusEvent.type =
 * @eventType flash.events.NetStatusEvent.NET_STATUS
 */
[Event(name="netStatus", type="flash.events.NetStatusEvent")]
/**
 * property SyncEvent.type =
 * @eventType flash.events.SyncEvent.SYNC
 */
[Event(name="sync", type="flash.events.SyncEvent")]

/**
 * The SharedObject class is used to read and store limited amounts of data on a user's computer or on a server. Shared objects offer real-time data sharing between multiple client SWF files and objects that are persistent on the local computer or remote server. Local shared objects are similar to browser cookies and remote shared objects are similar to real-time data transfer devices. To use remote shared objects, you need Adobe Flash Media Server.
 * <p>Use shared objects to do the following:</p>
 * <ul>
 * <li><b>Maintain local persistence</b>. This is the simplest way to use a shared object, and does not require Flash Media Server. For example, you can call <code>SharedObject.getLocal()</code> to create a shared object in an application, such as a calculator with memory. When the user closes the calculator, Flash Player saves the last value in a shared object on the user's computer. The next time the calculator is run, it contains the values it had previously. Alternatively, if you set the shared object's properties to <code>null</code> before the calculator application is closed, the next time the application runs, it opens without any values. Another example of maintaining local persistence is tracking user preferences or other data for a complex website, such as a record of which articles a user read on a news site. Tracking this information allows you to display articles that have already been read differently from new, unread articles. Storing this information on the user's computer reduces server load.</li>
 * <li><b>Store and share data on Flash Media Server</b>. A shared object can store data on the server for other clients to retrieve. For example, call <code>SharedObject.getRemote()</code> to create a remote shared object, such as a phone list, that is persistent on the server. Whenever a client makes changes to the shared object, the revised data is available to all clients currently connected to the object or who later connect to it. If the object is also persistent locally, and a client changes data while not connected to the server, the data is copied to the remote shared object the next time the client connects to the object.</li>
 * <li><b>Share data in real time</b>. A shared object can share data among multiple clients in real time. For example, you can open a remote shared object that stores a list of users connected to a chat room that is visible to all clients connected to the object. When a user enters or leaves the chat room, the object is updated and all clients that are connected to the object see the revised list of chat room users.</li></ul>
 * <p>To create a local shared object, call <code>SharedObject.getLocal()</code>. To create a remote shared object, call <code>SharedObject.getRemote()</code>.</p>
 * <p>When an application closes, shared objects are <i>flushed</i>, or written to a disk. You can also call the <code>flush()</code> method to explicitly write data to a disk.</p>
 * <p><b>Local disk space considerations.</b> Local shared objects have some limitations that are important to consider as you design your application. Sometimes SWF files may not be allowed to write local shared objects, and sometimes the data stored in local shared objects can be deleted without your knowledge. Flash Player users can manage the disk space that is available to individual domains or to all domains. When users decrease the amount of disk space available, some local shared objects may be deleted. Flash Player users also have privacy controls that can prevent third-party domains (domains other than the domain in the current browser address bar) from reading or writing local shared objects.</p>
 * <p><b>Note</b>: SWF files that are stored and run on a local computer, not from a remote server, can always write third-party shared objects to disk. For more information about third-party shared objects, see the <a href="http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager03.html">Global Storage Settings panel</a> in Flash Player Help.</p>
 * <p>It's a good idea to check for failures related to the amount of disk space and to user privacy controls. Perform these checks when you call <code>getLocal()</code> and <code>flush()</code>:</p>
 * <ul>
 * <li><code>SharedObject.getLocal()</code> — Flash Player throws an exception when a call to this method fails, such as when the user has disabled third-party shared objects and the domain of your SWF file does not match the domain in the browser address bar.</li>
 * <li><code>SharedObject.flush()</code> — Flash Player throws an exception when a call to this method fails. It returns <code>SharedObjectFlushStatus.FLUSHED</code> when it succeeds. It returns <code>SharedObjectFlushStatus.PENDING</code> when additional storage space is needed. Flash Player prompts the user to allow an increase in storage space for locally saved information. Thereafter, the <code>netStatus</code> event is dispatched with an information object indicating whether the flush failed or succeeded.</li></ul>
 * <p>If your SWF file attempts to create or modify local shared objects, make sure that your SWF file is at least 215 pixels wide and at least 138 pixels high (the minimum dimensions for displaying the dialog box that prompts users to increase their local shared object storage limit). If your SWF file is smaller than these dimensions and an increase in the storage limit is required, <code>SharedObject.flush()</code> fails, returning <code>SharedObjectFlushedStatus.PENDING</code> and dispatching the <code>netStatus</code> event.</p>
 * <p><b>Remote shared objects.</b> With Flash Media Server, you can create and use remote shared objects, that are shared in real-time by all clients connected to your application. When one client changes a property of a remote shared object, the property is changed for all connected clients. You can use remote shared objects to synchronize clients, for example, users in a multi-player game.</p>
 * <p>Each remote shared object has a <code>data</code> property which is an Object with properties that store data. Call <code>setProperty()</code> to change an property of the data object. The server updates the properties, dispatches a <code>sync</code> event, and sends the properties back to the connected clients.</p>
 * <p>You can choose to make remote shared objects persistent on the client, the server, or both. By default, Flash Player saves locally persistent remote shared objects up to 100K in size. When you try to save a larger object, Flash Player displays the Local Storage dialog box, which lets the user allow or deny local storage for the shared object. Make sure your Stage size is at least 215 by 138 pixels; this is the minimum size Flash requires to display the dialog box.</p>
 * <p>If the user selects Allow, the server saves the shared object and dispatches a <code>netStatus</code> event with a <code>code</code> property of <code>SharedObject.Flush.Success</code>. If the user select Deny, the server does not save the shared object and dispatches a <code>netStatus</code> event with a <code>code</code> property of <code>SharedObject.Flush.Failed</code>.</p>
 * <p><a href="http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/SharedObject.html#includeExamplesSummary">View the examples</a></p>
 * @see #flush()
 * @see #getLocal()
 * @see #event:netStatus
 *
 */
public class SharedObject extends EventDispatcher {
  /**
   * Indicates the object on which callback methods are invoked. The default object is <code>this</code>. You can set the client property to another object, and callback methods will be invoked on that other object.
   * @throws TypeError The <code>client</code> property must be set to a non-null object.
   *
   */
  public function get client():Object {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * @private
   */
  public function set client(value:Object):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * The collection of attributes assigned to the <code>data</code> property of the object; these attributes can be shared and stored. Each attribute can be an object of any ActionScript or JavaScript type — Array, Number, Boolean, ByteArray, XML, and so on. For example, the following lines assign values to various aspects of a shared object:
   * <listing>
   *      var items_array:Array = new Array(101, 346, 483);
   *      var currentUserIsAdmin:Boolean = true;
   *      var currentUserName:String = "Ramona";
   *
   *      var my_so:SharedObject = SharedObject.getLocal("superfoo");
   *      my_so.data.itemNumbers = items_array;
   *      my_so.data.adminPrivileges = currentUserIsAdmin;
   *      my_so.data.userName = currentUserName;
   *
   *      for (var prop in my_so.data) {
   *        trace(prop+": "+my_so.data[prop]);
   *      }
   *     </listing>
   * <p>All attributes of a shared object's <code>data</code> property are saved if the object is persistent, and the shared object contains the following information:</p>
   * <listing>
   *      userName: Ramona
   *      adminPrivileges: true
   *      itemNumbers: 101,346,483
   *     </listing>
   * <p><b>Note:</b> Do not assign values directly to the <code>data</code> property of a shared object, as in <code>so.data = someValue</code>; Flash Player ignores these assignments.</p>
   * <p>To delete attributes for local shared objects, use code such as <code>delete so.data.attributeName</code>; setting an attribute to <code>null</code> or <code>undefined</code> for a local shared object does not delete the attribute.</p>
   * <p>To create <i>private</i> values for a shared object — values that are available only to the client instance while the object is in use and are not stored with the object when it is closed — create properties that are not named <code>data</code> to store them, as shown in the following example:</p>
   * <listing>
   *      var my_so:SharedObject = SharedObject.getLocal("superfoo");
   *      my_so.favoriteColor = "blue";
   *      my_so.favoriteNightClub = "The Bluenote Tavern";
   *      my_so.favoriteSong = "My World is Blue";
   *
   *      for (var prop in my_so) {
   *        trace(prop+": "+my_so[prop]);
   *      }
   *     </listing>
   * <p>The shared object contains the following data:</p>
   * <listing>
   *      favoriteSong: My World is Blue
   *      favoriteNightClub: The Bluenote Tavern
   *      favoriteColor: blue
   *      data: [object Object]
   *     </listing>
   * <p>For remote shared objects used with a server, all attributes of the <code>data</code> property are available to all clients connected to the shared object, and all attributes are saved if the object is persistent. If one client changes the value of an attribute, all clients now see the new value.</p>
   * @see #getLocal()
   *
   */
  public function get data():Object {
    return _data;
  }

  /**
   * The default object encoding (AMF version) for all local shared objects created in the SWF file. When local shared objects are written to disk, the <code>SharedObject.defaultObjectEncoding</code> property indicates which Action Message Format version should be used: the ActionScript 3.0 format (AMF3) or the ActionScript 1.0 or 2.0 format (AMF0).
   * <p>For more information about object encoding, including the difference between encoding in local and remote shared objects, see the description of the <code>objectEncoding</code> property.</p>
   * <p>The default value of <code>SharedObject.defaultObjectEncoding</code> is set to use the ActionScript 3.0 format, AMF3. If you need to write local shared objects that ActionScript 2.0 or 1.0 SWF files can read, set <code>SharedObject.defaultObjectEncoding</code> to use the ActionScript 1.0 or ActionScript 2.0 format, <code>flash.net.ObjectEncoding.AMF0</code>, at the beginning of your script, before you create any local shared objects. All local shared objects created thereafter will use AMF0 encoding and can interact with older content. You cannot change the <code>objectEncoding</code> value of existing local shared objects by setting <code>SharedObject.defaultObjectEncoding</code> after the local shared objects have been created.</p>
   * <p>To set the object encoding on a per-object basis, rather than for all shared objects created by the SWF file, set the <code>objectEncoding</code> property of the local shared object instead.</p>
   * @see #objectEncoding
   * @see ObjectEncoding
   *
   */
  public static function get defaultObjectEncoding():uint {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * @private
   */
  public static function set defaultObjectEncoding(value:uint):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Specifies the number of times per second that a client's changes to a shared object are sent to the server.
   * <p>Use this method when you want to control the amount of traffic between the client and the server. For example, if the connection between the client and server is relatively slow, you may want to set <code>fps</code> to a relatively low value. Conversely, if the client is connected to a multiuser application in which timing is important, you may want to set <code>fps</code> to a relatively high value.</p>
   * <p>Setting <code>fps</code> will trigger a <code>sync</code> event and update all changes to the server. If you only want to update the server manually, set <code>fps</code> to 0.</p>
   * <p>Changes are not sent to the server until the <code>sync</code> event has been dispatched. That is, if the response time from the server is slow, updates may be sent to the server less frequently than the value specified in this property.</p>
   */
  public function set fps(value:Number):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * The object encoding (AMF version) for this shared object. When a local shared object is written to disk, the <code>objectEncoding</code> property indicates which Action Message Format version should be used: the ActionScript 3.0 format (AMF3) or the ActionScript 1.0 or 2.0 format (AMF0).
   * <p>Object encoding is handled differently depending if the shared object is local or remote.</p>
   * <ul>
   * <li><b>Local shared objects</b>. You can get or set the value of the <code>objectEncoding</code> property for local shared objects. The value of <code>objectEncoding</code> affects what formatting is used for <i>writing</i> this local shared object. If this local shared object must be readable by ActionScript 2.0 or 1.0 SWF files, set <code>objectEncoding</code> to <code>ObjectEncoding.AMF0</code>. Even if object encoding is set to write AMF3, Flash Player can still read AMF0 local shared objects. That is, if you use the default value of this property, <code>ObjectEncoding.AMF3</code>, your SWF file can still read shared objects created by ActionScript 2.0 or 1.0 SWF files.</li>
   * <li><b>Remote shared objects</b>. When connected to the server, a remote shared object inherits its <code>objectEncoding</code> setting from the associated NetConnection instance (the instance used to connect to the remote shared object). When not connected to the server, a remote shared object inherits the <code>defaultObjectEncoding</code> setting from the associated NetConnection instance. Because the value of a remote shared object's <code>objectEncoding</code> property is determined by the NetConnection instance, this property is read-only for remote shared objects.</li></ul>
   * @throws ReferenceError You attempted to set the value of the <code>objectEncoding</code> property on a remote shared object. This property is read-only for remote shared objects because its value is determined by the associated NetConnection instance.
   *
   * @see #defaultObjectEncoding
   * @see ObjectEncoding
   *
   */
  public function get objectEncoding():uint {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * @private
   */
  public function set objectEncoding(value:uint):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * The current size of the shared object, in bytes.
   * <p>Flash calculates the size of a shared object by stepping through all of its data properties; the more data properties the object has, the longer it takes to estimate its size. Estimating object size can take significant processing time, so you may want to avoid using this method unless you have a specific need for it.</p>
   * @see http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7d80.html Shared objects
   *
   * @example The following code creates a SharedObject object using an id <code>"thehobbit"</code>. A property named <code>username</code> is added to the data property of the SharedObject object. The <code>size</code> property is then traced, which returns the value indicated.
   * <listing>
   * import flash.net.SharedObject;
   *
   * // if these get copied or not
   * var mySo:SharedObject = SharedObject.getLocal("thehobbit");
   * mySo.data.username = "bilbobaggins";
   * trace(mySo.size); // 55
   * </listing>
   */
  public function get size():uint {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * For local shared objects, purges all of the data and deletes the shared object from the disk. The reference to the shared object is still active, but its data properties are deleted.
   * <p>For remote shared objects used with Flash Media Server, <code>clear()</code> disconnects the object and purges all of the data. If the shared object is locally persistent, this method also deletes the shared object from the disk. The reference to the shared object is still active, but its data properties are deleted.</p>
   * @example The following code creates (and on subsequent executions, retrieves) a SharedObject object using an id with the value of <code>hostName</code>. A property named <code>username</code> is added to the data property of the SharedObject object. The <code>clear()</code> method is finally called, which wipes out all information that was added to the data object (in this case was a single property named <code>username</code>).
   * <listing>
   * package {
   *     import flash.net.SharedObject;
   *
   *     public class SharedObject_clear {
   *         private var hostName:String = "yourDomain";
   *         private var username:String = "yourUsername";
   *
   *         public function SharedObject_clear() {
   *             var mySo:SharedObject = SharedObject.getLocal(hostName);
   *             if(mySo.data.username == null) {
   *                 mySo.data.username = username;
   *                 trace("set: " + mySo.data.username); // yourUsername
   *             }
   *             else {
   *                 mySo.clear();
   *                 trace("cleared: " + mySo.data.username); // undefined
   *             }
   *         }
   *     }
   * }
   * </listing>
   */
  public function clear():void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Closes the connection between a remote shared object and the server. If a remote shared object is locally persistent, the user can make changes to the local copy of the object after this method is called. Any changes made to the local object are sent to the server the next time the user connects to the remote shared object.
   */
  public function close():void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Connects to a remote shared object on a server through a specified NetConnection object. Use this method after calling <code>getRemote()</code>. When a connection is successful, the <code>sync</code> event is dispatched.
   * <p>Before attempting to work with a remote shared object, first check for any errors using a <code>try..catch..finally</code> statement. Then, listen for and handle the <code>sync</code> event before you make changes to the shared object. Any changes made locally — before the <code>sync</code> event is dispatched — might be lost.</p>
   * <p>Call the <code>connect()</code> method to connect to a remote shared object, for example:</p>
   * <listing>
   *      var myRemoteSO:SharedObject = SharedObject.getRemote("mo", myNC.uri, false);
   *      myRemoteSO.connect(myNC);
   *     </listing>
   * @param myConnection A NetConnection object that uses the Real-Time Messaging Protocol (RTMP), such as a NetConnection object used to communicate with Flash Media Server.
   * @param params A string defining a message to pass to the remote shared object on the server. Cannot be used with Flash Media Server.
   *
   * @throws Error Flash Player could not connect to the specified remote shared object. Verify that the NetConnection instance is valid and connected and that the remote shared object was successfully created on the server.
   *
   * @see #getRemote()
   * @see #event:sync
   * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/statements.html#try..catch..finally try..catch..finally
   * @see NetConnection
   *
   */
  public function connect(myConnection:NetConnection, params:String = null):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Immediately writes a locally persistent shared object to a local file. If you don't use this method, Flash Player writes the shared object to a file when the shared object session ends — that is, when the SWF file is closed, when the shared object is garbage-collected because it no longer has any references to it, or when you call <code>SharedObject.clear()</code> or <code>SharedObject.close()</code>.
   * <p>If this method returns <code>SharedObjectFlushStatus.PENDING</code>, Flash Player displays a dialog box asking the user to increase the amount of disk space available to objects from this domain. To allow space for the shared object to grow when it is saved in the future, which avoids return values of <code>PENDING</code>, pass a value for <code>minDiskSpace</code>. When Flash Player tries to write the file, it looks for the number of bytes passed to <code>minDiskSpace</code>, instead of looking for enough space to save the shared object at its current size.</p>
   * <p>For example, if you expect a shared object to grow to a maximum size of 500 bytes, even though it might start out much smaller, pass 500 for <code>minDiskSpace</code>. If Flash asks the user to allot disk space for the shared object, it asks for 500 bytes. After the user allots the requested amount of space, Flash won't have to ask for more space on future attempts to flush the object (as long as its size doesn't exceed 500 bytes).</p>
   * <p>After the user responds to the dialog box, this method is called again. A <code>netStatus</code> event is dispatched with a <code>code</code> property of <code>SharedObject.Flush.Success</code> or <code>SharedObject.Flush.Failed</code>.</p>
   * @param minDiskSpace The minimum disk space, in bytes, that must be allotted for this object.
   *
   * @return Either of the following values:
   * <ul>
   * <li><code>SharedObjectFlushStatus.PENDING</code>: The user has permitted local information storage for objects from this domain, but the amount of space allotted is not sufficient to store the object. Flash Player prompts the user to allow more space. To allow space for the shared object to grow when it is saved, thus avoiding a <code>SharedObjectFlushStatus.PENDING</code> return value, pass a value for <code>minDiskSpace</code>.</li>
   * <li><code>SharedObjectFlushStatus.FLUSHED</code>: The shared object has been successfully written to a file on the local disk.</li></ul>
   *
   * @throws Error Flash Player cannot write the shared object to disk. This error might occur if the user has permanently disallowed local information storage for objects from this domain.
   * <p><b>Note:</b> Local content can always write shared objects from third-party domains (domains other than the domain in the current browser address bar) to disk, even if writing of third-party shared objects to disk is disallowed.</p>
   *
   * @see #clear()
   * @see http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7d80.html Shared objects
   *
   * @example The following code creates (and on subsequent executions, retrieves) a SharedObject object using an id with the value of <code>hostName</code>. A property named <code>username</code> is added to the data property of the SharedObject object. The <code>flush()</code> method is then called, followed by a check to see if the string <code>pending</code>, or a boolean value of <code>true</code> or <code>false</code> was returned. One should be aware that all open SharedObject instances will automatically be flushed whenever the current instance of the Flash Player is closed.
   * <listing>
   * package {
   *     import flash.net.SharedObject;
   *
   *     public class SharedObject_flush {
   *         private var hostName:String = "yourDomain";
   *         private var username:String = "yourUsername";
   *
   *         public function SharedObject_flush() {
   *             var mySo:SharedObject = SharedObject.getLocal(hostName);
   *             mySo.data.username = username;
   *             var flushResult:Object = mySo.flush();
   *             trace("flushResult: " + flushResult);
   *             trace(mySo.data.username); // yourUsername
   *         }
   *     }
   * }
   * </listing>
   */
  public function flush(minDiskSpace:int = 0):String {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Returns a reference to a locally persistent shared object that is only available to the current client. If the shared object does not already exist, this method creates one. If any values passed to <code>getLocal()</code> are invalid or if the call fails, Flash Player throws an exception.
   * <p>The following code shows how you assign the returned shared object reference to a variable:</p>
   * <p><code>var so:SharedObject = SharedObject.getLocal("savedData");</code></p>
   * <p><b>Note:</b> If the user has chosen to never allow local storage for this domain, the object is not saved locally, even if a value for <code>localPath</code> is specified. The exception to this rule is local content. Local content can always write shared objects from third-party domains (domains other than the domain in the current browser address bar) to disk, even if writing of third-party shared objects to disk is disallowed.</p>
   * <p>To avoid name conflicts, Flash looks at the location of the SWF file creating the shared object. For example, if a SWF file at www.myCompany.com/apps/stockwatcher.swf creates a shared object named <code>portfolio</code>, that shared object does not conflict with another object named <code>portfolio</code> that was created by a SWF file at www.yourCompany.com/photoshoot.swf because the SWF files originate from different directories.</p>
   * <p>Although the <code>localPath</code> parameter is optional, you should give some thought to its use, especially if other SWF files need to access the shared object. If the data in the shared object is specific to one SWF file that will not be moved to another location, then use of the default value makes sense. If other SWF files need access to the shared object, or if the SWF file that creates the shared object will later be moved, then the value of this parameter affects how accessible the shared object will be. For example, if you create a shared object with <code>localPath</code> set to the default value of the full path to the SWF file, no other SWF file can access that shared object. If you later move the original SWF file to another location, not even that SWF file can access the data already stored in the shared object.</p>
   * <p>To avoid inadvertently restricting access to a shared object, use the <code>localpath</code> parameter. The most permissive approach is to set <code>localPath</code> to <code>/</code> (slash), which makes the shared object available to all SWF files in the domain, but increases the likelihood of name conflicts with other shared objects in the domain. A more restrictive approach is to append <code>localPath</code> with folder names that are in the full path to the SWF file. For example, for a <code>portfolio</code> shared object created by the SWF file at www.myCompany.com/apps/stockwatcher.swf, you could set the <code>localPath</code> parameter to <code>/</code>, <code>/apps</code>, or <code>/apps/stockwatcher.swf</code>. You must determine which approach provides optimal flexibility for your application.</p>
   * <p>When using this method, consider the following security model:</p>
   * <ul>
   * <li>You cannot access shared objects across sandbox boundaries.</li>
   * <li>Users can restrict shared object access by using the Flash Player Settings dialog box or the Settings Manager. By default, an application can create shared objects of up 100 KB of data per domain. Administrators and users can also place restrictions on the ability to write to the file system.</li></ul>
   * <p>Suppose you publish SWF file content to be played back as local files (either locally installed SWF files or EXE files), and you need to access a specific shared object from more than one local SWF file. In this situation, be aware that for local files, two different locations might be used to store shared objects. The domain that is used depends on the security permissions granted to the local file that created the shared object. Local files can have three different levels of permissions:</p><ol>
   * <li>Access to the local filesystem only.</li>
   * <li>Access to the network only.</li>
   * <li>Access to both the network and the local filesystem.</li></ol>
   * <p>Local files with access to the local filesystem (level 1 or 3) store their shared objects in one location. Local files without access to the local filesystem (level 2) store their shared objects in another location.</p>
   * <p>You can prevent a SWF file from using this method by setting the <code>allowNetworking</code> parameter of the the <code>object</code> and <code>embed</code> tags in the HTML page that contains the SWF content.</p>
   * <p>For more information, see the Flash Player Developer Center Topic: <a href="http://www.adobe.com/go/devnet_security_en">Security</a>.</p>
   * @param name The name of the object. The name can include forward slashes (<code>/</code>); for example, <code>work/addresses</code> is a legal name. Spaces are not allowed in a shared object name, nor are the following characters:
   * <pre>  ~ % & \ ; : " ' , < > ? #
   </pre>
   * @param localPath The full or partial path to the SWF file that created the shared object, and that determines where the shared object will be stored locally. If you do not specify this parameter, the full path is used.
   * @param secure Determines whether access to this shared object is restricted to SWF files that are delivered over an HTTPS connection. If your SWF file is delivered over HTTPS, this parameter's value has the following effects:
   * <ul>
   * <li>If this parameter is set to <code>true</code>, Flash Player creates a new secure shared object or gets a reference to an existing secure shared object. This secure shared object can be read from or written to only by SWF files delivered over HTTPS that call <code>SharedObject.getLocal()</code> with the <code>secure</code> parameter set to <code>true</code>.</li>
   * <li>If this parameter is set to <code>false</code>, Flash Player creates a new shared object or gets a reference to an existing shared object that can be read from or written to by SWF files delivered over non-HTTPS connections.</li></ul>
   * <p>If your SWF file is delivered over a non-HTTPS connection and you try to set this parameter to <code>true</code>, the creation of a new shared object (or the access of a previously created secure shared object) fails and <code>null</code> is returned. Regardless of the value of this parameter, the created shared objects count toward the total amount of disk space allowed for a domain.</p>
   * <p>The following diagram shows the use of the <code>secure</code> parameter:</p>
   * <p><img src="http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/images/secureParam.jpg" /></p>
   *
   * @return A reference to a shared object that is persistent locally and is available only to the current client. If Flash Player can't create or find the shared object (for example, if <code>localPath</code> was specified but no such directory exists), this method throws an exception.
   *
   * @throws Error Flash Player cannot create the shared object for whatever reason. This error might occur is if persistent shared object creation and storage by third-party Flash content is prohibited (does not apply to local content). Users can prohibit third-party persistent shared objects on the Global Storage Settings panel of the Settings Manager, located at <a href="http://www.adobe.com/support/documentation/en/flashplayer/help/settings_manager03.html">http://www.adobe.com/support/documentation/en/flashplayer/help/settings_manager03.html</a>.
   *
   * @see http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7d80.html Shared objects
   *
   */
  public static function getLocal(name:String, localPath:String = null, secure:Boolean = false):SharedObject {
    return new SharedObject({});
    // TODO: implement correctly!
  }

  /**
   * Returns a reference to a shared object on Flash Media Server that multiple clients can access. If the remote shared object does not already exist, this method creates one.
   * <p>To create a remote shared object, call <code>getRemote()</code> the call <code>connect()</code> to connect the remote shared object to the server, as in the following:</p>
   * <listing>
   *      var nc:NetConnection = new NetConnection();
   *      nc.connect("rtmp://somedomain.com/applicationName");
   *      var myRemoteSO:SharedObject = SharedObject.getRemote("mo", nc.uri, false);
   *      myRemoteSO.connect(nc);
   *     </listing>
   * <p>To confirm that the local and remote copies of the shared object are synchronized, listen for and handle the <code>sync</code> event. All clients that want to share this object must pass the same values for the <code>name</code> and <code>remotePath</code> parameters.</p>
   * <p>To create a shared object that is available only to the current client, use <code>SharedObject.getLocal()</code>.</p>
   * @param name The name of the remote shared object. The name can include forward slashes (/); for example, work/addresses is a legal name. Spaces are not allowed in a shared object name, nor are the following characters:
   * <pre>    ~ % & \ ; :  " ' , > ? ? #</pre>
   * @param remotePath The URI of the server on which the shared object will be stored. This URI must be identical to the URI of the NetConnection object passed to the <code>connect()</code> method.
   * @param persistence Specifies whether the attributes of the shared object's data property are persistent locally, remotely, or both. This parameter can also specify where the shared object will be stored locally. Acceptable values are as follows:
   * <ul>
   * <li>A value of <code>false</code> specifies that the shared object is not persistent on the client or server.</li>
   * <li>A value of <code>true</code> specifies that the shared object is persistent only on the server.</li>
   * <li>A full or partial local path to the shared object indicates that the shared object is persistent on the client and the server. On the client, it is stored in the specified path; on the server, it is stored in a subdirectory within the application directory.</li></ul>
   * <p><b>Note:</b> If the user has chosen to never allow local storage for this domain, the object will not be saved locally, even if a local path is specified for persistence. For more information, see the class description.</p>
   * @param secure Determines whether access to this shared object is restricted to SWF files that are delivered over an HTTPS connection. For more information, see the description of the <code>secure</code> parameter in the <code>getLocal</code> method entry.
   *
   * @return A reference to an object that can be shared across multiple clients.
   *
   * @throws Error Flash Player can't create or find the shared object. This might occur if nonexistent paths were specified for the <code>remotePath</code> and <code>persistence</code> parameters.
   *
   * @see #connect()
   * @see #getLocal()
   * @see http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7d80.html Shared objects
   *
   */
  public static function getRemote(name:String, remotePath:String = null, persistence:Object = false, secure:Boolean = false):SharedObject {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Broadcasts a message to all clients connected to a remote shared object, including the client that sent the message. To process and respond to the message, create a callback function attached to the shared object.
   * @param arguments One or more arguments: A string that identifies the message, the name of one or more handler functions to attach to the shared object, and optional parameters of any type. The handler name can be only one level deep (that is, it can't be of the form parent/child) and is relative to the shared object. The arguments are serialized and sent over the connection, and the receiving handler receives them in the same order. If a parameter is a circular object (for example, a linked list that is circular), the serializer handles the references correctly.
   * <p><b>Note</b>: Do not use a reserved term for the function names. For example, <code>myRemoteSO.send("close")</code> will fail.</p>
   *
   */
  public function send(...rest):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Indicates to the server that the value of a property in the shared object has changed. This method marks properties as <i>dirty</i>, which means changed.
   * <p>Call the <code>SharedObject.setProperty()</code> to create properties for a shared object.</p>
   * <p>The <code>SharedObject.setProperty()</code> method implements <code>setDirty()</code>. In most cases, such as when the value of a property is a primitive type like String or Number, you can call <code>setProperty()</code> instead of calling <code>setDirty()</code>. However, when the value of a property is an object that contains its own properties, call <code>setDirty()</code> to indicate when a value within the object has changed.</p>
   * @param propertyName The name of the property that has changed.
   *
   * @see #data
   * @see #setProperty()
   *
   */
  public function setDirty(propertyName:String):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * Updates the value of a property in a shared object and indicates to the server that the value of the property has changed. The <code>setProperty()</code> method explicitly marks properties as changed, or dirty.
   * <p>For more information about remote shared objects see the <a href="http://www.adobe.com/go/learn_fms_docs_en">Flash Media Server documentation</a>.</p>
   * <p><b>Note:</b> The <code>SharedObject.setProperty()</code> method implements the <code>setDirty()</code> method. In most cases, such as when the value of a property is a primitive type like String or Number, you would use <code>setProperty()</code> instead of <code>setDirty</code>. However, when the value of a property is an object that contains its own properties, use <code>setDirty()</code> to indicate when a value within the object has changed. In general, it is a good idea to call <code>setProperty()</code> rather than <code>setDirty()</code>, because <code>setProperty()</code> updates a property value only when that value has changed, whereas <code>setDirty()</code> forces synchronization on all subscribed clients.</p>
   * @param propertyName The name of the property in the shared object.
   * @param value The value of the property (an ActionScript object), or <code>null</code> to delete the property.
   *
   * @see #data
   *
   */
  public function setProperty(propertyName:String, value:Object = null):void {
    throw new Error('not implemented'); // TODO: implement!
  }

  /**
   * @private
   */
  public function SharedObject(data:Object) {
    _data = data;
  }

  private var _data:Object;
}
}
