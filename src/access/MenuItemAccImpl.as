package access {
import flash.accessibility.Accessibility;

import mx.core.mx_internal;

import uiwidgets.Menu;
import mx.accessibility.AccConst;

import uiwidgets.MenuItem;

use namespace mx_internal;

public class MenuItemAccImpl extends ScratchAccImpl {
    public function MenuItemAccImpl(master:MenuItem) {
        super(master);
        role = AccConst.ROLE_SYSTEM_MENUITEM;
    }

    public override function get_accName(childID:uint):String {
        return (master as MenuItem).getLabel();
    }

    public override function get_accState(childId:uint):uint {
        return (master as MenuItem).isEnabled() ? getState(childId) : AccConst.STATE_SYSTEM_UNAVAILABLE;
    }

    MenuItem.createAccessibilityImplementation =
            createAccessibilityImplementation;

    mx_internal static function createAccessibilityImplementation(
            component:MenuItem):void
    {
        component.accessibilityImplementation = new MenuItemAccImpl(component);
        Accessibility.updateProperties();
    }
}
}
