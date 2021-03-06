package flash.media {



/**
 * The SoundLoaderContext class provides security checks for files that load sound. SoundLoaderContext objects are passed as an argument to the constructor and the <code>load()</code> method of the Sound class.
 * <p>When you use this class, consider the following security model:</p>
 * <ul>
 * <li>Loading and playing a sound is not allowed if the calling file is in a network sandbox and the sound file to be loaded is local.</li>
 * <li>By default, loading and playing a sound is not allowed if the calling is local and tries to load and play a remote sound. A user must grant explicit permission to allow this.</li>
 * <li>Certain operations dealing with sound are restricted. The data in a loaded sound cannot be accessed by a file in a different domain unless you implement a URL policy file. Sound-related APIs that fall under this restriction are the <code>Sound.id3</code> property and the <code>SoundMixer.computeSpectrum()</code>, <code>SoundMixer.bufferTime</code>, and <code>SoundTransform()</code> methods.</li></ul>
 * <p>However, in Adobe AIR, content in the <code>application</code> security sandbox (content installed with the AIR application) are not restricted by these security limitations.</p>
 * <p>For more information related to security, see the Flash Player Developer Center Topic: <a href="http://www.adobe.com/go/devnet_security_en">Security</a>.</p>
 */
public class SoundLoaderContext {
  /**
   * The number of milliseconds to preload a streaming sound into a buffer before the sound starts to stream.
   * <p>Note that you cannot override the value of <code>SoundLoaderContext.bufferTime</code> by setting the global <code>SoundMixer.bufferTime</code> property. The <code>SoundMixer.bufferTime</code> property affects the buffer time for embedded streaming sounds in a SWF file and is independent of dynamically created Sound objects (that is, Sound objects created in ActionScript).</p>
   */
  public var bufferTime:Number = 1000;
  /**
   * Specifies whether the application should try to download a URL policy file from the loaded sound's server before beginning to load the sound. This property applies to sound that is loaded from outside the calling file's own domain using the <code>Sound.load()</code> method.
   * <p>Set this property to <code>true</code> when you load a sound from outside the calling file's own domain and code in the calling file needs low-level access to the sound's data. Examples of low-level access to a sound's data include referencing the <code>Sound.id3</code> property to get an ID3Info object or calling the <code>SoundMixer.computeSpectrum()</code> method to get sound samples from the loaded sound. If you try to access sound data without setting the <code>checkPolicyFile</code> property to <code>true</code> at loading time, you may get a SecurityError exception because the required policy file has not been downloaded.</p>
   * <p>If you don't need low-level access to the sound data that you are loading, avoid setting <code>checkPolicyFile</code> to <code>true</code>. Checking for a policy file consumes network bandwidth and might delay the start of your download, so it should only be done when necessary.</p>
   * <p>When you call <code>Sound.load()</code> with <code>SoundLoaderContext.checkPolicyFile</code> set to <code>true</code>, Flash Player or AIR must either successfully download a relevant URL policy file or determine that no such policy file exists before it begins downloading the specified sound. Flash Player or AIR performs the following actions, in this order, to verify the existence of a policy file:</p>
   * <ul>
   * <li>Flash Player or AIR considers policy files that have already been downloaded.</li>
   * <li>Flash Player or AIR tries to download any pending policy files specified in calls to <code>Security.loadPolicyFile()</code>.</li>
   * <li>Flash Player or AIR tries to download a policy file from the default location that corresponds to the sound's URL, which is <code>/crossdomain.xml</code> on the same server as <code>URLRequest.url</code>. (The sound's URL is specified in the <code>url</code> property of the URLRequest object passed to <code>Sound.load()</code> or the Sound() constructor function.)</li></ul>
   * <p>In all cases, Flash Player or AIR requires that an appropriate policy file exist on the sound's server, that it provide access to the sound file at <code>URLRequest.url</code> by virtue of the policy file's location, and that it allow the domain of the calling file to access the sound, through one or more <code><allow-access-from></code> tags.</p>
   * <p>If you set <code>checkPolicyFile</code> to <code>true</code>, Flash Player or AIR waits until the policy file is verified before loading the sound. You should wait to perform any low-level operations on the sound data, such as calling <code>Sound.id3</code> or <code>SoundMixer.computeSpectrum()</code>, until <code>progress</code> and <code>complete</code> events are dispatched from the Sound object.</p>
   * <p>If you set <code>checkPolicyFile</code> to <code>true</code> but no appropriate policy file is found, you will not receive an error until you perform an operation that requires a policy file, and then Flash Player or AIR throws a <code>SecurityError</code> exception. After you receive a <code>complete</code> event, you can test whether a relevant policy file was found by getting the value of <code>Sound.id3</code> within a <code>try</code> block and seeing if a <code>SecurityError</code> is thrown.</p>
   * <p>Be careful with <code>checkPolicyFile</code> if you are downloading sound from a URL that uses server-side HTTP redirects. Flash Player or AIR tries to retrieve policy files that correspond to the <code>url</code> property of the URLRequest object passed to <code>Sound.load()</code>. If the final sound file comes from a different URL because of HTTP redirects, then the initially downloaded policy files might not be applicable to the sound's final URL, which is the URL that matters in security decisions.</p>
   * <p>If you find yourself in this situation, here is one possible solution. After you receive a <code>progress</code> or <code>complete</code> event, you can examine the value of the <code>Sound.url</code> property, which contains the sound's final URL. Then call the <code>Security.loadPolicyFile()</code> method with a policy file URL that you calculate based on the sound's final URL. Finally, poll the value of <code>Sound.id3</code> until no exception is thrown.</p>
   * <p>This does not apply to content in the AIR application sandbox. Content in the application sandbox always has programatic access to sound content, regardless of its origin.</p>
   * <p>For more information related to security, see the Flash Player Developer Center Topic: <a href="http://www.adobe.com/go/devnet_security_en">Security</a>.</p>
   * @see Sound#load()
   * @see Sound#id3
   * @see SoundMixer#computeSpectrum()
   * @see Sound#url
   * @see flash.system.Security#loadPolicyFile()
   * @see http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7e13.html Loading display content dynamically
   * @see http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7de0.html Specifying loading context
   *
   */
  public var checkPolicyFile:Boolean = false;

  /**
   * Creates a new sound loader context object.
   * @param bufferTime The number of seconds to preload a streaming sound into a buffer before the sound starts to stream.
   * @param checkPolicyFile Specifies whether the existence of a URL policy file should be checked upon loading the object (<code>true</code>) or not.
   *
   * @example In the following example, the buffer for the sound that will be loaded is set to three seconds.
   * <p>The first parameter of a SoundLoaderContext object (<code>context</code>) is used to increase the default buffer value of one second to three seconds. (The value is in milliseconds.) If the second parameter of the SoundLoaderContext object is set to <code>true</code>, Flash Player will check for a cross-domain policy file upon loading the object. Here it is set to the default value <code>false</code>, so no policy file will be checked. The <code>load()</code> method of the sound object will use the context setting to make sure it will take three seconds to preload the streaming sound into a buffer before the sound starts to stream. The <code>URLRequest</code> object determines the location of the file, which is a podcast from Adobe. If an <code>IOErrorEvent.IO_ERROR</code> error occurs during the loading of the sound file, the <code>errorHandler()</code> method is invoked.</p>
   * <listing>
   * package {
   *     import flash.display.Sprite;
   *     import flash.net.URLRequest;
   *     import flash.media.Sound;
   *     import flash.media.SoundLoaderContext;
   *     import flash.events.IOErrorEvent;
   *
   *     public class SoundLoaderContextExample extends Sprite {
   *
   *         public function SoundLoaderContextExample() {
   *             var snd:Sound = new Sound();
   *             var req:URLRequest = new URLRequest("http://av.adobe.com/podcast/csbu_dev_podcast_epi_2.mp3");
   *             var context:SoundLoaderContext = new SoundLoaderContext(3000, false);
   *
   *             snd.load(req, context);
   *             snd.play();
   *
   *             snd.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
   *         }
   *
   *         private function errorHandler(errorEvent:IOErrorEvent):void {
   *             trace("The sound could not be loaded: " + errorEvent.text);
   *         }
   *
   *     }
   * }
   * </listing>
   */
  public function SoundLoaderContext(bufferTime:Number = 1000, checkPolicyFile:Boolean = false) {
    throw new Error('not implemented'); // TODO: implement!
  }
}
}
