import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import Quickshell

Widget {
    id: root

    readonly property real volume: Audio.volume
    property var overlayInstance: null

    icon: Audio.isMuted ? "" : root.audioVolumeIconLevel(root.volume)
    text: root.volume + "%"
    onClicked: sliderPopup.visible = !sliderPopup.visible

    function audioVolumeIconLevel(level: real): string {
        if (level > 50) {
            return "";
        } else if (level > 0 && level <= 50) {
            return "";
        } else if (level == 0) {
            return "";
        }
    }

    PopupWindow {
        id: sliderPopup
        implicitWidth: sliderRow.width + 10
        implicitHeight: 30

        Rectangle {
            anchors.fill: parent
            color: Appearance.palette.backgroundColor
            border.color: Appearance.palette.color8
        }

        anchor {
            item: root
            rect.x: root.width / 2 - width / 2
            rect.y: root.height
            margins.top: 16
        }

        RowLayout {
            id: sliderRow
            anchors.centerIn: parent

            Text {
                color: Appearance.palette.foregroundColor
                font.family: Appearance.font.family.main
                text: qsTr(" 0 ")
            }

            Slider {
                id: slider
                from: 0
                to: 100
                value: root.volume
                stepSize: 1
                snapMode: Slider.SnapAlways
                onMoved: Audio.changeVolume(value / 100)

                background: Rectangle {
                    x: slider.leftPadding
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    implicitWidth: 130
                    implicitHeight: 4
                    width: slider.availableWidth
                    height: implicitHeight
                    radius: 10
                    color: "white"

                    Rectangle {
                        width: slider.visualPosition * parent.width
                        height: parent.height
                        radius: 10
                        color: "grey"
                    }
                }
            }

            Text {
                color: Appearance.palette.foregroundColor
                font.family: Appearance.font.family.main
                text: qsTr("100")
            }
        }
    }
}
