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
    id: navimodel

    enum ArrowType { ArrowNone, ArrowForward, ArrowRight, ArrowSharpRight, ArrowRound }

    property int distanceToNextManoeuver
    property int filteredDistanceToNextManoeuver
    onDistanceToNextManoeuverChanged: {
        filteredDistanceToNextManoeuver = Math.max(Units.metersToShortDistanceUnit(distanceToNextManoeuver), 1)
        if (distanceToNextManoeuver <= 50) {
            filteredDistanceToNextManoeuver = Math.ceil(filteredDistanceToNextManoeuver/10) * 10
        } else {
            filteredDistanceToNextManoeuver = Math.ceil(filteredDistanceToNextManoeuver/50) * 50
        }
    }

    property int arrowType: NaviModel.ArrowNone
    property string instruction: ""
    property string street: ""

    property int _lastStreetIndex: -1

    function getArrowSource() {
        switch (arrowType) {
            case NaviModel.ArrowRight:      return "images/arrow-45.png";
            case NaviModel.ArrowSharpRight: return "images/arrow-90.png";
            case NaviModel.ArrowRound:      return "images/arrow-round.png";
            default:                        return "images/arrow-0.png";
        }
    }

    function updateInstruction() {
        switch (arrowType) {
            case NaviModel.ArrowRight:      instruction = "Turn right onto"; break;
            case NaviModel.ArrowSharpRight: instruction = "Turn sharp right onto"; break;
            case NaviModel.ArrowRound:      instruction = "At the roundabout,\n  go straight ahead"; break;
            default:                        instruction = "Continue straight"; break;
        }
    }

    // signal triggerInstruction(NaviModel.ArrowType nextArrowIndex)
    // onTriggerInstruction: {
    //     arrowType = nextArrowIndex
    //     street = Region.getStreetName(Math.random() * Region.namesCount)
    //     updateInstruction()
    // }
}
