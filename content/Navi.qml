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

NormalModeContentItem  {
    id: root
    property real scale: 1

    Row {
        y:151 + 14 - height;
        anchors.horizontalCenter: parent.horizontalCenter;
        spacing: 4

        Text {
            text: NaviModel.filteredDistanceToNextManoeuver;
            font.bold: true;
            font.pixelSize: 24;
            font.family: "Sarabun";
            color: Style.lightPeriwinkle
        }

        Text {
            text: Units.shortDistanceUnit;
            font.bold: true;
            font.pixelSize: 24;
            font.family: "Sarabun";
            color: Style.lightPeriwinkle
        }
    }

    Text {
        id: instruction
        y:178;
        anchors.horizontalCenter: parent.horizontalCenter;
        text: NaviModel.instruction
        font.bold: true;
        font.pixelSize: 14
        font.family: "Sarabun";
        color: Style.lightPeriwinkle
    }
    Text {
        anchors.top: instruction.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter;
        text: NaviModel.street
        font.bold: true;
        font.pixelSize: 18
        font.family: "Sarabun";
        color: Style.lightPeriwinkle
    }
}
