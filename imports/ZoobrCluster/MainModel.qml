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
pragma Singleton
import QtQuick 2.15
import ZoobrCluster 1.0

QtObject {
    id: mainmodel

    enum ClusterMode { ModeNormal, ModeSport, ModeEco }
    property TelemetryController telController: TelemetryController
    property int clusterMode: MainModel.ModeNormal
    property bool introSequenceStarted: false
    property bool introSequenceCompleted: false
    // // property bool forceInteractiveMode: false

    // // property int speedLimitWarning: SpeedLimitValues.Slow
    property real initialOdo: 0
    property real odo: TelemetryController.getInstance().odo
    property int travelTime: 0


    property int range: 270//initialRange
    property real speed: telController.getInstance().speed
    property real rpm: telController.getInstance().rpm
    property int gear: telController.getInstance().gear
    property string gearShiftText: Units.gearToGearText(MainModel.gear)
    property real fuelLevel: telController.getInstance().fuelLevel
    property real batteryLevel: 1.0//initialBatteryLevel

    property bool telltalesVisible: true
    property bool clusterVisible: true
    property real temp: 0
    property bool showSimulatedDriveData: true

    readonly property int fullRange: 895
    readonly property int initialRange: fullRange - odo
    readonly property real initialFuelLevel: range / fullRange
    readonly property real initialBatteryLevel: 0.2
    readonly property int maxSpeed: Units.longDistanceUnitToKilometers(Units.maximumSpeed)
    readonly property int maxRpm: 7000
    readonly property int clusterOpacityChangeDuration: 750
    readonly property int gaugesOpacityChangeDuration: 750

    readonly property int gaugesValueChangeDurationNormal: 500
    readonly property int gaugesValueChangeDurationSlow: 1250

    // property real clusterOpacity: 0
    // property real gaugesOpacity: 0

    property int gaugesValueChangeDuration: gaugesValueChangeDurationNormal

    property bool laneAssistCarMoving: false
    property bool laneAssistEnabled: true

    signal triggerLaneAssist(int side)
    signal triggerGuideArrow(int index)

    property VehicleClient client: VehicleClient {
        hostname: "21.37.14.88"
        port: 1883
        controller: telController
    }

    Component.onCompleted: {
        console.log("VehicleClient: connecting to: " + client.hostname + ":" + client.port)
        client.connectToBroker()
        console.log("VehicleClient: state " + client.state)
    }

    property Connections conn: Connections {
        target: client
        onStateChanged: {
            console.log("VehicleClient: state changed: " + client.state)
            if (client.state === 2) client.subscribeToTopics()
        }
    }

    onClusterModeChanged : {
        // if (MainModel.introSequenceCompleted) {
        //     if (clusterMode == MainModel.ModeNormal) {
        //         ConnectivityService.setClusterMode(ConnectivityService.NormalMode)
        //     }
        //     else {
        //         ConnectivityService.setClusterMode(ConnectivityService.SportMode)
        //         ConnectivityService.setCurrentMenu(ConnectivityService.None)
        //     }
        //     SettingsMenuModel.notifyConnectivityService()
        // }
    }

    onIntroSequenceStartedChanged: {
        // if (introSequenceStarted) {
        //     ConnectivityService.setClusterMode(ConnectivityService.IntroMode)
        // }
    }

    onIntroSequenceCompletedChanged: {
        // if (introSequenceCompleted) {
        //     ConnectivityService.setClusterMode(ConnectivityService.NormalMode)
        //     ConnectivityService.setCurrentMenu(ConnectivityService.Media)
        // }
    }

}
