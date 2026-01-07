import Quickshell
import Quickshell.Wayland
import QtQuick 
import qs.modules.widgets
import qs.config

Scope {
    id: root

    GothCorners {
        opacity: Config.runtime.bar.gothCorners && !Config.runtime.bar.floating && Config.runtime.bar.enabled ? 1 : 0
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData // Show bar on all screens
            visible: Config.runtime.bar.enabled 
            WlrLayershell.namespace: "nucleus:bar"
            exclusiveZone: Config.runtime.bar.floating ? Config.runtime.bar.density + Appearance.margin.tiny : Config.runtime.bar.density
            // some exclusiveSpacing so it won't look like its sticking into the window when floating

            implicitHeight: Config.runtime.bar.density // density === height. (horizontal orientation)
            implicitWidth: Config.runtime.bar.density // density === width. (vertical orientation)

            color: "transparent" // Keep panel window's color transparent, so that it can be modified by background rect

            anchors { // This is probably a little weird way to set anchors but I think it's the best way. (and it works)
                top: Config.runtime.bar.position === "top" || Config.runtime.bar.position === "left" || Config.runtime.bar.position === "right"
                bottom: Config.runtime.bar.position === "bottom" || Config.runtime.bar.position === "left" || Config.runtime.bar.position === "right"
                left: Config.runtime.bar.position === "left" || Config.runtime.bar.position === "top" || Config.runtime.bar.position === "bottom"
                right: Config.runtime.bar.position === "right" || Config.runtime.bar.position === "top" || Config.runtime.bar.position === "bottom"
            }

            margins {
                top: (Config.initialized && Config.runtime.bar.floating) ? 10 : 0
                bottom: (Config.initialized && Config.runtime.bar.floating) ? 10 : 0
                left: (Config.initialized && Config.runtime.bar.floating) ? 10 : 0
                right: (Config.initialized && Config.runtime.bar.floating) ? 10 : 0
            }

            StyledRect {
                id: background
                color: Appearance.m3colors.m3background
                radius: Config.runtime.bar.floating ? Config.runtime.bar.radius : 0
                anchors.fill: parent

                BarContent {
                    id: barContent
                    anchors.fill: parent 
                }
            }
        }
    }
}
