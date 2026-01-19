pragma Singleton
import QtQuick
import Quickshell.Io
import qs.config

QtObject {

    // Power menu
    property url powerMenu:
        Qt.resolvedUrl("../modules/interface/powermenu/Powermenu.qml")
    function overridePowerMenu(path) {
        powerMenu = path
    }

    // Bar
    property url bar:
        Qt.resolvedUrl("../modules/interface/bar/Bar.qml")
    function overrideBar(path) {
        bar = path
    }

    // App launcher
    property url launcher:
        Qt.resolvedUrl("../modules/interface/launcher/Launcher.qml")
    function overrideLauncher(path) {
        launcher = path
    }

    // Lock screen
    property url lockScreen:
        Qt.resolvedUrl("../modules/interface/lockscreen/LockScreen.qml")
    function overrideLockScreen(path) {
        lockScreen = path
    }

    // Desktop background / wallpaper handler
    property url background:
        Qt.resolvedUrl("../modules/interface/background/Background.qml")
    function overrideBackground(path) {
        background = path
    }

    // Notifications UI
    property url notifications:
        Qt.resolvedUrl("../modules/interface/notifications/Notifications.qml")
    function overrideNotifications(path) {
        notifications = path
    }

    // Global overlays (OSD, volume, brightness, etc.)
    property url overlays:
        Qt.resolvedUrl("../modules/interface/overlays/Overlays.qml")
    function overrideOverlays(path) {
        overlays = path
    }

    // Right sidebar / tray extensions
    property url sidebarRight:
        Qt.resolvedUrl("../modules/interface/sidebarRight/SidebarRight.qml")
    function overrideSidebarRight(path) {
        sidebarRight = path
    }
}
