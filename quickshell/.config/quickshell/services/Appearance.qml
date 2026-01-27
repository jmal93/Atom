pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property QtObject palette: QtObject {
        readonly property color foregroundColor: "#fbf1c7"
        readonly property color backgroundColor: "#0d0e0f"
        readonly property color backgroundDark: "#242424"
        readonly property color backgroundColor1: "#202020"
        readonly property color gray: "#dedede"
        readonly property color comment: "#665c54"
        readonly property color mediumGray: "#504945"
        readonly property color darkGray: "#83a598"
        readonly property color softYellow: "#eebd35"
        readonly property color magenta: "#b16286"
        readonly property color softGreen: "#98971a"
        readonly property color forestGreen: "#689d6a"
        readonly property color orange: "#d65d0e"
    }

    readonly property QtObject font: QtObject {
        property QtObject family: QtObject {
            property string main: "Jetbrains Mono Nerd Font"
        }
    }
}
