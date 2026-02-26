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
        running: false
        command: ["nmcli", "-t", "--colors", "no", "-f", "IN-USE,BARS", "dev", "wifi", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                let bars = "";
                for (let i = 0; i < lines.length; i++) {
                    const parts = lines[i].split(":");
                    if (parts.length >= 2 && (parts[0] === "*" || parts[0] === "yes")) {
                        bars = parts.slice(1).join(":").trim();
                        break;
                    }
                }
                network.strength = bars;
            }
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
