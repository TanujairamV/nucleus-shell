import QtQuick
import QtQuick.Layouts
// PluginSettings.qml
import qs.config

Repeater {
    model: PluginLoader.pluginNames

    delegate: Loader {
        source: Qt.resolvedUrl(Directories.shellConfig + "/plugins/" + modelData + "/Settings.qml")
        asynchronous: true
    }

}
