import QtQuick
import qs.services
import Quickshell

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

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

    Rectangle {
        id: background
        implicitWidth: networkText.implicitWidth + 8
        implicitHeight: networkText.implicitHeight
        color: "transparent"
        radius: 1

        anchors {
            fill: parent
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    Text {
        id: networkText
        color: Appearance.palette.softGreen
        font.pixelSize: 16
        text: {
            if (Network.isTurnedOn) {
                return root.barToWifi(Network.strength);
            } else {
                return "󰤭";
            }
        }

        anchors {
            centerIn: background
        }
    }

    PopupWindow {
        id: networksPopup
        visible: false
        implicitWidth: 300
        implicitHeight: 300
        color: "white"

        anchor {
            item: root
            rect.y: root.height
        }
    }

    PopupWindow {
        id: networkNamePopup
        visible: false
        implicitWidth: networkName.implicitWidth + 10
        implicitHeight: networkName.implicitHeight + 10
        color: Appearance.palette.backgroundColor1

        anchor {
            item: root
            rect.y: root.height + 5
            rect.x: root.width / 2 - width / 2
        }

        Text {
            id: networkName
            text: qsTr(Network.name)
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            networksPopup.visible = !networksPopup.visible;
            networkNamePopup.visible = false;
        }
        onEntered: {
            background.color = Appearance.palette.comment;
            networkNamePopup.visible = true;
        }
        onExited: {
            background.color = "transparent";
            networkNamePopup.visible = false;
        }
    }
}
