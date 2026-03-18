import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services

Rectangle {
    id: root

    required property string name
    required property string bars
    required property bool hasSecurity
    property bool expanded: false

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    color: "red"

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

    function barToWifi(bar: string): string {
        switch (bar) {
        case "▂▄▆█":
            return "󰤨";
        case "▂▄▆_":
            return "󰤥";
        case "▂▄__":
            return "󰤢";
        case "▂___":
            return "󰤟";
        default:
            return "󰤫";
        }
    }

    function barToWifiSecurity(bar: string): string {
        switch (bar) {
        case "▂▄▆█":
            return "󰤪";
        case "▂▄▆_":
            return "󰤧";
        case "▂▄__":
            return "󰤤";
        case "▂___":
            return "󰤡";
        default:
            return "󱛏";
        }
    }

    ColumnLayout {
        id: content
        anchors.fill: parent

        Rectangle {
            implicitWidth: headerRow.implicitWidth
            implicitHeight: headerRow.implicitHeight
            color: Appearance.palette.color3
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
                    text: root.hasSecurity ? root.barToWifiSecurity(root.bars) : root.barToWifi(root.bars)
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    Layout.alignment: Qt.AlignRight
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.expanded = !root.expanded
            }
        }

        FocusScope {
            id: expandedArea

            Layout.fillWidth: true
            visible: root.expanded
            Layout.preferredHeight: root.expanded ? inputColumn.implicitHeight : 0

            ColumnLayout {
                id: inputColumn

                anchors.centerIn: parent

                TextField {
                    id: passwordField
                    visible: root.hasSecurity
                    placeholderText: "senha"
                    placeholderTextColor: "black"
                    Layout.alignment: Qt.AlignHCenter
                }

                Button {
                    id: connectButton
                    text: "conectar"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: console.log(passwordField.text)
                }
            }
        }
    }
}
