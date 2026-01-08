import Quickshell 
import QtQuick 

import qs.config
import qs.modules.interface.bar
import qs.modules.interface.background
import qs.modules.interface.powermenu
import qs.modules.interface.launcher
import qs.modules.interface.notifications
import qs.modules.interface.overlays
import qs.modules.interface.sidebarRight
import qs.modules.interface.settings

ShellRoot {
    id: shellroot 

    // Load modules

    Bar { }

    Background { }

    Powermenu { }

    Launcher { }

    Notifications { }

    Overlays { }

    SidebarRight { }

    Settings { }

    Ipc { }

}