import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules
import qs.widgets

Scope {
    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            id: bar
            property var modelData
            screen: modelData
            aboveWindows: false
            color: "transparent"
            implicitHeight: 35

            property var windowObject: this

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 5
                left: 5
                right: 5
            }

            Rectangle {
                id: barBackground
                color: Appearance.palette.backgroundColor
                border.color: Appearance.palette.grey0
                anchors.fill: parent
            }

            SystemShutdownWidget {
                id: shutdownWidget
                screen: bar.screen
            }

            Item {
                id: leftSide

                height: bar.height
                width: bar.width / 2

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 10
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

                    SystemShutdown {
                        shutdownWindow: shutdownWidget
                    }

                    Rectangle {
                        implicitWidth: 4
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
                    rightMargin: 10
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
