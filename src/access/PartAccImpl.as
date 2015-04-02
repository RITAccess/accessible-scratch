package access {
import flash.accessibility.Accessibility;

import mx.core.mx_internal;

import ui.parts.UIPart;

import uiwidgets.IconButton;
import mx.accessibility.AccConst;

use namespace mx_internal;

public class PartAccImpl extends ScratchAccImpl {
    public function PartAccImpl(master:UIPart) {
        super(master);

        role = AccConst.ROLE_SYSTEM_PANE;
    }

    public override function get_accName(childID:uint):String
    {
        var name:String = (master as UIPart).name;
        return name;
    }

    UIPart.createAccessibilityImplementation =
            createAccessibilityImplementation;

    mx_internal static function createAccessibilityImplementation(
            component:UIPart):void
    {
        component.accessibilityImplementation = new PartAccImpl(component);
        Accessibility.updateProperties();
    }
}
}