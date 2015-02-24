package uiwidgets {

import access.IconButtonCheckboxAccImpl;

import mx.accessibility.AccConst;
import mx.core.mx_internal;

use namespace mx_internal;


[AccessibilityClass(implementation="access.IconButtonCheckboxAccImpl")]
public class IconButtonCheckbox extends IconButton {
    public function IconButtonCheckbox(clickFunction:Function) {
        super(clickFunction, 'checkbox');
        role = AccConst.ROLE_SYSTEM_CHECKBUTTON;
    }


    //--------------------------------------------------------------------------
    //
    //  Class mixins
    //
    //--------------------------------------------------------------------------
    /**
     *  Placeholder for mixin by IconButtonAccImpl.
     */
    mx_internal static var createAccessibilityImplementation:Function;
    private var accClass:Class = IconButtonCheckboxAccImpl; //TODO: HACK (class must be referenced in order to be compiled in)


    /**
     *  @inheritDoc
     */
    override protected function initializeAccessibility():void
    {
        if (IconButtonCheckbox.createAccessibilityImplementation != null)
            IconButtonCheckbox.createAccessibilityImplementation(this);
    }

}
}
