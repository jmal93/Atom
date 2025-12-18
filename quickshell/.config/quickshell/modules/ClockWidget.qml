import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    Rectangle {
        id: background
        implicitWidth: timeColumn.implicitWidth + 8
        implicitHeight: timeColumn.implicitHeight
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

    ColumnLayout {
        id: timeColumn
        spacing: -1
        anchors {
            centerIn: background
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            text: Qt.formatDateTime(Time.getDateTime(), "hh:mm")
            font.family: Appearance.font.family.main
            color: Appearance.palette.foregroundColor
            font.pixelSize: 12
        }
        Text {
            Layout.alignment: Qt.AlignCenter
            text: Qt.formatDateTime(Time.getDateTime(), "dd/MM/yyyy")
            font.family: Appearance.font.family.main
            color: Appearance.palette.foregroundColor

            font.pixelSize: 10
        }
    }

    PopupWindow {
        id: calendarPopup
        visible: false
        implicitWidth: calendarText.implicitWidth + 10
        implicitHeight: calendarText.implicitHeight
        color: Appearance.palette.backgroundColor1

        anchor {
            item: root
            rect.y: root.height + 5
        }

        Text {
            id: calendarText
            text: Time.calendar
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
            calendarPopup.visible = !calendarPopup.visible;
        }
        onEntered: {
            background.color = Appearance.palette.gray;
        }
        onExited: {
            background.color = "transparent";
        }
    }
}
