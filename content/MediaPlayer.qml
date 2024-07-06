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

import QtQuick 6.7
import ZoobrCluster 1.0

NormalModeContentItem {
    Repeater {
        model: ListModel {
            // FIXME: https://bugreports.qt.io/browse/UL-597
            // Durations are used in MediaPlayerModel.qml
            ListElement {
                artist: "Thomas Lammer";
                song: "Setsuna";
                cover: "images/albums/juno.png";
            }
            ListElement {
                artist: "Thievery Corporation";
                song: "Le Monde";
                cover: "images/albums/thievery-corp.png";
            }
            ListElement {
                artist: "Tycho";
                song: "Aweke";
                cover: "images/albums/tycho.png";
            }
            ListElement {
                artist: "De Phazz";
                song: "Chocolate";
                cover: "images/albums/phazz.png";
            }
            ListElement {
                artist: "AK";
                song: "Discovery";
                cover: "images/albums/ak.png";
            }
            // ListElement {
            //     artist: "BURZUM";
            //     song: "Dunkelheit";
            //     cover: "images/albums/filosofem.png";
            // }
        }

        Item {
            anchors.fill: parent
            property int pos: -(-(10 + index - MediaPlayerModel.track%5 + 2) % 5) - 2

            Text {
                id: artistTxt
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 77
                text: model.artist
                font.bold: true
                font.pixelSize: 16
                font.family: "Sarabun"
                color: Style.lightPeriwinkle
                opacity: pos == 0 ? 1 : 0;
                Behavior on opacity { NumberAnimation{ duration: MediaPlayerModel.changeSongDuration } }
            }
            Text {
                id: songTxt
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 96
                text: model.song;
                font.pixelSize: 14
                font.family: "Sarabun"
                color: Style.lightPeriwinkle
                opacity: artistTxt.opacity
            }

            Image {
                id: img
                x: (parent.width - width) / 2 + Math.max(Math.min(pos, 1), -1) * 49
                Behavior on x {
                    NumberAnimation{
                        duration: MediaPlayerModel.changeSongDuration
                        easing.type: pos == 1 ? Easing.OutQuad : Easing.OutCubic
                    }
                }
                opacity: pos == 0 ? 1 : Math.abs(pos) == 1 ? 0.25 : 0
                Behavior on opacity { NumberAnimation{ duration: MediaPlayerModel.changeSongDuration } }
                y: 121
                source: model.cover
            }
            z: img.opacity > 0.90 ? 1 : -Math.abs(pos);
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter;
        y: 262
        id: durationLabel
        visible: MainModel.introSequenceCompleted
        Text {
            text: Math.floor(MediaPlayerModel.timePassed / 60)
            font.pixelSize: 14
            font.family: "Sarabun"
            color: Style.lightPeriwinkle
        }
        Text {
            text: (MediaPlayerModel.timePassed % 60) < 10 ? ":0" : ":"
            font.pixelSize: 14
            font.family: "Sarabun"
            color: Style.lightPeriwinkle
        }
        Text {
            text: Math.floor(MediaPlayerModel.timePassed % 60)
            font.pixelSize: 14
            font.family: "Sarabun"
            color: Style.lightPeriwinkle
        }
    }

    SequentialAnimation {
        running: !MediaPlayerModel.mediaPlayback && MainModel.introSequenceCompleted
        loops: Animation.Infinite
        alwaysRunToEnd: true
        PropertyAnimation {
            target: durationLabel
            property: "opacity"
            duration: 400
            from: 1.0
            to: 0.0
        }
        PauseAnimation {
            duration: 100
        }
        PropertyAnimation {
            target: durationLabel
            property: "opacity"
            duration: 400
            from: 0.0
            to: 1.0
        }
    }
}
