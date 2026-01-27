import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules

Scope {
    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            id: bar
            property var modelData
            screen: modelData
            aboveWindows: false
            color: Appearance.palette.backgroundColor
            implicitHeight: 40

            property var windowObject: this

            anchors {
                top: true
                left: true
                right: true
            }

            Item {
                id: leftSide

                height: bar.height
                width: bar.width / 2

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    id: leftSideBackground
                    implicitWidth: leftRow.implicitWidth + 8
                    implicitHeight: leftRow.implicitHeight
                    color: "transparent"
                    anchors {
                        fill: parent
                    }
                }

                RowLayout {
                    id: leftRow

                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }

                    Workspaces {}
                }
            }

            Item {
                id: rightSide

                height: bar.height
                width: bar.width / 2

                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    id: rightSideBackground
                    implicitWidth: rightRow.implicitWidth + 8
                    implicitHeight: rightRow.implicitHeight
                    color: "transparent"
                    anchors {
                        fill: parent
                    }
                }

                RowLayout {
                    id: rightRow
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    UpdatesWidget {}

                    AudioWidget {}

                    BatteryIndicator {}

                    NetworkWidget {}

                    ClockWidget {}
                }
            }
        }
    }
}
