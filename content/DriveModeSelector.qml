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

Column {
    id: driveModeSelector
    spacing: 15
    Repeater {
        model: ListModel {
            ListElement { img: "images/gauge-normal.png"; txt: "Normal"; }
            ListElement { img: "images/sport.png"; txt: "Sport"; }
        }
        delegate: Item {
            width: driveModeSelector.width;
            height: 24
            opacity: index == SettingsMenuModel.currentDriveModeSelected ? 1.0 : 0.3
            Row {
                height: 24;
                spacing: 17
                Image {
                    source: model.img;
                }
                Text {
                    text: model.txt;
                    font.pixelSize: 20;
                    color: Style.lightPeriwinkle;
                    font.family: "Sarabun";
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }
    }
}
