import QtQuick
import QtQuick.Layouts
import qs.services
import Quickshell

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    function batteryIconLevel(): string {
        let level = Battery.percentage * 100;
        if (level > 90) {
            return "󰁹";
        } else if (level > 80 && level <= 90) {
            return "󰂂";
        } else if (level > 70 && level <= 80) {
            return "󰂁";
        } else if (level > 60 && level <= 70) {
            return "󰂀";
        } else if (level > 50 && level <= 60) {
            return "󰁿";
        } else if (level > 40 && level <= 50) {
            return "󰁾";
        } else if (level > 30 && level <= 40) {
            return "󰁽";
        } else if (level > 20 && level <= 30) {
            return "󰁼";
        } else if (level > 10 && level <= 20) {
            return "󰁻";
        } else if (level <= 10) {
            return "󰁺";
        }
    }

    function secondsToHourMinutes(seconds: real): string {
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);

        return hours > 0 ? `${hours}h ${minutes}m` : `${minutes}m`;
    }

    Rectangle {
        id: background
        implicitWidth: text.implicitWidth + 8
        implicitHeight: text.implicitHeight
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

    RowLayout {
        id: text
        anchors.centerIn: parent

        Text {
            id: iconText
            text: {
                if (Battery.isCharging || Battery.fullyCharged) {
                    return "";
                } else if (!Battery.isPresent) {
                    return "";
                }
                return root.batteryIconLevel(Battery.percentage * 100);
            }
            color: Appearance.palette.darkGray
        }

        Text {
            id: percentageText
            text: Math.floor(Battery.percentage * 100) + qsTr("%")
            font.family: Appearance.font.family.main
            color: Appearance.palette.foregroundColor
        }
    }

    PopupWindow {
        id: batteryTimePopup
        visible: false
        implicitWidth: batteryTimeText.implicitWidth + 10
        implicitHeight: batteryTimeText.implicitHeight + 10
        color: Appearance.palette.backgroundColor1

        anchor {
            item: root
            rect.y: root.height + 5
            rect.x: root.width / 2 - width / 2
        }

        Text {
            id: batteryTimeText
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main
            text: {
                if (Battery.fullyCharged) {
                    return "Carga cheia";
                }
                if (Battery.isDischarging) {
                    const text = "Tempo restante: " + root.secondsToHourMinutes(Battery.timeToEmpty);
                    return text;
                } else if (Battery.isCharging) {
                    const text = "Tempo para carga: " + root.secondsToHourMinutes(Battery.timeToFull);
                    return text;
                }
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            background.color = Appearance.palette.comment;
            batteryTimePopup.visible = true;
        }
        onExited: {
            background.color = "transparent";
            batteryTimePopup.visible = false;
        }
    }
}
