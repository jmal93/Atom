import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import Quickshell

Widget {
    id: root

    icon: Updates.isThereUpdates ? "󰚰" : ""
    text: Updates.numberOfUpdates
    onClicked: listOfUpdates.visible = !listOfUpdates.visible

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
            color: Appearance.palette.backgroundColor
            border.color: Appearance.palette.color8
            anchors.fill: parent
        }

        ColumnLayout {
            id: column

            anchors {
                centerIn: parent
            }

            Rectangle {
                id: listScrollBackground
                color: Appearance.palette.color6
                border.color: Appearance.palette.color14
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
}
