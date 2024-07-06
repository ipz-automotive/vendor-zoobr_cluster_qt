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
    id: root;
    property bool active: false

    Component.onCompleted: active = true

    // Connections {
    //     target: MainModel
    //     function onClusterModeChanged(clusterMode: int) {
    //         active = false
    //    }
    // }

    MiddleGauge {
        id: middleGauge
        isLeft: true
        anchors.horizontalCenter: parent.horizontalCenter
        valueVerticalCenterOffset: -27
        y: 62;
        value: MainModel.rpm / 1000;
        maxValue: MainModel.maxRpm / 1000;
        valueText: MainModel.gearShiftText
        textLabel: "Gear shift"
        maxAngle: 285
        minAngle: 45
        labelOpacity: (menu.active || !root.active) ? 0 : 1
        opacity: 0;

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: -105
            anchors.verticalCenterOffset: 95

            opacity: 0.2
            horizontalAlignment: Text.AlignRight
            text: "x1000\n    RPM"
            color: Style.lightPeriwinkle
            font.pixelSize: 10
            font.family: "Sarabun"
        }
    }

    Item {
        id: gauges
        opacity: 1;

        // SpeedWarningIndicator {
        //     opacity: leftGauge.opacity
        //     anchors.horizontalCenter: leftGauge.horizontalCenter
        //     anchors.horizontalCenterOffset: leftGauge.labelHorizontalCenterOffset
        //     y: 295
        //     width: 44
        // }

        SportGauge {
            id: leftGauge;
            x: root.width / 3
            y: 44;
            isLeft: true;
            value: Units.kilometersToLongDistanceUnit(MainModel.speed)
            maxValue: Units.maximumSpeed;
            textLabel: Units.speedUnit
            valueTextScale: 0.8;
            valueHorizontalCenterOffset: -20;
            labelHorizontalCenterOffset: -18;
            labelVerticalOffset: -5;
        }

        TempGauge {
            id: rightGauge;
            x: root.width - rightGauge.width - root.width / 3;
            y: 44;
            value: MainModel.temp;
            maxValue: 180;
            maxAngle: 180;

            opacity: MainModel.gaugesOpacity;
        }
    }

    DriveModeSelector {
        id: modeSelector

        anchors.centerIn: middleGauge
        anchors.verticalCenterOffset: -36
        anchors.horizontalCenterOffset: -65
        spacing: 15
        opacity: menu.active ? 1 : 0

        Behavior on opacity { NumberAnimation { duration: 600 } }
    }

    Item {
        id: menu
        property bool active: SportModeModel.menuActive && root.active
        opacity: gauges.opacity
        anchors.horizontalCenter: middleGauge.horizontalCenter;
        anchors.verticalCenter: middleGauge.verticalCenter;
        anchors.horizontalCenterOffset: 70
        anchors.verticalCenterOffset: 80
        width: 47
        height: 38
        Image {
            id: img
            ColorOverlay {
                anchors.fill: img
                source: img
                color: parent.active ? Style.lightPeriwinkle : "#001b4d"
                Behavior on color { ColorAnimation { duration: 600; easing.type: Easing.InCubic } }
            }

            source: "images/setup.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: "Setup"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: parent.active ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 600; easing.type: Easing.InCubic } }
            font.pixelSize: 12;
            font.family: "Sarabun";
            color: Style.lightPeriwinkle;
        }
    }

    states: [
        State {
            name: "active"
            when: active
            PropertyChanges {
                target: middleGauge
                opacity: 1;//MainModel.gaugesOpacity
            }
            PropertyChanges {
                target: gauges
                opacity: 1;//MainModel.gaugesOpacity
            }
            PropertyChanges {
                target: leftGauge
                x: 20
            }
            PropertyChanges {
                target: rightGauge
                x: root.width - rightGauge.width - 20;
            }
        }
    ]

    transitions: [
        Transition {
            to: "active"
            SequentialAnimation {
                NumberAnimation {
                    target: middleGauge
                    duration: 250
                }
                ParallelAnimation {
                    NumberAnimation {
                        easing.type: Easing.Linear
                        target: gauges;
                        duration: 250;
                    }
                    NumberAnimation {
                        easing.type: Easing.OutExpo
                        target: leftGauge;
                        duration: 350;
                    }
                    NumberAnimation {
                        easing.type: Easing.OutExpo
                        target: rightGauge;
                        duration: 350;
                    }
                }
            }
        },
        Transition {
            from: "active"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        easing.type: Easing.Linear
                        target: gauges;
                        duration: 250;
                    }
                    NumberAnimation {
                        easing.type: Easing.InExpo
                        target: leftGauge;
                        duration: 350;
                    }
                    NumberAnimation {
                        easing.type: Easing.InExpo
                        target: rightGauge;
                        duration: 350;
                    }
                    NumberAnimation {
                        easing.type: Easing.InExpo
                        target: rightGauge
                        duration: 350
                    }
                }
                NumberAnimation {
                    target: middleGauge
                    duration: 250
                }
            }
        }
    ]
}
