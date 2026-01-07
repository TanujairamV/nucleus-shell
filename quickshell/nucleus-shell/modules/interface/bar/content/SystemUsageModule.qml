import QtQuick
import QtQuick.Layouts
import qs.config
import qs.modules.widgets
import qs.services

Item {
    id: systemUsageContainer

    visible: Config.runtime.bar.modules.systemUsage.enabled
    Layout.alignment: Qt.AlignVCenter
    // Let the layout compute size automatically
    implicitWidth: bgRect.implicitWidth
    implicitHeight: bgRect.implicitHeight

    Rectangle {
        id: bgRect

        color: Appearance.m3colors.m3paddingContainer
        radius: Config.runtime.bar.modules.radius
        // Padding around the text
        implicitWidth: child.implicitWidth + Appearance.margin.large
        implicitHeight: child.implicitHeight + Appearance.margin.verysmall - 2
    }

    RowLayout {
        id: child

        anchors.centerIn: parent
        spacing: 4

        CircularProgressBar {
            icon: "memory"
            visible: Config.runtime.bar.modules.systemUsage.cpuStatsEnabled
            iconSize: 13
            value: SystemDetails.cpuPercent
            Layout.bottomMargin: 2
        }

        StyledText {
            visible: Config.runtime.bar.modules.systemUsage.cpuStatsEnabled
            animate: false
            text: Math.round(SystemDetails.cpuPercent * 100) + "%"
        }

        CircularProgressBar {
            Layout.leftMargin: 4
            icon: "memory_alt"
            visible: Config.runtime.bar.modules.systemUsage.memeoryStatsEnabled
            iconSize: 13
            value: SystemDetails.ramPercent
            Layout.bottomMargin: 2
        }

        StyledText {
            visible: Config.runtime.bar.modules.systemUsage.memeoryStatsEnabled
            animate: false
            text: Math.round(SystemDetails.ramPercent * 100) + "%"
        }

        CircularProgressBar {
            visible: Config.runtime.bar.modules.systemUsage.tempStatsEnabled
            Layout.leftMargin: 4
            icon: "device_thermostat"
            iconSize: 13
            value: SystemDetails.cpuTempPercent
            Layout.bottomMargin: 2
        }

        StyledText {
            visible: Config.runtime.bar.modules.systemUsage.tempStatsEnabled
            animate: false
            text: Math.round(SystemDetails.cpuTempPercent * 100) + "%"
        }

    }

}
