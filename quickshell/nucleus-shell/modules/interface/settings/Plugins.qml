import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.modules.widgets
import qs.plugins

ContentMenu {
    title: "Plugins"
    description: "Modify and Customize Installed Plugins."

    ContentCard {

        PluginSettings {}

    }

}
