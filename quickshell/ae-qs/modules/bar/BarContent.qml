import qs.widgets
import qs.settings
import qs.modules.bar.widgets
import QtQuick
import QtQuick.Layouts

Item {

    Row {
        id: leftRow
        anchors.left: parent.left
        anchors.leftMargin: Shell.flags.bar.height * 0.3
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16

        Glyph{}
        ActiveTopLevel{}
    }

    Row {
        id: centerRow
        anchors.centerIn: parent
        spacing: 4

        //SystemUsage{} I don't think It looks too good.
        Media{}
        Workspaces{}
        Clock{}
        Utilities{}
        Battery{}
    }

    RowLayout {
        id: rightRow
        anchors.right: parent.right
        anchors.rightMargin: Shell.flags.bar.height * 0.3
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        SystemTray{}
        BluetoothWifi{}
    }


    RControl {}
    LControl {}
}
