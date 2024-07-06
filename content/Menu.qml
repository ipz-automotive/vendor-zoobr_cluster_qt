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
// import QtQuickUltralite.Extras 2.0
import ZoobrCluster 1.0
import Qt5Compat.GraphicalEffects
Row {
    signal clicked(int index);
    property int currentIndex;
    id: menu;
    Repeater {
        model: ListModel {
            ListElement { text: "Play"; image: "images/play.png"}
            ListElement { text: "Navi"; image: "images/navi.png"}
            ListElement { text: "Phone"; image: "images/phone.png"}
            ListElement { text: "Setup"; image: "images/setup.png"}
        }
        delegate: Item {
            width: 47;
            height: 38;
            property bool active: index == currentIndex;
            Image {
                id: img
                ColorOverlay {
                    anchors.fill: img
                    source: img
                    color: parent.active ? Style.lightPeriwinkle : "#001b4d";
                     Behavior on color { ColorAnimation { duration: 600; easing.type: Easing.InCubic } }
                }

                source: model.image;
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                text: model.text;
                anchors.bottom: parent.bottom;
                anchors.horizontalCenter: parent.horizontalCenter;
                opacity: parent.active ? 1 : 0;
                Behavior on opacity { NumberAnimation { duration: 600; easing.type: Easing.InCubic } }
                font.pixelSize: 12;
                font.family: "Sarabun";
                color: Style.lightPeriwinkle;
            }
        }
    }
}
