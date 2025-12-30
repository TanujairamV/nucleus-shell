import qs.settings
import QtQuick
import Qt.labs.platform
import Quickshell
import Quickshell.Io

Item {
    id: updater
    visible: false

    property string currentVersion: ""
    property string latestVersion: ""
    property bool notified: false

    Timer {
        interval: 6 * 60 * 60 * 1000 // 6 hours
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            readLocalVersion()
            fetchLatestVersion()
        }
    }

    // Add 'v' arg to default local version because it is not stored 
    // as vX.Y.Z but X.Y.Z while on github its published as vX.Y.Z

    function readLocalVersion() {
        currentVersion = "v" + Shell.flags.shellInfo.version || "" 
    }

    Process {
        id: updateProc
        command: [
            "curl",
            "-fsSL",
            "https://api.github.com/repos/xzepyx/aelyx-shell/releases/latest"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const json = JSON.parse(text)
                    latestVersion = json.tag_name
                    compareVersions()
                } catch (e) {
                    console.warn("Update check: JSON parse failed")
                }
            }
        }
    }

    function fetchLatestVersion() {
        if (!updateProc.running)
            updateProc.running = true;
    }

    function compareVersions() {
        if (!currentVersion || !latestVersion)
            return

        if (currentVersion !== latestVersion && !notified) {
            notifyUpdate()
            notified = true
        }
    }

    function notifyUpdate() {
        Quickshell.execDetached([
            "notify-send",
            "-a", "aelyx-shell",
            "Shell Update Available",
            "Installed: " + currentVersion + "\nLatest: " + latestVersion
        ])
    }
}
