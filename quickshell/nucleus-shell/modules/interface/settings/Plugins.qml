import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.config
import qs.modules.components
import qs.plugins

ContentMenu {
    title: "Store"
    description: "Manage plugins and other stuff for the shell."

    ContentCard {
        Layout.fillWidth: true
        Layout.preferredHeight: implicitHeight

        GridLayout {
            id: grid
            columns: 1
            Layout.fillWidth: true
            columnSpacing: Metrics.spacing(16)
            rowSpacing: Metrics.spacing(16)

            Repeater {
                model: PluginParser.model

                delegate: StyledRect {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 90
                    radius: Metrics.radius("small")
                    color: Appearance.m3colors.m3surfaceContainer

                    Item {
                        anchors.fill: parent
                        anchors.margins: Metrics.margin("normal")

                        RowLayout {
                            anchors.fill: parent
                            spacing: Metrics.spacing(12)

                            Column {
                                Layout.fillWidth: true
                                spacing: Metrics.spacing(2)

                                StyledText {
                                    font.pixelSize: Metrics.fontSize("large")
                                    text: name
                                }

                                StyledText {
                                    font.pixelSize: Metrics.fontSize("small")
                                    text: author
                                    color: Appearance.colors.colSubtext
                                }

                                StyledText {
                                    font.pixelSize: Metrics.fontSize("normal")
                                    text: description
                                    color: Appearance.colors.colSubtext
                                }
                            }

                            StyledButton {
                                text: installed ? "Remove" : "Install"
                                Layout.preferredWidth: 140
                                onClicked: installed
                                    ? PluginParser.uninstall(id)
                                    : PluginParser.install(id)
                            }
                        }
                    }
                }
            }
        }
    }
}
