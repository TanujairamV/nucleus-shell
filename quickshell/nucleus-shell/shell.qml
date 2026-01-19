import Quickshell 
import QtQuick 

import qs.config
import qs.plugins
import qs.services
import qs.modules.interface.bar
import qs.modules.interface.background
import qs.modules.interface.powermenu
import qs.modules.interface.launcher
import qs.modules.interface.notifications
import qs.modules.interface.overlays
import qs.modules.interface.sidebarRight
import qs.modules.interface.settings
import qs.modules.interface.lockscreen

ShellRoot {
    id: shellroot 

    // Load modules

    LazyLoader {
        id: barLoader
        source: Contracts.bar
        active: true
    }

    LazyLoader {
        id: backgroundLoader
        source: Contracts.background
        active: true
    }

    LazyLoader {
        id: powerMenuLoader
        source: Contracts.powerMenu
        active: true
    }

    LazyLoader {
        id: launcherLoader
        source: Contracts.launcher
        active: true
    }

    LazyLoader {
        id: notificationsLoader
        source: Contracts.notifications
        active: true
    }

    LazyLoader {
        id: overlaysLoader
        source: Contracts.overlays
        active: true
    }

    LazyLoader {
        id: sidebarRightLoader
        source: Contracts.sidebarRight
        active: true
    }

    LazyLoader {
        id: lockScreenLoader
        source: Contracts.lockScreen
        active: true
    }

    Settings { }

    Ipc { }

    UpdateNotifier { }

    PluginHost { }

}