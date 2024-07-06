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
    id: telltalesmodel;

    property bool turnLeftActive: false;
    property bool parkingLightsActive: false;
    property bool lowBeamHeadlightsActive: false;
    property bool parkedActive: false;
    property bool airbagActive: false;
    property bool turnRightActive: false;

    property bool turnLeftBlinking: false;
    property bool turnRightBlinking: false;

    property bool showSimulatedLightIndicators: true;

    readonly property int opacityChangeDuration: 500;
    property double qtLogoOpacity: 0;
    property double indicatorOpacity: 0;
}
