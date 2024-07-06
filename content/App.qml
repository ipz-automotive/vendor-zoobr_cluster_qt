// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import ZoobrCluster 1.0
import Main 1.0

Window {
    width: Constants.width
    height: Constants.height

    visible: true
    title: "ZoobrCluster"

    ClusterScreen {
        id: clusterScreen
    }

    // InputPanel {
    //     id: inputPanel
    //     property bool showKeyboard :  active
    //     y: showKeyboard ? parent.height - height : parent.height
    //     Behavior on y {
    //         NumberAnimation {
    //             duration: 200
    //             easing.type: Easing.InOutQuad
    //         }
    //     }
    //     anchors.leftMargin: Constants.width/10
    //     anchors.rightMargin: Constants.width/10
    //     anchors.left: parent.left
    //     anchors.right: parent.right
    // }
}

