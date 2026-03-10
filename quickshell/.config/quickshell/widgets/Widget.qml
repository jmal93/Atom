import QtQuick
import QtQuick.Layouts
import qs.services

Item {
    id: root

    property string icon: ""
    property string text: ""
    property color iconColor: Appearance.palette.color1
    property color textColor: Appearance.palette.foregroundColor

    signal clicked

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    Rectangle {
        id: background

        implicitWidth: row.implicitWidth + 5
        implicitHeight: row.implicitHeight + 5
        color: "transparent"

        RowLayout {
            id: row
            anchors.centerIn: parent

            Text {
                text: root.icon
                font.pixelSize: 14
                color: root.iconColor
                Layout.alignment: Qt.AlignLeft
            }

            Text {
                text: {
                    if (root.text === "") {
                        visible = false;
                        return "";
                    } else {
                        visible = true;
                        return root.text;
                    }
                }
                color: root.textColor
                font.family: Appearance.font.family.main
                Layout.alignment: Qt.AlignRight
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
