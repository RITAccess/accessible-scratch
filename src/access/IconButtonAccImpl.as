package access {
import flash.accessibility.Accessibility;

import mx.core.mx_internal;
import uiwidgets.IconButton;
import mx.accessibility.AccConst;

use namespace mx_internal;

public class IconButtonAccImpl extends ScratchAccImpl {
    public function IconButtonAccImpl(master:IconButton) {
        super(master);
    }

    public override function get_accRole(childID:uint):uint {
        return (master as IconButton).role;
    }

    public override function get_accName(childID:uint):String
    {
        var name:String = (master as IconButton).name;
        return name;
    }

    IconButton.createAccessibilityImplementation =
            createAccessibilityImplementation;

    mx_internal static function createAccessibilityImplementation(
            component:IconButton):void
    {
        component.accessibilityImplementation = new IconButtonAccImpl(component);
        Accessibility.updateProperties();
    }
}
}
