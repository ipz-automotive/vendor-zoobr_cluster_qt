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
import Qt5Compat.GraphicalEffects

Item {
    id: indicator
    height: 28;
    width: image.width + 15;

    property alias source: image.source;
    property bool active: false;
    property color activeColor: Style.highlighterGreen
    property color inactiveColor: Style.darkBlue;
    //property alias opacity: image.opacity;
    property alias blinking: indicatorBlinkAnimation.running

    Image  {
        id: image;
        ColorOverlay {
                anchors.fill: image
                source: image
                color: active ? activeColor : inactiveColor;
                Behavior on color { ColorAnimation {
                    duration: 150;
                    easing.type: Easing.InOutQuad;
                }}
                Behavior on opacity { NumberAnimation {
                    easing.type: Easing.InOutQuad;
                    duration: TellTalesModel.opacityChangeDuration;
                }}
        }
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter: parent.verticalCenter;
    }

    SequentialAnimation {
        id: indicatorBlinkAnimation
        loops: Animation.Infinite
        alwaysRunToEnd: true

        ScriptAction {
            script: indicator.active = true;
        }

        PauseAnimation {
            duration: 400
        }

        ScriptAction {
            script: indicator.active = false;
        }

        PauseAnimation {
            duration: 300
        }
    }
}
