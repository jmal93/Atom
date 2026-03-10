import QtQuick
import QtQuick.Layouts
import qs.services
import Quickshell

Widget {
    id: root

    icon: {
        if (Battery.isCharging || Battery.fullyCharged) {
            return "";
        } else if (!Battery.isPresent) {
            return "";
        }
        return root.batteryIconLevel(Battery.percentage * 100);
    }
    text: Math.floor(Battery.percentage * 100) + qsTr("%")
    onClicked: batteryTimePopup.visible = !batteryTimePopup.visible

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

    RowLayout {
        id: text
        anchors.centerIn: parent

        Text {
            id: iconText
            color: Appearance.palette.color1
        }

        Text {
            id: percentageText
            font.family: Appearance.font.family.main
            color: Appearance.palette.color15
        }
    }

    PopupWindow {
        id: batteryTimePopup
        visible: false
        implicitWidth: batteryTimeText.implicitWidth + 10
        implicitHeight: batteryTimeText.implicitHeight + 10

        Rectangle {
            color: Appearance.palette.backgroundColor
            border.color: Appearance.palette.color8
            anchors.fill: parent
        }

        anchor {
            item: root
            rect.y: root.height
            rect.x: root.width / 2 - width / 2
            margins.top: 16
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
}
