pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "network_service_functions.js" as Functions

Singleton {
    id: root
    property bool isTurnedOn: false
    property string strength: ""
    property string name: ""
    property ListModel networksModel: ListModel {}
    property list<string> knownNetworks

    function update() {
        wifiStatus.running = true;
        wifiStrength.running = true;
        wifiName.running = true;
        networkList.running = true;
    }

    function connectToNetwork(name, bssid, password = "") {
        if (root.knownNetworks.includes(name)) {
            connectProcess.command = ["nmcli", "connection", "up", name];
            connectProcess.running = true;
            return;
        }

        if (password === "") {
            connectProcess.command = ["nmcli", "device", "wifi", "connect", bssid];
        } else {
            connectProcess.command = ["nmcli", "device", "wifi", "connect", bssid, "password", password];
        }

        connectProcess.running = true;
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.update()
    }

    Process {
        id: wifiStatus
        running: true
        command: ["nmcli", "radio", "wifi"]
        stdout: StdioCollector {
            onStreamFinished: root.isTurnedOn = text.trim() == "enabled"
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
                root.strength = bars;
            }
        }
    }

    Process {
        id: wifiName
        running: false
        command: ["sh", "-c", "nmcli -t -f NAME,TYPE connection show --active | awk -F: '$2 ~ /wireless/ {print $1}'"]
        stdout: StdioCollector {
            onStreamFinished: root.name = text.trim()
        }
    }

    Process {
        id: networkList
        running: false
        command: ["sh", "-c", "nmcli -t  -g 'SSID,SIGNAL,BARS,SECURITY,BSSID' device wifi list"]
        stdout: StdioCollector {
            onStreamFinished: Functions.buildListOfNetworks(text)
        }
    }

    Process {
        id: connectProcess
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                notification.command = ["notify-send", text];
                notification.running = true;
            }
        }
    }

    Process {
        id: getListOfKnowWifiNetworks
        running: true
        command: ["sh", "-c", "nmcli -t -f NAME,TYPE connection | awk -F: '$2 ~ /wireless/ {print $1}'"]
        stdout: StdioCollector {
            onStreamFinished: root.knownNetworks = text.split('\n')
        }
    }

    Process {
        id: notification
        running: false
    }
}
