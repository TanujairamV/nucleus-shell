import QtQuick 
import Quickshell
import QtQuick.Layouts
import qs.core.config
import qs.core.appearance
import qs.common.widgets 
import qs.modules.bar
import Qt5Compat.GraphicalEffects

BarModule {
    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter        
    Layout.preferredWidth: pfp.width             
    Layout.preferredHeight: pfp.height

    Rectangle {
        id: pfp
        width: 100
        height: 100
        color: "transparent"
        radius: Appearance.rounding.normal + 2

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: pfp.width
                height: pfp.height
                radius: pfp.radius
            }
        }

        Image {
            anchors.fill: parent
            source: Config.options.global.pfp
            fillMode: Image.PreserveAspectCrop
            cache: true
            opacity: 0.9
        }
    }
}
