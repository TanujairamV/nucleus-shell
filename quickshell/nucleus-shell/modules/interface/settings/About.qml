import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Quickshell
import Quickshell.Widgets
import qs.modules.widgets 
import qs.config 
import qs.services

Item {

    ColumnLayout {
        anchors.centerIn: parent

        ColumnLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter


            ColumnLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                StyledText {
                    text: SystemDetails.osIcon
                    font.pixelSize: 280
                    horizontalAlignment: Text.AlignHCenter
                }

                StyledText {
                    text: "Nucleus Shell"
                    font.pixelSize: 24
                    font.family: "Outfit ExtraBold"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: 400
                }

                StyledText {
                    text: "A Shell built to get things done."
                    font.pixelSize: 14
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: 400
                }
            }
            Item {}
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                StyledButton {
                    text: "View on GitHub"
                    icon: 'code'
                    secondary: true
                    onClicked: Qt.openUrlExternally("https://github.com/xZepyx/nucleus-shell")
                    topRightRadius: 5
                    bottomRightRadius: 5
                }
                StyledButton {
                    text: "Report Issue"
                    icon: "bug_report"
                    secondary: true
                    onClicked: Qt.openUrlExternally("https://github.com/xZepyx/nucleus-shell/issues")
                    topLeftRadius: 5
                    bottomLeftRadius: 5
                }

            }
        }
    }


}