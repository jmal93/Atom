pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: network
    property bool isTurnedOn: false
    property string strength: ""
    property string name: ""

    function update(): void {
        wifiStatus.running = true;
        wifiStrength.running = true;
        wifiName.running = true;
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: network.update()
    }

    Process {
        id: wifiStatus
        running: true
        command: ["nmcli", "radio", "wifi"]
        stdout: StdioCollector {
            onStreamFinished: network.isTurnedOn = text.trim() == "enabled"
        }
    }

    Process {
        id: wifiStrength
        running: true
        command: ["sh", "-c", "nmcli -g IN-USE,BARS dev wifi list | awk -F\":\" '/\*/{print $2}'"]
        stdout: StdioCollector {
            onStreamFinished: network.strength = text.trim()
        }
    }

    Process {
        id: wifiName
        running: false
        command: ["sh", "-c", "nmcli -g IN-USE,SSID d w l | awk -F: '$1 == \"*\" {print $2}'"]
        stdout: StdioCollector {
            onStreamFinished: network.name = text.trim()
        }
    }
}
