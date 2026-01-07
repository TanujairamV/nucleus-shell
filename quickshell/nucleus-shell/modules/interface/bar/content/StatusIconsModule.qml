import QtQuick
import QtQuick.Layouts
import qs.config
import qs.modules.widgets
import qs.services
import Quickshell

Item {
    id: statusIconsContainer
    Layout.alignment: Qt.AlignVCenter
    visible: Config.runtime.bar.modules.statusIcons.enabled
    implicitWidth: bgRect.implicitWidth
    implicitHeight: bgRect.implicitHeight

    property bool isVertical: (Config.runtime.bar.position === "left" || Config.runtime.bar.position === "right")

    StyledRect {
        id: bgRect
        color: Appearance.m3colors.m3paddingContainer
        radius: Config.runtime.bar.modules.radius

        implicitWidth: contentRow.implicitWidth + Appearance.margin.large - 2
        implicitHeight: Config.runtime.bar.modules.height

        RowLayout {
            id: contentRow
            anchors.centerIn: parent
            spacing: 8

            MaterialSymbol {
                visible: Config.runtime.bar.modules.statusIcons.networkStatusEnabled
                rotation: isVertical ? 270 : 0
                id: wifi
                icon: Network.icon
                iconSize: Appearance.font.size.huge
            }

            MaterialSymbol {
                visible: Config.runtime.bar.modules.statusIcons.bluetoothStatusEnabled
                rotation: isVertical ? 270 : 0
                id: btIcon
                icon: Bluetooth.icon
                iconSize: Appearance.font.size.huge
            }

            MaterialSymbol {
                visible: Config.runtime.bar.modules.statusIcons.batteryStatusEnabled
                rotation: isVertical ? 270 : 0
                id: battIcon
                icon: UPower.battIcon
                iconSize: Appearance.font.size.huge - 3
                Layout.leftMargin: isVertical ? 0 : -3
            }

            StyledText {
                visible: Config.runtime.bar.modules.statusIcons.keyboardLayoutStatusEnabled
                rotation: isVertical ? 270 : 0
                id: keyboardLayoutIcon
                text: SystemDetails.keyboardLayout
                font.pixelSize: Appearance.font.size.huge - 4
                Layout.leftMargin: isVertical ? 0 : -3
            }
        }

        MouseArea {
            anchors.fill: parent
        }
    }
}
