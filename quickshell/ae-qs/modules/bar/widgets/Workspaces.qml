import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.bar
import qs.services
import qs.settings
import qs.widgets

BarModule {
    id: workspaceContainer

    property int numWorkspaces: 8

    function jpNumber(n) {
        const map = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"];
        return map[n] ?? n.toString();
    }

    Layout.alignment: Qt.AlignVCenter
    Layout.leftMargin: 10
    Layout.rightMargin: 8
    implicitWidth: bgRect.implicitWidth
    implicitHeight: bgRect.implicitHeight

    Rectangle {
        id: bgRect

        color: Appearance.m3colors.m3paddingContainer
        radius: Shell.flags.bar.moduleRadius
        implicitWidth: workspaceRow.implicitWidth + Appearance.margin.large
        implicitHeight: workspaceRow.implicitHeight + Appearance.margin.normal - 4

        RowLayout {
            id: workspaceRow

            anchors.centerIn: parent
            spacing: 10

            Repeater {
                model: numWorkspaces

                Item {
                    property bool focused: (index + 1) === Hyprland.focusedWorkspaceId
                    property bool occupied: Hyprland.isWorkspaceOccupied(index + 1)

                    width: 22
                    height: 22

                    Rectangle {
                        id: bg

                        anchors.fill: parent
                        radius: 10
                        color: focused ? Appearance.m3colors.m3primary : "transparent"
                    }

                    StyledText {
                        anchors.centerIn: parent
                        text: jpNumber(index + 1)
                        font.pixelSize: Appearance.font.size.small
                        color: focused ? Appearance.m3colors.m3shadow : occupied ? Appearance.m3colors.m3error : Appearance.syntaxHighlightingTheme
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + (index + 1))
                    }

                }

            }

        }

    }

}
