import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

PanelWindow {
    id: root

    color: "transparent"
    implicitWidth: background.implicitWidth
    visible: true
    margins.left: opened ? 5 : -implicitWidth

    anchors {
        top: true
        left: true
        bottom: true
    }

    Behavior on margins.left {
        NumberAnimation {
            duration: 100
            easing: Easing.InCubic
        }
    }

    property bool opened: false

    Rectangle {
        id: background

        implicitWidth: iconsColumn.implicitWidth + 20
        implicitHeight: iconsColumn.implicitHeight + 20
        anchors.verticalCenter: parent.verticalCenter
        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8

        ColumnLayout {
            id: iconsColumn
            anchors.centerIn: background
            spacing: 50

            SystemShutdownWidgetButton {
                iconSource: assetsPath + "power.svg"
                command: ["sh", "-c", "systemctl poweroff"]
                Layout.alignment: Qt.AlignHCenter
            }

            SystemShutdownWidgetButton {
                iconSource: assetsPath + "pause.svg"
                command: ["sh", "-c", "systemctl suspend & hyprlock -q"]
                Layout.alignment: Qt.AlignHCenter
            }

            SystemShutdownWidgetButton {
                iconSource: assetsPath + "reboot.svg"
                command: ["systemctl", "reboot"]
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
