import QtQuick
import QtQuick.Layouts
import Quickshell
import "content/"
import qs.config
import qs.modules.components

Item {
    property bool isHorizontal:
        Config.runtime.bar.position === "top"
        || Config.runtime.bar.position === "bottom"

    property real sideMargin:
        Config.runtime.bar.density * 0.3

    property real edgeOffset:
        Config.runtime.bar.density * 0.1

    RowLayout {
        id: hLeftRow
        visible: isHorizontal
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: sideMargin
        spacing: Metrics.spacing(4)

        ToggleModule {
            icon: "menu"
            iconSize: Metrics.iconSize(22)
            iconColor: Appearance.m3colors.m3error
            toggle: Globals.visiblility.sidebarLeft
            onToggled: Globals.visiblility.sidebarLeft = value
        }

        WorkspaceModule { }
    }

    RowLayout {
        id: hCenterRow
        visible: isHorizontal
        anchors.centerIn: parent
        spacing: Metrics.spacing(4)

        SystemUsageModule { }
        MediaPlayerModule { }
        ActiveWindowModule { }
        ClockModule { }
        BatteryIndicatorModule { }
    }

    RowLayout {
        id: hRightRow
        visible: isHorizontal
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: sideMargin
        spacing: Metrics.spacing(4)

        SystemTray { id: sysTray }

        StyledText {
            visible: sysTray.items.count > 0
                     && Config.runtime.bar.modules.statusIcons.enabled
            font.pixelSize: Metrics.fontSize("hugeass")
            text: "·"
        }

        StatusIconsModule {
            id: statusIcons
        }

        StyledText {
            visible: statusIcons.visible
            font.pixelSize: Metrics.fontSize("hugeass")
            text: "·"
        }

        ToggleModule {
            icon: "power_settings_new"
            iconSize: Metrics.iconSize(22)
            iconColor: Appearance.m3colors.m3error
            toggle: Globals.visiblility.powermenu
            onToggled: Globals.visiblility.powermenu = value
        }
    }

    Item {
        visible: !isHorizontal
        anchors.top: parent.top
        anchors.topMargin: edgeOffset
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: vTopRow.implicitHeight
        implicitHeight: vTopRow.implicitWidth

        Row {
            id: vTopRow
            anchors.centerIn: parent
            spacing: Metrics.spacing(8)
            rotation: 90

            ToggleModule {
                icon: "menu"
                iconSize: Metrics.iconSize(22)
                iconColor: Appearance.m3colors.m3error
                toggle: Globals.visiblility.sidebarLeft
                rotation: 270
                onToggled: Globals.visiblility.sidebarLeft = value
            }

            SystemUsageModule { }
            MediaPlayerModule { }
            SystemTray { }
        }
    }

    Item {
        visible: !isHorizontal
        anchors.centerIn: parent
        implicitWidth: vCenterRow.implicitHeight
        implicitHeight: vCenterRow.implicitWidth

        Row {
            id: vCenterRow
            anchors.centerIn: parent
            rotation: 90

            WorkspaceModule { }
        }
    }

    Item {
        visible: !isHorizontal
        anchors.bottom: parent.bottom
        anchors.bottomMargin: edgeOffset
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: vBottomRow.implicitHeight
        implicitHeight: vBottomRow.implicitWidth

        Row {
            id: vBottomRow
            anchors.centerIn: parent
            spacing: Metrics.spacing(6)
            rotation: 90

            ClockModule { rotation: 270 }
            StatusIconsModule { }
            BatteryIndicatorModule { }

            ToggleModule {
                icon: "power_settings_new"
                iconSize: Metrics.iconSize(22)
                iconColor: Appearance.m3colors.m3error
                toggle: Globals.visiblility.powermenu
                rotation: 270
                onToggled: Globals.visiblility.powermenu = value
            }
        }
    }
}
