/**
 * Created by Wesley on 2/19/2015.
 */
package access {
import ui.AccessibleComponent;

import uiwidgets.IconButton;

public class IconButtonAccImpl extends ScratchAccImpl {
    public function IconButtonAccImpl(master:IconButton) {
        super(master);
    }

    protected override function getName(childID:uint):String
    {
        var name = (master as IconButton).name;
        return name;
    }
}
}
