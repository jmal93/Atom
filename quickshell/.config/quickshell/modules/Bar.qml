import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.services

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
                border.color: Appearance.palette.color8
                anchors.fill: parent

                Item {
                    id: leftSide

                    implicitWidth: leftRow.implicitWidth
                    implicitHeight: leftRow.implicitHeight
                    anchors {
                        left: parent.left
                        leftMargin: 4
                        verticalCenter: parent.verticalCenter
                    }

                    RowLayout {
                        id: leftRow

                        SystemShutdown {
                            shutdownWindow: shutdownWidget
                        }

                        SystemShutdownWidget {
                            id: shutdownWidget
                            screen: bar.screen
                        }

                        Rectangle {
                            implicitWidth: 4
                        }

                        Workspaces {}
                    }
                }

                Item {
                    id: center
                    anchors.centerIn: parent

                    CurrentWindow {}
                }

                Item {
                    id: rightSide

                    implicitWidth: rightRow.implicitWidth
                    implicitHeight: rightRow.implicitHeight
                    anchors {
                        right: parent.right
                        rightMargin: 4
                        verticalCenter: parent.verticalCenter
                    }

                    RowLayout {
                        id: rightRow

                        spacing: 10

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
}
