pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: updates
    property string listOfUpdates: ""
    property string numberOfUpdates: ""

    Timer {
        interval: 1000 * 60 * 10
        repeat: true
        running: true
        onTriggered: getUpdates.running = true
    }

    Process {
        id: getUpdates
        command: ["sh", "-c", "checkupdates"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const txt = this.text.trim();
                updates.listOfUpdates = txt;
                updates.numberOfUpdates = txt.length ? String(txt.split("\n").length) : "0";
            }
        }
    }
}
