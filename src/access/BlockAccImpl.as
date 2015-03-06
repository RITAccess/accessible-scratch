package access {
import blocks.Block;

import flash.accessibility.Accessibility;
import mx.accessibility.AccConst;

import mx.core.mx_internal;

use namespace mx_internal;

public class BlockAccImpl extends ScratchAccImpl {
    public function BlockAccImpl(master:Block) {
        super(master);
        role = AccConst.ROLE_SYSTEM_SPLITBUTTON;
    }

    public override function get_accName(childId:uint):String {
        return (master as Block).getSummary();
    }

    Block.createAccessibilityImplementation =
            createAccessibilityImplementation;

    mx_internal static function createAccessibilityImplementation(
            component:Block):void
    {
        component.accessibilityImplementation = new BlockAccImpl(component);
        Accessibility.updateProperties();
    }
}
}
