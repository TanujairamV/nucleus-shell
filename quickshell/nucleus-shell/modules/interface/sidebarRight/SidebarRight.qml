import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

import qs.config
import qs.modules.components
import qs.modules.functions
import qs.services

PanelWindow {
    id: sidebarRight

    WlrLayershell.namespace: "nucleus:sidebarRight"
    WlrLayershell.layer: WlrLayer.Top

    visible: Config.initialized
             && Globals.visiblility.sidebarRight
             && !Globals.visiblility.sidebarLeft

    color: "transparent"
    exclusiveZone: 0

    property var monitor: Hyprland.focusedMonitor
    property real sidebarRightWidth: 500

    implicitWidth: monitor ? monitor.width : 1920

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    margins {
        top: Config.runtime.bar.margins
        bottom: Config.runtime.bar.margins
    }

    MouseArea {
        anchors.fill: parent
        z: 0
        onPressed: Globals.visiblility.sidebarRight = false
    }

    StyledRect {
        id: container
        z: 1

        width: sidebarRightWidth
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        property real rightSpacing: Metrics.margin("small")

        x: Globals.visiblility.sidebarRight
           ? parent.width - width - rightSpacing
           : parent.width

        opacity: Globals.visiblility.sidebarRight ? 1 : 0
        scale: Globals.visiblility.sidebarRight ? 1 : 0.98
        transformOrigin: Item.Right

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 160
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        color: Appearance.m3colors.m3background
        radius: Metrics.radius("large")

        MouseArea {
            anchors.fill: parent
            onPressed: mouse.accepted = true
        }

        FocusScope {
            focus: true
            anchors.fill: parent

            Keys.onPressed: {
                if (event.key === Qt.Key_Escape) {
                    Globals.visiblility.sidebarRight = false
                }
            }

            SidebarRightContent { }
        }
    }

    function togglesidebarRight() {
        Globals.visiblility.sidebarRight =
            !Globals.visiblility.sidebarRight
    }

    IpcHandler {
        target: "sidebarRight"
        function toggle() {
            togglesidebarRight()
        }
    }
}
