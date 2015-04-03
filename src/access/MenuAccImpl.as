package access {
import flash.accessibility.Accessibility;
import flash.display.DisplayObject;

import mx.core.mx_internal;

import ui.AccessibleComponent;

import uiwidgets.Menu;
import mx.accessibility.AccConst;

import uiwidgets.MenuItem;

use namespace mx_internal;

public class MenuAccImpl extends ScratchAccImpl {
    public function MenuAccImpl(master:Menu) {
        super(master);
        role = AccConst.ROLE_SYSTEM_MENUPOPUP;
    }

    public override function get_accName(childID:uint):String {
        if (childID != 0) {
            return getChildImpl(childID).get_accName(0);
        }
        return (master as Menu).menuName;
    }

    Menu.createAccessibilityImplementation =
            createAccessibilityImplementation;

    mx_internal static function createAccessibilityImplementation(
            component:Menu):void
    {
        component.accessibilityImplementation = new MenuAccImpl(component);
        Accessibility.updateProperties();
    }
}
}
