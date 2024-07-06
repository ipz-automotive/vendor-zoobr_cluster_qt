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

NormalModeContentItem {
    property int currentTab: SettingsMenuModel.currentTab;

    Item {
        id: middle
        width: psuedoMaskVertical.width;
        height: psuedoMaskVertical.height;
        clip: true;
        anchors.horizontalCenter: parent.horizontalCenter
        y: 69

        property int fuelConsumption: 4
        property int distanceTraveled: MainModel.odo - MainModel.initialOdo
        property int travelTime: MainModel.travelTime

        Timer {
            id: fuelConsumptionSimulation
            running: true
            repeat: true
            interval: 2000
            onTriggered: { middle.fuelConsumption = Math.round(Math.random()*9)}
        }

        Item {
            id: middleSliding;
            height: parent.height;
            width: parent.width * 3;
            x: - parent.width * currentTab;
            Behavior on x { NumberAnimation { } }

            DriveModeSelector {
                y: 96;
                x: 335 - middle.x
                width: middle.width;
                visible: !SportModeModel.menuActive
            }

            Column {
                y: 72;
                width: middle.width;
                x: width;
                Repeater {
                    model: [
                        { text: "Lights", ok: true },
                        { text: "Tire pressure", ok: false },
                        { text: "Windshield washer fluid", ok: false },
                    ]
                    delegate: Item {
                        width: 221;
                        height: 33;
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            text: modelData.text;
                            color: Style.lightPeriwinkle;
                            font.pixelSize: 16;
                            font.family: "Sarabun";
                        }
                        Text {
                            anchors.right: parent.right
                            text: modelData.ok ? "OK" : "Low";
                            color: modelData.ok ? Style.lightPeriwinkle : Style.orange;
                            font.pixelSize: 16;
                            font.bold: true;
                            font.family: "Sarabun";
                        }
                    }
                }
            }

            Column {
                y: 72;
                width: middle.width;
                x: width * 2;
                spacing: 15
                Row {
                    x: 335 - middle.x
                    Image {
                        id: clockIndicator
                        source: "images/clock.png";
                    }
                    Item {
                        width: 23
                    }
                    Text {
                        anchors.verticalCenter: clockIndicator.verticalCenter
                        id: travelTimeValueH
                        text: Math.floor(middle.travelTime / 3600);
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Text {
                        anchors.verticalCenter: clockIndicator.verticalCenter
                        id: travelTimeHourValueSeparator
                        text: (middle.travelTime % 3600) / 60 < 10 ? ":0" : ":";
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Text {
                        anchors.verticalCenter: clockIndicator.verticalCenter
                        id: travelTimeValueMinutes
                        text: Math.floor((middle.travelTime % 3600) / 60);
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Text {
                        anchors.verticalCenter: clockIndicator.verticalCenter
                        id: travelTimeMinuteValueSeparator
                        text: middle.travelTime % 60 < 10 ? ":0" : ":";
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Text {
                        anchors.verticalCenter: clockIndicator.verticalCenter
                        id: travelTimeValueSeconds
                        text: Math.floor(middle.travelTime % 60);
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Item {
                        width: 5
                    }
                    Text {
                        text: "h";
                        font.pixelSize: 14;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                        anchors.baseline: travelTimeValueMinutes.baseline;
                    }
                }

                Row {
                    x: 335 - middle.x
                    Image {
                        id: roadIndicator
                        source: "images/road.png";
                    }
                    Item {
                        width: 23
                    }
                    Text {
                        anchors.verticalCenter: roadIndicator.verticalCenter
                        id: distanceValue
                        text: middle.distanceTraveled;
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Item {
                        width: 5
                    }
                    Text {
                        text: Units.longDistanceUnit;
                        font.pixelSize: 14;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                        anchors.baseline: distanceValue.baseline;
                    }
                }

                Row {
                    x: 335 - middle.x
                    Image {
                        id: fuelIndicator
                        source: "images/fuel.png";
                    }
                    Item {
                        width: 23
                    }
                    Text {
                        anchors.verticalCenter: fuelIndicator.verticalCenter
                        id: fuelConsumptionValueConstPart
                        text: "5.";
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Text {
                        anchors.verticalCenter: fuelIndicator.verticalCenter
                        id: fuelConsumptionValue
                        text: middle.fuelConsumption;
                        font.pixelSize: 20;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                    }
                    Item {
                        width: 5
                    }
                    Text {
                        text: Units.fuelUsageUnit;
                        font.pixelSize: 14;
                        font.bold: true;
                        font.family: "Sarabun";
                        color: Style.lightPeriwinkle;
                        anchors.baseline: fuelConsumptionValue.baseline;
                    }
                }
            }
        }

        Image {
            id: psuedoMaskVertical;
            source: "images/pseudo-mask-vertical.png"
        }
    }

    Row {
        spacing: 23
        y: 74

        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: ["Display", "Car status", "Last trip"];

            delegate: Text {
                text: modelData;
                color: Style.lightPeriwinkle;
                font.pixelSize: 12;
                font.family: "Sarabun";
                opacity: currentTab == index ? 1 : 0.2;
                Behavior on opacity { NumberAnimation { } }
            }
        }
    }

    Text {
        id: tirePressureText
        opacity: currentTab == SettingsMenuModel.CarStatusTab ? 1 : 0
        Behavior on opacity { NumberAnimation { } }
        text: "Tire pressure"
        color: Style.lightPeriwinkle
        font.pixelSize: 16
        font.family: "Sarabun";
        anchors.horizontalCenter: parent.horizontalCenter
        y: 434
    }

    Text {
        opacity: tirePressureText.opacity
        text: "bar"
        color: Style.brightBlue
        font.pixelSize: 12
        font.family: "Sarabun";
        x: 482
        y: 405
    }

    Repeater {
        model: [
            { x: 323, y: 405, value: 2.3 },
            { x: 329, y: 368, value: 2.3 },
            { x: 437, y: 368, value: 1.9 },
            { x: 444, y: 405, value: 2.3 },
        ]
        delegate: Rectangle {
            property bool isLow: modelData.value < 2;
            x: modelData.x;
            y: modelData.y;
            color: isLow ? Style.orange : Style.brightBlue;
            opacity: tirePressureText.opacity;
            radius: 3;
            width: 32;
            height: 16;
            Rectangle {
                visible: !isLow;
                anchors.fill: parent;
                anchors.margins: 1;
                radius: 3;
                color: "#00091a";
            }
            Text {
                anchors.centerIn: parent;
                text: modelData.value.toFixed(2);
                color: isLow ? "#613600" : Style.brightBlue
                font.pixelSize: 10;
                font.family: "Sarabun";
            }
        }
    }
}
