import Quickshell 
import QtQuick 

import qs.modules.interface.bar
import qs.modules.interface.background
import qs.modules.interface.powermenu
import qs.modules.interface.launcher
import qs.modules.interface.notifications
import qs.modules.interface.overlays

ShellRoot {
    id: shellroot 

    // Load modules

    Bar { }

    Background { }

    Powermenu { }

    Launcher { }

    Notifications { }

    Overlays { }

}