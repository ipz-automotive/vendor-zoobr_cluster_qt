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

Row {
    id: telltales;

    TellTalesIndicator
    {
        source: "images/turn_left.png";
        activeColor: Style.highlighterGreen;
        active: TellTalesModel.turnLeftActive;
        opacity: TellTalesModel.indicatorOpacity;
        blinking: TellTalesModel.turnLeftBlinking;
    }
    TellTalesIndicator
    {
        source: "images/parking-lights.png";
        activeColor: Style.highlighterGreen;
        active: TellTalesModel.parkingLightsActive;
        opacity: TellTalesModel.indicatorOpacity;
    }
    TellTalesIndicator
    {
        source: "images/low-beam-headlights.png";
        activeColor: Style.brightBlue;
        active: TellTalesModel.lowBeamHeadlightsActive;
        opacity: TellTalesModel.indicatorOpacity;
    }
    // TellTalesIndicator
    // {
    //     source: "images/ready.png";
    //     activeColor: Style.highlighterGreen;
    //     active: true;
    //     opacity: TellTalesModel.qtLogoOpacity;
    // }
    TellTalesIndicator
    {
        source: "images/parked.png";
        activeColor: Style.highlighterRed;
        active: TellTalesModel.parkedActive;
        opacity: TellTalesModel.indicatorOpacity;
    }
    TellTalesIndicator
    {
        source: "images/airbag.png";
        activeColor: Style.highlighterRed;
        active: TellTalesModel.airbagActive;
        opacity: TellTalesModel.indicatorOpacity;
    }
    TellTalesIndicator
    {
        source: "images/turn_right.png";
        activeColor: Style.highlighterGreen;
        active: TellTalesModel.turnRightActive;
        opacity: TellTalesModel.indicatorOpacity;
        blinking: TellTalesModel.turnRightBlinking;
    }
}
