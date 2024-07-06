

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
import Main 1.0

Rectangle {
    id: root
    width: parent.width
    height: parent.height

    color: Style.backgroundColor



    Item {
        id: cluster
        anchors.fill: parent
        visible: MainModel.clusterVisible
        opacity: 1//MainModel.clusterOpacity

        Image {
            id: bg
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            source: "images/bg-mask.png"

            transform: Scale {
                origin.x: bg.implicitWidth / 2
                origin.y: bg.implicitHeight

                xScale: NormalModeModel.scale
                yScale: NormalModeModel.scale
            }
        }

        Image {
            id: highlights
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            source: "images/car-highlights.png"

            transform: Scale {
                origin.x: highlights.implicitWidth / 2
                origin.y: highlights.implicitHeight

                xScale: NormalModeModel.scale
                yScale: NormalModeModel.scale
            }
        }

        // LaneAssist {
        //     anchors.fill: parent
        //     scale: NormalModeModel.scale
        // }

        GuideArrowItem {
            anchors.fill: parent
            scale: NormalModeModel.scale
        }

        Text {
            id: odo
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 27
            anchors.left: parent.left
            anchors.leftMargin: 30
            text: "ODO"
            color: Style.textColor
            font.pixelSize: 12
            font.family: "Sarabun"
        }
        Text {
            id: odoValue
            anchors.baseline: odo.baseline
            anchors.left: odo.right
            anchors.leftMargin: 4
            text: Units.toInt(Units.kilometersToLongDistanceUnit(MainModel.odo))
            color: Style.lightPeriwinkle
            font.pixelSize: 20
            font.family: "Sarabun"
        }
        Text {
            id: odoUnit
            anchors.baseline: odo.baseline
            anchors.left: odoValue.right
            anchors.leftMargin: 4
            text: Units.longDistanceUnit
            color: Style.textColor
            font.pixelSize: 12
            font.family: "Sarabun"
        }

        Text {
            id: range
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 27
            x: 170
            text: "RANGE"
            color: Style.textColor
            font.pixelSize: 12
            font.family: "Sarabun"
        }
        Text {
            id: rangeValue
            anchors.baseline: range.baseline
            anchors.left: range.right
            anchors.leftMargin: 4
            text: Units.toInt(Units.kilometersToLongDistanceUnit(
                                  MainModel.range))
            color: Style.lightPeriwinkle
            font.pixelSize: 20
            font.family: "Sarabun"
        }
        Text {
            id: rangeUnit
            anchors.baseline: range.baseline
            anchors.left: rangeValue.right
            anchors.leftMargin: 4
            text: Units.longDistanceUnit
            color: Style.textColor
            font.pixelSize: 12
            font.family: "Sarabun"
        }

        LinearGauge {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 27
            x: parent.width - 300
            image: "images/fuel.png"
            emptyText: "R"
            value: MainModel.fuelLevel
        }

        LinearGauge {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 27
            x: parent.width - 150
            image: "images/battery.png"
            emptyText: "E"
            value: MainModel.batteryLevel
        }

        Loader {
            id: modeLoader
            anchors.fill: parent
            source: "NormalMode.qml"
        }

        Connections {
            target: MainModel
            function onClusterModeChanged(clusterMode: int) {
                changeMode.start()
            }
        }

        Timer {
            id: changeMode
            interval: 5
            onTriggered: {
                switch (MainModel.clusterMode) {
                case MainModel.ModeNormal:
                    modeLoader.source = "NormalMode.qml"
                    break
                case MainModel.ModeSport:
                    modeLoader.source = "SportMode.qml"
                    break
                }
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: MainModel.clusterOpacityChangeDuration
            }
        }
    }

    TellTales {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 16
        visible: MainModel.telltalesVisible
    }

    // BenchmarkMode {
    //     id: benchmarkMode
    // }

    // QulPerfOverlay {
    //     id: benchmarkResult
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     anchors.verticalCenter: parent.verticalCenter
    //     visible: false
    // }

    // Timer {
    //     id: benchmarkTimer
    //     interval: 30000
    //     running: benchmarkMode.enabled
    //     repeat: false
    //     onTriggered: {
    //         QulPerf.recording = false
    //         benchmarkResult.visible = true
    //         MainModel.clusterVisible = false
    //         MainModel.telltalesVisible = false
    //     }
    // }

    // Timer {
    //     interval: 50
    //     running: true
    //     repeat: true
    //     onTriggered: {
    //         ConnectivityService.sendHeartBeat()
    //     }
    // }

    // Timer {
    //     id: inactivityTimer
    //     interval: 10000
    //     running: false
    //     repeat: false
    //     onTriggered: {
    //         simulationController.stopInteractiveMode()
    //     }
    // }

    // Timer {
    //     id: travelTimeCounter
    //     running: true
    //     repeat: true
    //     interval: 1000
    //     onTriggered: {
    //         //MainModel.travelTime += 1
    //     }
    // }

    // function enterInteractiveMode() {
    //     simulationController.startInteractiveMode()
    //     if (!MainModel.forceInteractiveMode) {
    //         inactivityTimer.restart()
    //     }
    // }

    // function onHmiInputPressed(key: int) {
    //     if (!MainModel.introSequenceCompleted) {
    //         return
    //     }
    //     enterInteractiveMode()
    // }
    // function onHmiInputReleased(key: int) {
    //     if (!MainModel.introSequenceCompleted) {
    //         return
    //     }
    //     enterInteractiveMode()
    //     if (MainModel.clusterMode == MainModel.ModeNormal) {
    //         if (key == HMIInputEvent.HMI_KNOB_TURN_LEFT) {
    //             NormalModeModel.previousMenu()
    //         } else if (key == HMIInputEvent.HMI_KNOB_TURN_RIGHT) {
    //             NormalModeModel.nextMenu()
    //         } else if (NormalModeModel.menu == NormalModeModel.MediaPlayerMenu) {
    //             if (key == HMIInputEvent.HMI_BTN_LEFT) {
    //                 MediaPlayerModel.previousSong()
    //             } else if (key == HMIInputEvent.HMI_BTN_RIGHT) {
    //                 MediaPlayerModel.nextSong()
    //             } else if (key == HMIInputEvent.HMI_KNOB_CENTER) {
    //                 MediaPlayerModel.mediaPlayback = !MediaPlayerModel.mediaPlayback
    //             }
    //         } else if (NormalModeModel.menu == NormalModeModel.PhoneMenu) {
    //             if (!PhoneModel.inCall) {
    //                 if (key == HMIInputEvent.HMI_BTN_LEFT) {
    //                     PhoneModel.previousTab()
    //                 } else if (key == HMIInputEvent.HMI_BTN_RIGHT) {
    //                     PhoneModel.nextTab()
    //                 } else if (key == HMIInputEvent.HMI_BTN_UP) {
    //                     PhoneModel.previousContact()
    //                 } else if (key == HMIInputEvent.HMI_BTN_DOWN) {
    //                     PhoneModel.nextContact()
    //                 }
    //             }

    //             if (key == HMIInputEvent.HMI_KNOB_CENTER) {
    //                 PhoneModel.inCall = !PhoneModel.inCall
    //             }
    //         } else if (NormalModeModel.menu == NormalModeModel.CarStatusMenu) {
    //             if (key == HMIInputEvent.HMI_BTN_LEFT) {
    //                 SettingsMenuModel.previousTab()
    //             } else if (key == HMIInputEvent.HMI_BTN_RIGHT) {
    //                 SettingsMenuModel.nextTab()
    //             }
    //         }
    //     }

    //     if ((MainModel.clusterMode == MainModel.ModeNormal
    //          && NormalModeModel.menu == NormalModeModel.CarStatusMenu
    //          && SettingsMenuModel.currentTab == SettingsMenuModel.DriveModeTab)
    //             || (MainModel.clusterMode == MainModel.ModeSport
    //                 && SportModeModel.menuActive)) {
    //         if (key == HMIInputEvent.HMI_KNOB_CENTER) {
    //             if (SettingsMenuModel.currentDriveModeSelected == SettingsMenuModel.NormalDrive) {
    //                 simulationController.switchToNormalMode()
    //             } else {
    //                 simulationController.switchToSportMode()
    //             }
    //         } else if (key == HMIInputEvent.HMI_BTN_UP
    //                    || key == HMIInputEvent.HMI_BTN_DOWN) {
    //             SettingsMenuModel.switchOption()
    //         }
    //     }
    //     if (MainModel.clusterMode == MainModel.ModeSport
    //             && key == HMIInputEvent.HMI_KNOB_TURN_RIGHT) {
    //         SportModeModel.menuActive = !SportModeModel.menuActive
    //     }
    // }

    // function keyToHMI(key: int): int {
    //     switch (key) {
    //     case Qt.Key_Up:
    //         return HMIInputEvent.HMI_BTN_UP
    //     case Qt.Key_Down:
    //         return HMIInputEvent.HMI_BTN_DOWN
    //     case Qt.Key_Left:
    //         return HMIInputEvent.HMI_BTN_LEFT
    //     case Qt.Key_Right:
    //         return HMIInputEvent.HMI_BTN_RIGHT
    //     case Qt.Key_Space:
    //         return HMIInputEvent.HMI_BTN_CENTER
    //     case Qt.Key_PageDown:
    //         return HMIInputEvent.HMI_KNOB_TURN_LEFT
    //     case Qt.Key_PageUp:
    //         return HMIInputEvent.HMI_KNOB_TURN_RIGHT
    //     case Qt.Key_Return:
    //         return HMIInputEvent.HMI_KNOB_CENTER
    //     default:
    //         return HMIInputEvent.HMI_UNKNOWN
    //     }
    // }

    // Keys.onPressed: {
    //     onHmiInputPressed(keyToHMI(event.key))
    // }
    // Keys.onReleased: {
    //     onHmiInputReleased(keyToHMI(event.key))
    // }

    // HMIInput.onPressed: {
    //     onHmiInputPressed(key)
    // }
    // HMIInput.onReleased: {
    //     onHmiInputReleased(key)
    // }

    // MainModel.onForceInteractiveModeChanged: {
    //     if (!MainModel.introSequenceCompleted) {
    //         return
    //     }
    //     if (MainModel.forceInteractiveMode) {
    //         simulationController.startInteractiveMode()
    //     } else {
    //         simulationController.stopInteractiveMode()
    //     }
    // }

}
