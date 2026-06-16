import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import "network_functions.js" as Functions

PopupWindow {
    id: root
    visible: false
    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight

    Rectangle {
        id: popUpBackground

        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8
        anchors.fill: parent
    }

    Rectangle {
        id: padding

        implicitWidth: column.implicitWidth + 10
        implicitHeight: column.implicitHeight + 10
        color: "transparent"

        ColumnLayout {
            id: column

            anchors.centerIn: parent

            RowLayout {

                Layout.alignment: Qt.AlignCenter

                Text {
                    id: connectedNetworkText
                    text: NetworkService.name
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    font.pixelSize: 14
                }

                Text {
                    id: connectedNetworkStrength
                    text: Functions.barToWifi(NetworkService.strength)
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    font.pixelSize: 14
                }
            }

            Rectangle {
                implicitWidth: networkList.implicitWidth + 10
                implicitHeight: networkList.implicitHeight + 10
                color: "transparent"

                NetworkList {
                    id: networkList
                }
            }
        }
    }
}
