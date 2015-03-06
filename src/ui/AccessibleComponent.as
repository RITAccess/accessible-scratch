/**
 * Based on flex's UIComponent class
 */

package ui
{
import flash.accessibility.Accessibility;
import flash.accessibility.AccessibilityProperties;
import flash.display.Sprite;
import flash.system.Capabilities;
import mx.core.mx_internal;

use namespace mx_internal;

public class AccessibleComponent extends Sprite {

    //--------------------------------------------------------------------------
    //
    //  Class mixins
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     *  Placeholder for mixin by AccessibleComponentAccProps.
     */
    mx_internal static var createAccessibilityImplementation:Function;


    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function AccessibleComponent() {
        super();
    }

    //------------------------------------------------------------------------
    //
    //  Properties: Accessibility
    //
    //------------------------------------------------------------------------

    /**
     *  A convenience accessor for the <code>silent</code> property
     *  in this UIComponent's <code>accessibilityProperties</code> object.
     *
     *  <p>Note that <code>accessibilityEnabled</code> has the opposite sense from silent;
     *  <code>accessibilityEnabled</code> is <code>true</code>
     *  when <code>silent</code> is <code>false</code>.</p>
     *
     *  <p>The getter simply returns <code>accessibilityProperties.silent</code>,
     *  or <code>true</code> if <code>accessibilityProperties</code> is null.
     *  The setter first checks whether <code>accessibilityProperties</code> is null,
     *  and if it is, sets it to a new AccessibilityProperties instance.
     *  Then it sets <code>accessibilityProperties.silent</code>.</p>
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get accessibilityEnabled():Boolean {
        return accessibilityProperties ? !accessibilityProperties.silent : true;
    }

    public function set accessibilityEnabled(value:Boolean):void {
        if (!Capabilities.hasAccessibility)
            return;

        if (!accessibilityProperties)
            accessibilityProperties = new AccessibilityProperties();

        accessibilityProperties.silent = !value;
        Accessibility.updateProperties();
    }

    /**
     *  A convenience accessor for the <code>name</code> property
     *  in this UIComponent's <code>accessibilityProperties</code> object.
     *
     *  <p>The getter simply returns <code>accessibilityProperties.name</code>,
     *  or "" if accessibilityProperties is null.
     *  The setter first checks whether <code>accessibilityProperties</code> is null,
     *  and if it is, sets it to a new AccessibilityProperties instance.
     *  Then it sets <code>accessibilityProperties.name</code>.</p>
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get accessibilityName():String {
        return accessibilityProperties ? accessibilityProperties.name : "";
    }

    public function set accessibilityName(value:String):void {
        if (!Capabilities.hasAccessibility)
            return;

        if (!accessibilityProperties)
            accessibilityProperties = new AccessibilityProperties();

        accessibilityProperties.name = value;
        Accessibility.updateProperties();
    }

    /**
     *  A convenience accessor for the <code>description</code> property
     *  in this UIComponent's <code>accessibilityProperties</code> object.
     *
     *  <p>The getter simply returns <code>accessibilityProperties.description</code>,
     *  or "" if <code>accessibilityProperties</code> is null.
     *  The setter first checks whether <code>accessibilityProperties</code> is null,
     *  and if it is, sets it to a new AccessibilityProperties instance.
     *  Then it sets <code>accessibilityProperties.description</code>.</p>
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get accessibilityDescription():String {
        return accessibilityProperties ? accessibilityProperties.description : "";
    }

    public function set accessibilityDescription(value:String):void {
        if (!Capabilities.hasAccessibility)
            return;

        if (!accessibilityProperties)
            accessibilityProperties = new AccessibilityProperties();

        accessibilityProperties.description = value;
        Accessibility.updateProperties();
    }

    /**
     *  A convenience accessor for the <code>shortcut</code> property
     *  in this UIComponent's <code>accessibilityProperties</code> object.
     *
     *  <p>The getter simply returns <code>accessibilityProperties.shortcut</code>,
     *  or "" if <code>accessibilityProperties</code> is null.
     *  The setter first checks whether <code>accessibilityProperties</code> is null,
     *  and if it is, sets it to a new AccessibilityProperties instance.
     *  Then it sets <code>accessibilityProperties.shortcut</code>.</p>
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get accessibilityShortcut():String {
        return accessibilityProperties ? accessibilityProperties.shortcut : "";
    }

    public function set accessibilityShortcut(value:String):void {
        if (!Capabilities.hasAccessibility)
            return;

        if (!accessibilityProperties)
            accessibilityProperties = new AccessibilityProperties();

        accessibilityProperties.shortcut = value;
        Accessibility.updateProperties();
    }

    /**
     *  Initializes the internal structure of this component.
     *
     *  <p>Initializing a UIComponent is the fourth step in the creation
     *  of a visual component instance, and happens automatically
     *  the first time that the instance is added to a parent.
     *  Therefore, you do not generally need to call
     *  <code>initialize()</code>; the Flex framework calls it for you
     *  from UIComponent's override of the <code>addChild()</code>
     *  and <code>addChildAt()</code> methods.</p>
     *
     *  <p>The first step in the creation of a visual component instance
     *  is construction, with the <code>new</code> operator:</p>
     *
     *  <pre>
     *  var okButton:Button = new Button();</pre>
     *
     *  <p>After construction, the new Button instance is a solitary
     *  DisplayObject; it does not yet have a UITextField as a child
     *  to display its label, and it doesn't have a parent.</p>
     *
     *  <p>The second step is configuring the newly-constructed instance
     *  with the appropriate properties, styles, and event handlers:</p>
     *
     *  <pre>
     *  okButton.label = "OK";
     *  okButton.setStyle("cornerRadius", 0);
     *  okButton.addEventListener(MouseEvent.CLICK, clickHandler);</pre>
     *
     *  <p>The third step is adding the instance to a parent:</p>
     *
     *  <pre>
     *  someContainer.addChild(okButton);</pre>
     *
     *  <p>A side effect of calling <code>addChild()</code>
     *  or <code>addChildAt()</code>, when adding a component to a parent
     *  for the first time, is that <code>initialize</code> gets
     *  automatically called.</p>
     *
     *  <p>This method first dispatches a <code>preinitialize</code> event,
     *  giving developers using this component a chance to affect it
     *  before its internal structure has been created.
     *  Next it calls the <code>createChildren()</code> method
     *  to create the component's internal structure; for a Button,
     *  this method creates and adds the UITextField for the label.
     *  Then it dispatches an <code>initialize</code> event,
     *  giving developers a chance to affect the component
     *  after its internal structure has been created.</p>
     *
     *  <p>Note that it is the act of attaching a component to a parent
     *  for the first time that triggers the creation of its internal structure.
     *  If its internal structure includes other UIComponents, then this is a
     *  recursive process in which the tree of DisplayObjects grows by one leaf
     *  node at a time.</p>
     *
     *  <p>If you are writing a component, you do not need
     *  to override this method.</p>
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function initialize():void {
        // Create and initialize the accessibility implementation.
        // for this component. For some components accessible object is attached
        // to child component so it should be called after createChildren
        initializeAccessibility();
    }

    /**
     *  Initializes this component's accessibility code.
     *
     *  <p>This method is called by the <code>initialize()</code> method to hook in the
     *  component's accessibility code, which resides in a separate class
     *  in the mx.accessibility package.
     *  Each subclass that supports accessibility must override this method
     *  because the hook-in process uses a different static variable
     *  in each subclass.</p>
     *
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    protected function initializeAccessibility():void {
        if (AccessibleComponent.createAccessibilityImplementation != null)
            AccessibleComponent.createAccessibilityImplementation(this);
    }
}
}