/******************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Ultralite module.
**
** $QT_BEGIN_LICENSE:COMM$
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** $QT_END_LICENSE$
**
******************************************************************************/
pragma Singleton
import QtQuick 2.15

QtObject {
    id: mediaplayermodel
    property bool mediaPlayback: MainModel.introSequenceCompleted

    // onMediaPlaybackChanged: {
    //     ConnectivityService.mediaPlayback = mediaplayermodel.mediaPlayback
    // }

    function play() {
        mediaplayermodel.mediaPlayback = true
    }
    function stop() {
        mediaplayermodel.mediaPlayback = false
    }
    function nextSong() {
        track = (track+1)%trackCount
    }
    function previousSong() {
        track = (track+trackCount-1)%trackCount
    }

    property int track: 0
    property int timePassed: 0 // sec
    readonly property int trackCount: 5
    readonly property int changeSongDuration: 300

    onTrackChanged: {
        timePassed = 0
    }

    onTimePassedChanged: {
        var duration = 0
        switch (track) {
            case 0: duration = 3.5; break;
            case 1: duration = 3.8; break;
            case 2: duration = 3.2; break;
            case 3: duration = 3.5; break;
            case 4: duration = 4.5; break;
        }
        if (timePassed > (duration * 60)) {
            nextSong()
        }
    }

    property Timer timePassedTimer: Timer {
        running: mediaplayermodel.mediaPlayback
        repeat: true
        interval: 1000
        onTriggered: { timePassed += 1 }
    }
}
