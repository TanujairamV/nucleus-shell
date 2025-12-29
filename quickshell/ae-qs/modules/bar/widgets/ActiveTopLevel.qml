import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.functions
import qs.modules.bar
import qs.services
import qs.settings
import qs.widgets

BarModule {
    id: container

    property Toplevel activeToplevel: Hyprland.isWorkspaceOccupied(Hyprland.focusedWorkspaceId) ? Hyprland.activeToplevel : null

    function formatAppId(appId) { // Random function to make it look good
        if (!appId || appId.length === 0)
            return "";

        // split on dashes/underscores
        const parts = appId.split(/[-_]/);
        // capitalize each segment
        for (let i = 0; i < parts.length; i++) {
            const p = parts[i];
            parts[i] = p.charAt(0).toUpperCase() + p.slice(1);
        }
        return parts.join("-");
    }

    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    implicitWidth: col.implicitWidth
    implicitHeight: col.implicitHeight

    Column {
        // Added org to appId just cuz it looks cool :>

        id: col

        spacing: 0
        anchors.centerIn: parent

        StyledText {
            id: workspaceText
            font.pixelSize: Appearance.font.size.smallest + 2
            text: {
                if (!activeToplevel)
                    return "Desktop";

                const id = activeToplevel.appId || "";
                if (id.startsWith("org."))
                    return id;

                return `org.app.${id}`;
            }
            horizontalAlignment: Text.AlignHCenter
        }

        StyledText {
            id: titleText
            text: formatAppId(activeToplevel?.appId || `Workspace ${Hyprland.focusedWorkspaceId}`)
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Appearance.font.size.small
        }

    }

}
