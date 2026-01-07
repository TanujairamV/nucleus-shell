import QtQuick
pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell

Singleton {
    id: root
    property QtObject visiblility
    property QtObject states

    visiblility: QtObject {
        property bool powermenu: false
        property bool launcher: false
    }

    states: QtObject {
        property bool settingsOpen: false
    }

}
