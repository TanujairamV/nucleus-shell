import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.modules.components

Scope {
    id: root

    GothCorners {
        opacity: Config.runtime.bar.gothCorners
                 && !Config.runtime.bar.floating
                 && Config.runtime.bar.enabled
                 && !Config.runtime.bar.merged ? 1 : 0
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData

            property int rd:
                Config.runtime.bar.radius
                * Config.runtime.appearance.rounding.factor

            property int margin: Config.runtime.bar.margins
            property bool floating: Config.runtime.bar.floating
            property bool merged: Config.runtime.bar.merged
            property string pos: Config.runtime.bar.position
            property bool vertical: pos === "left" || pos === "right"

            property bool attachedTop: pos === "top"
            property bool attachedBottom: pos === "bottom"
            property bool attachedLeft: pos === "left"
            property bool attachedRight: pos === "right"

            screen: modelData
            visible: Config.runtime.bar.enabled && Config.initialized

            WlrLayershell.namespace: "nucleus:bar"

            exclusiveZone: floating
                ? Config.runtime.bar.density + Metrics.margin("tiny")
                : Config.runtime.bar.density

            implicitHeight: Config.runtime.bar.density
            implicitWidth: Config.runtime.bar.density

            color: "transparent"

            anchors {
                top: pos === "top" || vertical
                bottom: pos === "bottom" || vertical
                left: pos === "left" || !vertical
                right: pos === "right" || !vertical
            }

            margins {
                top: (floating || (merged && vertical)) ? margin : 0
                bottom: (floating || (merged && vertical)) ? margin : 0
                left: (floating || (merged && !vertical)) ? margin : 0
                right: (floating || (merged && !vertical)) ? margin : 0
            }

            StyledRect {
                id: background
                anchors.fill: parent
                color: Appearance.m3colors.m3background

                function cornerRadius(condition) {
                    if (floating)
                        return rd
                    if (!merged)
                        return 0
                    return condition ? rd : 0
                }

                topLeftRadius:
                    cornerRadius(attachedBottom || attachedRight)

                topRightRadius:
                    cornerRadius(attachedBottom || attachedLeft)

                bottomLeftRadius:
                    cornerRadius(attachedTop || attachedRight)

                bottomRightRadius:
                    cornerRadius(attachedTop || attachedLeft)

                BarContent {
                    anchors.fill: parent
                }

                Behavior on topLeftRadius {
                    enabled: Config.runtime.appearance.animations.enabled
                    animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
                }

                Behavior on topRightRadius {
                    enabled: Config.runtime.appearance.animations.enabled
                    animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
                }

                Behavior on bottomLeftRadius {
                    enabled: Config.runtime.appearance.animations.enabled
                    animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
                }

                Behavior on bottomRightRadius {
                    enabled: Config.runtime.appearance.animations.enabled
                    animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
                }
            }
        }
    }
}
