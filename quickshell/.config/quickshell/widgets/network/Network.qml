import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import "network_functions.js" as Functions

Rectangle {
    id: root

    required property string name
    required property string bssid
    required property string bars
    required property bool hasSecurity
    property bool expanded: false
    property bool isConnected: false

    signal toggled

    implicitWidth: content.implicitWidth + border.width * 2
    implicitHeight: content.implicitHeight + border.width * 2

    color: Appearance.palette.color3
    border.color: Appearance.palette.color11

    onExpandedChanged: {
        if (expanded && hasSecurity) {
            Qt.callLater(function () {
                if (expandedArea.visible && passwordField.visible) {
                    passwordField.forceActiveFocus();
                }
            });
        } else if (hasSecurity) {
            passwordField.text = "";
        }
    }

    ColumnLayout {
        id: content
        spacing: 0
        anchors.fill: parent
        anchors.margins: root.border.width

        Rectangle {
            implicitWidth: headerRow.implicitWidth
            implicitHeight: headerRow.implicitHeight
            color: root.color
            Layout.fillWidth: true

            RowLayout {
                id: headerRow

                anchors.fill: parent

                Text {
                    id: networkName
                    text: root.name
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    Layout.alignment: Qt.AlignLeft
                }

                Text {
                    id: networkStrength
                    text: root.hasSecurity ? Functions.barToWifiSecurity(root.bars) : Functions.barToWifi(root.bars)
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    Layout.alignment: Qt.AlignRight
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.toggled()
            }
        }

        FocusScope {
            id: expandedArea

            visible: root.expanded

            Layout.fillWidth: true
            Layout.preferredHeight: root.expanded ? inputColumn.implicitHeight : 0

            Rectangle {
                id: expandedAreaBackground
                color: root.color
                anchors.fill: parent
                anchors.margins: root.border.width

                ColumnLayout {
                    id: inputColumn

                    anchors.fill: parent

                    TextField {
                        id: passwordField
                        visible: root.hasSecurity
                        placeholderText: "senha"
                        placeholderTextColor: "black"
                        font.family: Appearance.font.family.main
                        echoMode: TextInput.Password
                        passwordCharacter: "*"

                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 5
                    }

                    Button {
                        id: connectButton
                        text: "conectar"
                        font.family: Appearance.font.family.main

                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: 5

                        onClicked: NetworkService.connectToNetwork(root.name, root.bssid, passwordField.text)
                    }
                }
            }
        }
    }
}
