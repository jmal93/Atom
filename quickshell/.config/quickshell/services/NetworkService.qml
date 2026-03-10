pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property bool isTurnedOn: false
    property string strength: ""
    property string name: ""
    property ListModel networksModel: ListModel {}

    function update(): void {
        wifiStatus.running = true;
        wifiStrength.running = true;
        wifiName.running = true;
        networkList.running = true;
    }

    function keyOf(obj) {
        return obj.ssid + "|" + obj.bssid;
    }

    function applyDiff(newList) {
        const incoming = new Map();
        for (const n of newList) {
            if (n.ssid && n.bssid) {
                incoming.set(keyOf(n), n);
            }
        }

        for (let i = networksModel.count - 1; i >= 0; i--) {
            if (!incoming.has(networksModel.get(i).key)) {
                networksModel.remove(i);
            }
        }

        const existingKeys = new Set();
        for (let i = 0; i < networksModel.count; i++) {
            const item = networksModel.get(i);
            const updated = incoming.get(item.key);
            existingKeys.add(item.key);

            if (item.signal !== updated.signal) {
                networksModel.setProperty(i, "signal", updated.signal);
            }
            if (item.bars !== updated.bars) {
                networksModel.setProperty(i, "bars", updated.bars);
            }
        }

        for (const [key, n] of incoming) {
            if (!existingKeys.has(key)) {
                networksModel.append({
                    key,
                    ssid: n.ssid,
                    bssid: n.bssid,
                    signal: n.signal,
                    bars: n.bars,
                    security: n.security
                });
            }
        }

        for (let i = 1; i < networksModel.count; i++) {
            let j = i;
            while (j > 0 && networksModel.get(j).signal > networksModel.get(j - 1).signal) {
                networksModel.move(j, j - 1, 1);
                j--;
            }
        }
    }

    function connectToNetwork(bssid, password = "") {
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
        command: ["sh", "-c", "nmcli -g IN-USE,SSID d w l | awk -F: '$1 == \"*\" {print $2}'"]
        stdout: StdioCollector {
            onStreamFinished: root.name = text.trim()
        }
    }

    Process {
        id: networkList
        running: false
        command: ["sh", "-c", "nmcli -t  -g 'SSID,SIGNAL,BARS,SECURITY,BSSID' device wifi list"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.split('\n');
                const listOfNetworks = [];

                for (let i = 0; i < lines.length; i++) {
                    const line = lines[i].trim();
                    if (!line) {
                        continue;
                    }

                    const parts = line.split(":");

                    const ssid = parts[0];
                    const signal = Number(parts[1]);
                    const bars = parts[2];
                    const security = parts[3];

                    if (!ssid || Number.isNaN(signal) || !bars || !security)
                        continue;

                    const bssidEscaped = parts.slice(4).join(":");
                    const bssid = bssidEscaped.replace(/\\:/g, ":");

                    if (!bssid) {
                        continue;
                    }

                    listOfNetworks.push({
                        ssid,
                        signal,
                        bars,
                        security,
                        bssid
                    });
                }

                root.applyDiff(listOfNetworks);
            }
        }
    }

    Process {
        id: connectProcess
        running: false
    }
}
