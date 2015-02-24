package access {
import flash.accessibility.Accessibility;

import mx.core.mx_internal;
import mx.accessibility.AccConst;

import ui.PaletteSelectorItem;

use namespace mx_internal;

public class PaletteSelectorItemAccImpl extends ScratchAccImpl{
    public function PaletteSelectorItemAccImpl(master:PaletteSelectorItem) {
        super(master);
        role = AccConst.ROLE_SYSTEM_PAGETAB;
    }

    public override function get_accName(childID:uint):String {
        return (master as PaletteSelectorItem).label.text;
    }

    PaletteSelectorItem.createAccessibilityImplementation =
            createAccessibilityImplementation;

    mx_internal static function createAccessibilityImplementation(
            component:PaletteSelectorItem):void
    {
        component.accessibilityImplementation = new PaletteSelectorItemAccImpl(component);
        Accessibility.updateProperties();
    }
}
}
