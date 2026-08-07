pragma Singleton

import Quickshell
import Quickshell.Networking
import QtQuick

// import "network_service_functions.js" as Functions

Singleton {
    id: root
    readonly property bool isTurnedOn: Networking.wifiEnabled
    readonly property WifiDevice wifiDevice: {
        const devices = Networking.devices.values;

        for (let i = 0; i < devices.length; i++) {
            if (devices[i].type == DeviceType.Wifi) {
                return devices[i];
            }
        }

        return null;
    }

    readonly property list<Network> networks: getNetworksSorted()
    readonly property Network connectedNetwork: {
        if (!root.wifiDevice)
            return null;

        const networks = root.wifiDevice.networks.values;

        for (let i = 0; i < networks.length; i++) {
            if (networks[i].connected)
                return networks[i];
        }

        return null;
    }

    function enableWifiScan() {
        wifiDevice.scannerEnabled = true;
    }

    function disableWifiScan() {
        wifiDevice.scannerEnabled = false;
    }

    function getNetworksSorted() {
        if (!root.wifiDevice)
            return [];

        return [...root.wifiDevice.networks.values].sort((a, b) => b.signalStrength - a.signalStrength);
    }

    Timer {
        id: timer
        interval: 1000
        running: root.wifiDevice.scannerEnabled
        repeat: false
        onTriggered: {
            root.networks = root.getNetworksSorted();
        }
    }
}
