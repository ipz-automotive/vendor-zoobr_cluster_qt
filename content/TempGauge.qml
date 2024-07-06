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

BaseGauge {
    id: root;
    needleOffsetY: -13
    gaugeSource: sportGauge
    needleSource: sportNeedle
    highlightSource: sportHighlight

    Image {
        id: icon
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 15
        source: "images/oil-temp.png"
    }

    Text {
        anchors.horizontalCenter: icon.horizontalCenter
        anchors.horizontalCenterOffset: -7
        anchors.bottom: icon.top
        anchors.bottomMargin: 110
        width: 5; height: width
        text: "Hot"
        color: Style.lightPeriwinkle
        font.pixelSize: 12
        font.family: "Sarabun"
    }
    Text {
        anchors.horizontalCenter: icon.horizontalCenter
        anchors.horizontalCenterOffset: -7
        anchors.top: icon.bottom
        anchors.topMargin: 95
        width: 5; height: width
        text: "Cool"
        color: Style.lightPeriwinkle
        font.pixelSize: 12
        font.family: "Sarabun"
    }
}
