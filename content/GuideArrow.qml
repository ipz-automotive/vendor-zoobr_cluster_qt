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
    id: arrow

    property real scale: 1
    property int xOrigin
    property int yOrigin

    x: 389
    y: 333

    property real arrowOffset

    transform: [
        Translate {
            y: arrow.arrowOffset
        },
        Scale {
            xScale: 1.1
            yScale: 1.1
        },
        Scale {
            origin.x: xOrigin - arrow.x
            origin.y: yOrigin - arrow.y

            xScale: scale
            yScale: scale
        }
    ]
}
