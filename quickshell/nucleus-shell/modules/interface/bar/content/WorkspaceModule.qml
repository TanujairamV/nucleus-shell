import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.modules.functions
import qs.modules.widgets
import qs.services

Item {
    id: workspaceContainer

    property int numWorkspaces: Config.runtime.bar.modules.workspaces.workspaceIndicators
    property var workspaceOccupied: []
    property var occupiedRanges: []

    function updateWorkspaceOccupied() {
        workspaceOccupied = Array.from({
            "length": numWorkspaces
        }, (_, i) => {
            return Hyprland.isWorkspaceOccupied(i + 1);
        });
        const ranges = [];
        let start = -1;
        for (let i = 0; i < workspaceOccupied.length; i++) {
            if (workspaceOccupied[i]) {
                if (start === -1)
                    start = i;

            } else if (start !== -1) {
                if (i - 1 > start)
                    ranges.push({
                    "start": start,
                    "end": i - 1
                });

                start = -1;
            }
        }
        if (start !== -1 && workspaceOccupied.length - 1 > start)
            ranges.push({
            "start": start,
            "end": workspaceOccupied.length - 1
        });

        occupiedRanges = ranges;
    }

    visible: Config.runtime.bar.modules.workspaces.enabled
    implicitWidth: bg.implicitWidth
    implicitHeight: Config.runtime.bar.modules.height
    Component.onCompleted: updateWorkspaceOccupied()

    Connections {
        function onWindowListChanged() {
            updateWorkspaceOccupied();
        }

        target: Hyprland
    }

    Rectangle {
        id: bg

        color: Appearance.m3colors.m3paddingContainer
        radius: Config.runtime.bar.modules.radius
        implicitWidth: workspaceRow.implicitWidth + Appearance.margin.large - 8
        implicitHeight: Config.runtime.bar.modules.height

        Item {
            id: occupiedStretchLayer

            anchors.centerIn: workspaceRow
            width: workspaceRow.width
            height: 26
            z: 0

            Repeater {
                model: occupiedRanges

                Rectangle {
                    height: 26
                    radius: 14
                    color: ColorUtils.mix(Appearance.m3colors.m3tertiary, Appearance.m3colors.m3surfaceContainerLowest)
                    opacity: 0.8
                    x: modelData.start * (26 + workspaceRow.spacing)
                    width: (modelData.end - modelData.start + 1) * 26 + (modelData.end - modelData.start) * workspaceRow.spacing
                }

            }

        }

        Rectangle {
            id: highlight

            property int index: Hyprland.focusedWorkspaceId - 1
            property real itemWidth: 26
            property real spacing: workspaceRow.spacing
            property real targetX: Math.min(index, numWorkspaces - 1) * (itemWidth + spacing) + 7.3
            // Animated endpoints
            property real animatedX1: targetX
            property real animatedX2: targetX

            x: Math.min(animatedX1, animatedX2)
            y: 5
            width: Math.abs(animatedX2 - animatedX1) + itemWidth - 1
            height: 24
            radius: 13
            color: Appearance.m3colors.m3tertiary
            onTargetXChanged: {
                animatedX1 = targetX;
                animatedX2 = targetX;
            }

            Behavior on animatedX1 {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutSine
                }

            }

            Behavior on animatedX2 {
                NumberAnimation {
                    duration: 400 / 3 // One side moves faster to create stretch
                    easing.type: Easing.OutSine
                }

            }

        }

        RowLayout {
            id: workspaceRow

            anchors.centerIn: parent
            spacing: 10

            Repeater {
                model: numWorkspaces

                Item {
                    property bool focused: (index + 1) === Hyprland.focusedWorkspaceId
                    property bool occupied: Hyprland.isWorkspaceOccupied(index + 1)

                    width: 26
                    height: 26

                    Rectangle {
                        id: iconContainer

                        anchors.centerIn: parent
                        width: 20
                        height: 20
                        color: "transparent"
                        radius: width / 2
                        clip: true
                        layer.enabled: true

                        IconImage {
                            id: appIcon
                            anchors.fill: parent
                            rotation: (Config.runtime.bar.position === "left" || Config.runtime.bar.position === "right") ? 270 : 0
                            source: {
                                const win = Hyprland.focusedWindowForWorkspace(index + 1);
                                return win ? Quickshell.iconPath(FileUtils.resolveIcon(win.class)) : "";
                            }
                        }

                        layer.effect: OpacityMask {

                            maskSource: Rectangle {
                                width: iconContainer.width 
                                height: iconContainer.height
                                radius: iconContainer.width / 2
                            }

                        }

                    }

                    Tint {
                        rotation: (Config.runtime.bar.position === "left" || Config.runtime.bar.position === "right") ? 270 : 0
                        sourceItem: appIcon
                    }

                    MaterialSymbol {
                        id: symbol

                        visible: true
                        animate: false
                        anchors.centerIn: parent
                        text: Config.runtime.bar.modules.workspaces.showAppIcons ? (!occupied ? "fiber_manual_record" : "") : (occupied || focused ? "󰮯" : "fiber_manual_record")
                        font.variableAxes: {
                            "FILL": (symbol.text === "fiber_manual_record") ? 1 : 0
                        }
                        rotation: (Config.runtime.bar.position === "left" || Config.runtime.bar.position === "right") ? 270 : 0
                        font.pixelSize: (symbol.text === "fiber_manual_record") ? 10 : Appearance.font.size.large
                        color: focused ? Appearance.m3colors.m3shadow : Appearance.m3colors.m3secondary
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
