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
                color: Appearance.palette.backgroundColor1
                border.color: Appearance.palette.grey0
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

                    implicitWidth: centerBackground.implicitWidth
                    implicitHeight: centerBackground.implicitHeight
                    anchors.centerIn: parent

                    Rectangle {
                        id: centerBackground
                        implicitWidth: 10
                        implicitHeight: 10
                    }
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
