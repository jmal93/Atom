import QtQuick
import qs.services

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    property var shutdownWindow

    Rectangle {
        id: background
        implicitWidth: text.implicitWidth + 8
        implicitHeight: text.implicitHeight
        color: "transparent"
        anchors.fill: parent

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        Text {
            id: text
            text: "󰣇"
            font.pixelSize: 20
            color: Appearance.palette.color13
            anchors.centerIn: parent
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (!root.shutdownWindow) {
                console.log("Shutdown window não passado");
                return;
            }
            root.shutdownWindow.opened = !root.shutdownWindow.opened;
        }
    }
}
