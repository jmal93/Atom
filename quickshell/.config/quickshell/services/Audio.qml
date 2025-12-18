pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool isMuted: sink.audio.muted
    readonly property real volume: Math.floor(sink.audio.volume * 100)

    function changeVolume(newVolume: real): void {
        sink.audio.volume = newVolume;
    }

    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}
