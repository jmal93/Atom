import QtQuick
import Quickshell
import qs.services as Services

PopupWindow {
    visible: false
    implicitWidth: networkName.implicitWidth + 10
    implicitHeight: networkName.implicitHeight + 10

    Rectangle {
        color: Services.Appearance.palette.backgroundColor
        border.color: Services.Appearance.palette.color8
        anchors.fill: parent
    }

    Text {
        id: networkName
        text: qsTr(Services.NetworkService.name)
        color: Services.Appearance.palette.foregroundColor
        font.family: Services.Appearance.font.family.main

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }
}
