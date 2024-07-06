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

Image {
    id: root

    enum Location { Left = 0, Right = 1 }

    property int location: LaneAssistWhiteLine.Left
    property real scale: 1

    property real t: 0

    // line animation
    property real s: 0.1 + t * t * 1.9

    source: location == LaneAssistWhiteLine.Left ? "images/white-line-left.png"
                                                 : "images/white-line-right.png"

    x: location == LaneAssistWhiteLine.Left ? 326 : 454
    y: 386

    opacity: Math.min(1 - (1 - s) * (1 - s), 1)

    transform: [
        // line animation
        Scale {
            xScale: s
            yScale: s

            origin.x: location == LaneAssistWhiteLine.Left ? 42 : -22
            origin.y: -86
        },
        // navi scale
        Scale {
            origin.x: 400 - root.x
            origin.y: 480 - root.y

            xScale: scale
            yScale: scale
        }
    ]
}
