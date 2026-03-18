import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.services as Services
import qs.widgets.network as NetworkComponents

Widget {
    id: root

    icon: {
        if (Services.NetworkService.isTurnedOn) {
            return root.barToWifi(Services.NetworkService.strength);
        } else {
            return "󰤭";
        }
    }

    onClicked: networkPopup.visible = !networkPopup.visible
    onEntered: networkNamePopup.visible = true
    onExited: networkNamePopup.visible = false

    function barToWifi(bar: string): string {
        switch (bar) {
        case "▂▄▆█":
            return "󰤨";
        case "▂▄▆_":
            return "󰤥";
        case "▂▄__":
            return "󰤢";
        case "▂___":
            return "󰤟";
        default:
            return "󰤫";
        }
    }

    HyprlandFocusGrab {
        id: focusGrab
        active: false
        windows: [networkPopup]
        onCleared: networkPopup.visible = false
    }

    Timer {
        id: focusGrabTimer
        interval: 50
        repeat: false
        onTriggered: focusGrab.active = true
    }

    NetworkComponents.NetworkPopup {
        id: networkPopup
        anchor {
            item: root
            rect.y: root.height
        }
        onVisibleChanged: {
            if (visible) {
                focusGrab.active = false;
                focusGrabTimer.restart();
            } else {
                focusGrabTimer.stop();
                focusGrab.active = false;
            }
        }
    }

    PopupWindow {
        id: networkNamePopup
        visible: false
        implicitWidth: networkName.implicitWidth + 10
        implicitHeight: networkName.implicitHeight + 10

        anchor {
            item: root
            rect.y: root.height
            rect.x: root.width / 2 - width / 2
            margins.top: 13
        }

        Rectangle {
            color: Services.Appearance.palette.backgroundColor
            border.color: Services.Appearance.palette.color7
            anchors.fill: parent
        }

        Text {
            id: networkName
            text: qsTr(Services.NetworkService.name)
            color: Services.Appearance.palette.foregroundColor
            font.family: Services.Appearance.font.family.main

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }
}
