pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: updates
    property string listOfUpdates: ""
    property string numberOfUpdates: ""
    property bool isThereUpdates: Number(numberOfUpdates) == 0 ? false : true

    function updateSystem() {
        if (!doUpdateInTerminal.running) {
            doUpdateInTerminal.running = true;
        }
    }

    Timer {
        interval: 1000 * 60
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

    Process {
        id: doUpdateInTerminal
        running: false
        command: ["kitty", "--hold", "sh", "-lc", "sudo pacman -Syu --noconfirm; exit"]

        onRunningChanged: {
            if (!running && !getUpdates.running) {
                getUpdates.running = true;
            }
        }
    }
}
