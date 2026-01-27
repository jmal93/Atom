import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import Quickshell

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight
    readonly property real volume: Audio.volume
    property var overlayInstance: null

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
        implicitWidth: textContainer.implicitWidth + 8
        implicitHeight: textContainer.implicitHeight
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

    PopupWindow {
        id: sliderPopup
        implicitWidth: sliderRow.width + 10
        implicitHeight: 30
        color: Appearance.palette.backgroundColor1

        Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        anchor {
            item: root
            rect.x: root.width / 2 - width / 2
            rect.y: root.height
            margins.top: 10
        }

        RowLayout {
            id: sliderRow
            anchors.centerIn: parent

            Text {
                color: Appearance.palette.foregroundColor
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
                text: qsTr("100")
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            sliderPopup.visible = !sliderPopup.visible;
        }
        onEntered: {
            background.color = Appearance.palette.comment;
        }
        onExited: {
            background.color = "transparent";
        }
    }

    RowLayout {
        id: textContainer
        anchors.centerIn: background

        Text {
            id: iconText
            color: Appearance.palette.magenta
            text: Audio.isMuted ? "" : root.audioVolumeIconLevel(root.volume)
        }

        Text {
            id: volumeText
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main
            text: root.volume + "%"
        }
    }
}
