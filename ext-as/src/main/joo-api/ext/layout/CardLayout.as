package ext.layout {
/**
 * <p>This layout manages multiple child Components, each fitted to the Container, where only a single child Component can be
 * visible at any given time.  This layout style is most commonly used for wizards, tab implementations, etc.
 * This class is intended to be extended or created via the layout:'card' <b class='link'>ext.Container#layout</b> config,
 * and should generally not need to be created directly via the new keyword.</p>
 * <p>The CardLayout's focal method is <b class='link' title='#setActiveItem'>setActiveItem</b>.  Since only one panel is displayed at a time,
 * the only way to move from one Component to the next is by calling setActiveItem, passing the id or index of
 * the next panel to display.  The layout itself does not provide a user interface for handling this navigation,
 * so that functionality must be provided by the developer.</p>
 * <p>In the following example, a simplistic wizard setup is demonstrated.  A button bar is added
 * to the footer of the containing panel to provide navigation buttons.  The buttons will be handled by a
 * common navigation routine -- for this example, the implementation of that routine has been ommitted since
 * it can be any type of custom logic.  Note that other uses of a CardLayout (like a tab control) would require a
 * completely different implementation.  For serious implementations, a better approach would be to extend
 * CardLayout to provide the custom functionality needed.  Example usage:</p>
 * <pre><code>
var navHandler = function(direction){
    // This routine could contain business logic required to manage the navigation steps.
    // It would call setActiveItem as needed, manage navigation button state, handle any
    // branching logic that might be required, handle alternate actions like cancellation
    // or finalization, etc.  A complete wizard implementation could get pretty
    // sophisticated depending on the complexity required, and should probably be
    // done as a subclass of CardLayout in a real-world implementation.
};

var card = new ext.Panel({
    title: 'Example Wizard',
    layout:'card',
    activeItem: 0, // make sure the active item is set on the container config!
    bodyStyle: 'padding:15px',
    defaults: {
        // applied to each contained panel
        border:false
    },
    // just an example of one possible navigation scheme, using buttons
    bbar: [
        {
            id: 'move-prev',
            text: 'Back',
            handler: navHandler.createDelegate(this, [-1]),
            disabled: true
        },
        '->', // greedy spacer so that the buttons are aligned to each side
        {
            id: 'move-next',
            text: 'Next',
            handler: navHandler.createDelegate(this, [1])
        }
    ],
    // the panels (or "cards") within the layout
    items: [{
        id: 'card-0',
        html: '&lt;h1&gt;Welcome to the Wizard!&lt;/h1&gt;&lt;p&gt;Step 1 of 3&lt;/p&gt;'
    },{
        id: 'card-1',
        html: '&lt;p&gt;Step 2 of 3&lt;/p&gt;'
    },{
        id: 'card-2',
        html: '&lt;h1&gt;Congratulations!&lt;/h1&gt;&lt;p&gt;Step 3 of 3 - Complete&lt;/p&gt;'
    }]
});
</code></pre>
 */
public class CardLayout extends FitLayout {
/**
     * @cfg {Boolean} deferredRender
     * True to render each contained item at the time it becomes active, false to render all contained items
     * as soon as the layout is rendered (defaults to false).  If there is a significant amount of content or
     * a lot of heavy controls being rendered into panels that are not displayed by default, setting this to
     * true might improve performance.
     */
    public var deferredRender ;
    /**
     * @cfg {Boolean} layoutOnCardChange
     * True to force a layout of the active item when the active card is changed. Defaults to false.
     */
    public var layoutOnCardChange  : Boolean;
    /**
     * @cfg {Boolean} renderHidden @hide
     */
    protected var renderHidden  : Boolean;
    public native function constructor(config) : void;
    /**
     * Sets the active (visible) item in the layout.
     * @param item The string component id or numeric index of the item to activate
     */
    public native function setActiveItem(item : *) : void;
    override protected native function renderAll(ct, target) : void;
}}
