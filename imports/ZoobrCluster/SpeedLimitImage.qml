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

import QtQuick 2.15

Image {
    property int limit
    visible: limit != SpeedLimitValues.None
    source: {
        switch (limit) {
        case SpeedLimitValues.VerySlow:
            return "images/speed-limit-warnings/30.png"
        case SpeedLimitValues.Slow:
            return "images/speed-limit-warnings/50.png"
        case SpeedLimitValues.Medium:
            return "images/speed-limit-warnings/70.png"
        case SpeedLimitValues.Fast:
            return "images/speed-limit-warnings/90.png"
        default:
            return "images/speed-limit-warnings/140.png"
        }
    }
}
