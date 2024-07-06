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

QtObject {
    readonly property string shortDistanceUnit: "m"
    readonly property string longDistanceUnit: "km"
    readonly property string speedUnit: "km/h"
    readonly property string fuelUsageUnit: "L/100km"
    readonly property string temperatureSymbol: "°C"

    readonly property int maximumSpeed: 200

    function toInt(value: real) : int {
        return value;
    }

    function metersToShortDistanceUnit(meters : real) : real {
        return meters
    }

    function kilometersToLongDistanceUnit(kilometers : real) : real {
        return kilometers
    }

    function longDistanceUnitToKilometers(value : real) : real {
        return value
    }

    function degreesToTemperatureUnit(degrees : real) : real {
        return degrees
    }

    function gearToGearText(gear : int) : string {
        var out = "D"
        if (gear === -1) {
            out = "R"
        } else if (gear === 0 || gear === -2) {
            out = "N"
        } else {
            out = "D%1".arg(gear)
        }
        return out
    }
}
