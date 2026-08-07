import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

Item {
    id: root

    readonly property real volume: Audio.volume
    property var overlayInstance: null

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    function audioVolumeIconLevel(level: real): string {
        if (level > 50) {
            return "";
        } else if (level > 0 && level <= 50) {
            return "";
        } else if (level == 0) {
            return "";
        }
    }

    Rectangle {
        id: background

        implicitWidth: row.implicitWidth + 5
        implicitHeight: row.implicitHeight + 5
        color: "transparent"

        RowLayout {
            id: row

            anchors.centerIn: parent

            RowLayout {
                id: audioRow

                anchors.centerIn: parent

                Text {
                    text: Audio.isMuted ? "" : root.audioVolumeIconLevel(root.volume)
                    font.pixelSize: 14
                    color: Appearance.palette.color1
                }

                Text {
                    text: root.volume + "%"
                    font.family: Appearance.font.family.main
                    color: Appearance.palette.foregroundColor
                }
            }
        }
    }
}
