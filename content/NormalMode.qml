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
// // import QtQuickUltralite.Extras 2.0
import ZoobrCluster 1.0

Item {
    id: root;
    property bool active: false;
    visible: false

    Component.onCompleted: {
        if(menu == NormalModeModel.CarStatusMenu) {
            leftGauge.opacity = 0
            rightGauge.opacity = 0
            topLine.opacity = 0
            menuChanger.opacity = 0
            leftGauge.x = root.width / 3
            rightGauge.x = root.width - rightGauge.width - root.width / 3
            menuChanger.source = "CarStatus.qml"
        }

        active = true
        visible = true
    }

    Connections {
        target: MainModel
        function onClusterModeChanged(clusterMode: int) {
            active = false
        }
    }

    property int menu: NormalModeModel.menu;
    property bool naviMode: active && menu == NormalModeModel.NavigationMenu;
    property real scale: NormalModeModel.scale;

    Image {
        id: topLine;
        source: "images/top-line.png";
        anchors.horizontalCenter: parent.horizontalCenter;
        y: 62;
    }

    Loader {
        id: menuChanger
        anchors.fill: parent
        source: "MediaPlayer.qml"
    }

    Connections {
        target: NormalModeModel
        function onMenuChanged(menu: int) {
            loadNewMenu.start()
            if (menu === NormalModeModel.NavigationMenu) {
                NormalModeModel.scale = 1.25
            } else {
                NormalModeModel.scale = 1
            }
        }
    }

    Timer {
        id: loadNewMenu
        interval: 250
        onTriggered: {
            switch(menu) {
                case NormalModeModel.MediaPlayerMenu:
                    menuChanger.source = "MediaPlayer.qml"
                    break;
                case NormalModeModel.NavigationMenu:
                    menuChanger.source = "Navi.qml"
                    break;
                case NormalModeModel.PhoneMenu:
                    menuChanger.source = "Phone.qml"
                    break;
                case NormalModeModel.CarStatusMenu:
                    menuChanger.source = "CarStatus.qml"
                    break;
            }
        }
    }

    Item {
        id: gauges
        opacity: 1//MainModel.gaugesOpacity;

        Gauge {
            id: leftGauge;
            x: 20;
            y: 44;
            isLeft: true;
            value: Units.kilometersToLongDistanceUnit(MainModel.speed)
            maxValue: Units.maximumSpeed
            textLabel: Units.speedUnit

            // SpeedWarningIndicator {
            //     id: speedWarningIndicator
            //     x: 218 - width/2
            //     y: 271 - height/2
            //     transform: Scale {
            //         origin.x: 60 - speedWarningIndicator.x
            //         origin.y: 340 - speedWarningIndicator.y
            //         xScale: leftGauge.scale
            //         yScale: leftGauge.scale
            //     }
            // }
        }

        Gauge {
            id: rightGauge;
            x: root.width - rightGauge.width - 20;
            y: 44;
            value: MainModel.rpm / 1000;
            valueText: MainModel.gearShiftText
            maxValue: MainModel.maxRpm / 1000;
            maxAngle: 180
            textLabel: ""

            Text {
                id: rpmLabel
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -35
                anchors.verticalCenterOffset: 100

                opacity: 0.2
                horizontalAlignment: Text.AlignRight
                text: "x1000\n    RPM"
                color: Style.lightPeriwinkle;
                font.pixelSize: 10
                font.family: "Sarabun"

                transform: Scale {
                    origin.x: rightGauge.transformOriginX - rpmLabel.x
                    origin.y: 340 - rpmLabel.y
                    xScale: rightGauge.scale
                    yScale: rightGauge.scale
                }
            }
        }

        Behavior on opacity { NumberAnimation { duration: MainModel.gaugesOpacityChangeDuration; } }
    }

    Menu {
        id: normalMenu;
        opacity: topLine.opacity;
        anchors.horizontalCenter: parent.horizontalCenter;
        y: 293;
        currentIndex: menu;
        onClicked: menu = index;
    }

    Menu {
        id: navModeMenu;
        opacity: 0;
        anchors.horizontalCenter: parent.horizontalCenter;
        y: 87;
        currentIndex: 1;
        onClicked: menu = index;
    }

    states: [
        State {
            name: "inactive"
            when: !active
            PropertyChanges {
                target: menuChanger
                opacity: 0
            }
            PropertyChanges {
                target: topLine
                opacity: 0
            }
            PropertyChanges {
                target: leftGauge
                opacity: 0
                x: root.width / 3;
            }
            PropertyChanges {
                target: rightGauge
                opacity: 0
                x: root.width - rightGauge.width - root.width / 3;
            }
        },
        State {
            name: "navi"
            when: naviMode;
            PropertyChanges { target: navModeMenu; opacity: topLine.opacity; }
            PropertyChanges { target: normalMenu; opacity: 0; }
            PropertyChanges {
                target: leftGauge;
                scale: 0.8
            }
            PropertyChanges {
                target: rightGauge;
                scale: 0.8
            }
        }
    ]

    // FIXME! need to have exact easing curve and timeing from the design
    transitions: [
        Transition {
            from: "inactive"
            SequentialAnimation {
                NumberAnimation {
                    target: menuChanger
                    duration: 350;
                }
                ScriptAction {
                    script: SportModeModel.menuActive = false
                }
                ParallelAnimation {
                    NumberAnimation {
                        easing.type: Easing.OutQuad
                        target: leftGauge;
                        duration: 350;
                    }
                    NumberAnimation {
                        easing.type: Easing.OutQuad
                        target: rightGauge;
                        duration: 350;
                    }
                    NumberAnimation {
                        easing.type: Easing.InQuad
                        target: topLine
                        duration: 400;
                    }
                }
            }
        },
        Transition {
            to: "inactive"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        target: menuChanger
                        duration: 250;
                    }
                    NumberAnimation {
                        target: topLine
                        duration: 250;
                    }
                }
                ParallelAnimation {
                    NumberAnimation {
                        easing.type: Easing.OutQuad
                        target: leftGauge;
                        duration: 350;
                    }
                    NumberAnimation {
                        easing.type: Easing.OutQuad
                        target: rightGauge;
                        duration: 350;
                    }
                }
            }
        },
        Transition {
            to: "navi"
            NumberAnimation {
                properties: "scale";
                duration: 500;
            }
            SequentialAnimation {
                NumberAnimation {
                    target: normalMenu;
                    duration: 250;
                }
                PauseAnimation { duration: 300; }
                NumberAnimation {
                    target: navModeMenu
                    duration: 300;
                    easing.type: Easing.InCubic;
                }
            }
        },
        Transition {
            from: "navi"
            NumberAnimation {
                properties: "scale";
                duration: 500;
            }
            SequentialAnimation {
                NumberAnimation {
                    target: navModeMenu;
                    duration: 250;
                }
                PauseAnimation { duration: 300; }
                NumberAnimation {
                    target: normalMenu
                    duration: 300;
                    easing.type: Easing.InCubic;
                }
            }
        }
    ]
}
