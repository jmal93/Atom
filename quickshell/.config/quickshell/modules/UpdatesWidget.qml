import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import Quickshell

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    Rectangle {
        id: background
        implicitWidth: textWidget.implicitWidth + 8
        implicitHeight: textWidget.implicitHeight
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
        id: textWidget
        anchors.centerIn: parent

        Text {
            id: iconText
            color: Appearance.palette.orange
            font.pixelSize: Updates.isThereUpdates ? 15 : 13
            text: Updates.isThereUpdates ? "󰚰" : ""
            Layout.alignment: Qt.AlignVCenter
        }

        Rectangle {
            visible: Updates.isThereUpdates
            color: "transparent"
            Layout.alignment: Qt.AlignVCenter
            implicitWidth: numberText.implicitWidth
            implicitHeight: numberText.implicitHeight

            Text {
                id: numberText
                text: Updates.numberOfUpdates
                color: Appearance.palette.foregroundColor
                font.family: Appearance.font.family.main
                anchors.centerIn: parent
            }
        }
    }

    PopupWindow {
        id: listOfUpdates
        visible: false
        implicitWidth: column.implicitWidth + 20
        implicitHeight: column.implicitHeight + 10

        anchor {
            item: root
            rect.y: root.height
            rect.x: root.width / 2 - width / 2
            margins.top: 16
        }

        Rectangle {
            id: popUpBackground
            color: Appearance.palette.backgroundColor1
            border.color: Appearance.palette.orange
            anchors.fill: parent
        }

        ColumnLayout {
            id: column

            anchors {
                centerIn: parent
            }

            Rectangle {
                id: listScrollBackground
                color: Appearance.palette.backgroundDark
                border.color: Appearance.palette.mediumGray
                implicitWidth: listScroll.implicitWidth + 5
                implicitHeight: listScroll.implicitHeight + 10

                ScrollView {
                    id: listScroll
                    implicitWidth: listOfUpdatesText.implicitWidth
                    implicitHeight: {
                        if (listOfUpdatesText.implicitHeight >= 300) {
                            return 300;
                        }

                        return listOfUpdatesText.implicitHeight;
                    }

                    anchors {
                        centerIn: parent
                    }

                    Label {
                        id: listOfUpdatesText
                        text: {
                            if (!Updates.isThereUpdates) {
                                return "Tudo atualizado :)";
                            }

                            return Updates.listOfUpdates;
                        }
                        color: Appearance.palette.foregroundColor
                        font.family: Appearance.font.family.main
                    }
                }
            }

            Rectangle {
                id: updateButton
                implicitWidth: updateButtonText.implicitWidth + 8
                implicitHeight: updateButtonText.implicitHeight
                Layout.alignment: Qt.AlignCenter
                color: "transparent"
                visible: Updates.isThereUpdates ? true : false

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Text {
                    id: updateButtonText
                    text: "Atualizar"
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        updateButton.color = Appearance.palette.comment;
                    }
                    onExited: {
                        updateButton.color = "transparent";
                    }
                    onClicked: {
                        Updates.updateSystem();
                        listOfUpdates.visible = false;
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            listOfUpdates.visible = !listOfUpdates.visible;
        }
        onEntered: {
            background.color = Appearance.palette.comment;
        }
        onExited: {
            background.color = "transparent";
        }
    }
}
