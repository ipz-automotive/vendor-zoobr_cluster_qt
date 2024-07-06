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

Item {
    id: laneAssist

    property real redBorderOpacity: 0
    property real scale: 1

    Image {
        id: leftLaneAssist

        source: "images/red-border-left.png"
        opacity: redBorderOpacity
        x: 306
        y: 280
        width: 70
        height: 200

        transform: Scale {
            origin.x: laneAssist.width / 2 - leftLaneAssist.x
            origin.y: laneAssist.height - leftLaneAssist.y

            xScale: laneAssist.scale
            yScale: laneAssist.scale
        }
    }

    Image {
        id: rightLaneAssist

        source: "images/red-border-right.png"
        opacity: redBorderOpacity
        x: 424
        y: 280
        width: 70
        height: 200

        transform: Scale {
            origin.x: laneAssist.width / 2 - rightLaneAssist.x
            origin.y: laneAssist.height - rightLaneAssist.y

            xScale: laneAssist.scale
            yScale: laneAssist.scale
        }
    }

    SequentialAnimation {
        id: laneAssistAnimation
        loops: 4
        alwaysRunToEnd: true

        NumberAnimation {
            target: laneAssist
            property: "redBorderOpacity"
            from: 0
            to: 0.7
            easing.type: Easing.OutQuad
            duration: 600
        }

        NumberAnimation {
            target: laneAssist
            property: "redBorderOpacity"
            from: 0.7
            to: 0
            easing.type: Easing.InQuad
            duration: 600
        }

        PauseAnimation {
            duration: 300
        }
    }

    Connections {
        target: MainModel
        function onTriggerLaneAssist(side: int) {
            leftLaneAssist.visible = side === 0;
            rightLaneAssist.visible = side === 1;
            if (side === 0 || side === 1)
                laneAssistAnimation.start()
        }
    }

    LaneAssistWhiteLine {
        t: t0
        scale: laneAssist.scale
        location: LaneAssistWhiteLine.Left
    }

    LaneAssistWhiteLine {
        t: t1 > 1 ? t1 - 1 : t1
        scale: laneAssist.scale
        location: LaneAssistWhiteLine.Left
    }

    LaneAssistWhiteLine {
        t: t0
        scale: laneAssist.scale
        location: LaneAssistWhiteLine.Right
    }

    LaneAssistWhiteLine {
        t: t1 > 1 ? t1 - 1 : t1
        scale: laneAssist.scale
        location: LaneAssistWhiteLine.Right
    }

    property real t0: 0
    property real t1: t0 + 0.5

    NumberAnimation on t0 {
        from: 0
        to: 1
        loops: Animation.Infinite
        duration: MainModel.speed > 0 ? 60000 / MainModel.speed : 0;
        running: MainModel.laneAssistCarMoving && MainModel.speed > 0
    }
}
