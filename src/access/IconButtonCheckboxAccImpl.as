package access {
import flash.accessibility.Accessibility;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.accessibility.AccConst;


import mx.core.mx_internal;

import uiwidgets.IconButtonCheckbox;

use namespace mx_internal;

public class IconButtonCheckboxAccImpl extends IconButtonAccImpl {

    public function IconButtonCheckboxAccImpl(master:IconButtonCheckbox) {
        super(master);
    }

    override protected function eventHandler(event:Event):void
    {
        switch (event.type)
        {
            case "click":
            {
                Accessibility.sendEvent(master, 0, AccConst.EVENT_OBJECT_STATECHANGE);
                Accessibility.updateProperties();
                break;
            }

            case "labelChanged":
            {
                Accessibility.sendEvent(master, 0, AccConst.EVENT_OBJECT_NAMECHANGE);
                Accessibility.updateProperties();
                break;
            }

        }
    }

    public override function get_accState(childID:uint):uint {
        return ((master as IconButtonCheckbox).isOn() ? AccConst.STATE_SYSTEM_CHECKED : AccConst.STATE_SYSTEM_NORMAL);
    }


    IconButtonCheckbox.createAccessibilityImplementation =
            createAccessibilityImplementation;

    mx_internal static function createAccessibilityImplementation(
            component:IconButtonCheckbox):void
    {
        component.accessibilityImplementation = new IconButtonCheckboxAccImpl(component);
        Accessibility.updateProperties();
    }
}
}
