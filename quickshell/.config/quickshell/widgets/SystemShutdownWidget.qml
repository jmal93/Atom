import QtQuick
import qs.services
import qs.widgets.system_shutdown

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    required property var bar
    required property var screen

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

    SystemShutdownDashboard {
        id: systemShutdownDashboard

        anchor {
            window: bar
            rect.x: (bar.width - width) / 2
            rect.y: (screen.height - height) / 2
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: systemShutdownDashboard.visible = !systemShutdownDashboard.visible
    }
}
