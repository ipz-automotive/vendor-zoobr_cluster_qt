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
    id: root

    property real scale: 1
    property int arrowType: NaviModel.arrowType

    visible: arrowType != NaviModel.ArrowNone

    property bool _newArrowPending: false;

    GuideArrow {
        id: arrow
        scale: root.scale
        xOrigin: root.width / 2
        yOrigin: root.height
    }

    property bool _arrowSwitchAnimationActive: false

    ParallelAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation {
            target: arrow
            property: "arrowOffset"

            from: -8
            to: 0
            duration: 2400
        }

        SequentialAnimation {
            NumberAnimation {
                easing.type: Easing.InQuad
                duration: 150
                target: arrow
                property: "opacity"
                from: _arrowSwitchAnimationActive ? 0 : 1
                to: 1
            }
            ScriptAction {
                script: _arrowSwitchAnimationActive = false;
            }
            PauseAnimation {
                duration: 2100
            }
            ScriptAction {
                script: {
                    if (_newArrowPending) {
                      _arrowSwitchAnimationActive = true;
                      _newArrowPending = false;
                    }
                }
            }
            NumberAnimation {
                easing.type: Easing.OutQuad
                duration: 150
                target: arrow
                property: "opacity"
                from: 1
                to: _arrowSwitchAnimationActive ? 0 : 1
            }
            ScriptAction {
                script: if (_arrowSwitchAnimationActive) arrow.source = NaviModel.getArrowSource();
            }
        }
    }

    //Component.onCompleted: arrow.source = NaviModel.getArrowSource()

    Connections {
        target: NaviModel
        function onArrowTypeChanged(arrow: int) {
            _newArrowPending = true;
        }
    }
}
