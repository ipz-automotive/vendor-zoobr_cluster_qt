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
    id: root;
    opacity: 0;
    visible: opacity != 0

    property bool selected: false;

    Connections {
        target: NormalModeModel
        function onMenuChanged(menu: int) {
            selected = false
        }
    }

    Component.onCompleted: selected = true

    states: [
        State {
            name: "hidden";
            when: !selected;
        },
        State {
            name: "visible";
            when: selected;
            PropertyChanges { target: root; opacity: 1.; }
        }
    ]
    transitions: [
        Transition {
            from: "hidden"; to: "visible";
            SequentialAnimation {
                PropertyAnimation { duration: 250; property: "opacity"; }
            }
        },
        Transition {
            from: "visible"; to: "hidden";
            PropertyAnimation { duration: 250; property: "opacity"; }
        }
    ]
}
