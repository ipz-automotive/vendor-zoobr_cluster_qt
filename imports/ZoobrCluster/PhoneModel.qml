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
    id: phonemodel

    property int contactTabIndex: 0
    readonly property int contactTabSwitchDuration: 350
    property int favContactsIndex: 0
    property int recentContactsIndex: 0
    property int allContactsIndex: 0
    property int currentContactIndex: 0
    property int contactScrollDuration: 250
    property bool inCall: false

    // FIXME: it's not possible for now to check size of model
    readonly property int phoneTabCount: 3
    readonly property int favContactsCount: 3
    readonly property int recentContactsCount: 2
    readonly property int allContactsCount: 5

    readonly property int maxCallDuration: 25 * 1000
    readonly property int minCallDuration: 15 * 1000

    // onInCallChanged: {
    //     ConnectivityService.ongoingCall = inCall;
    // }

    onContactTabIndexChanged: adjustCurrentContactIndex()

    function adjustCurrentContactIndex() {
        if (contactTabIndex == 0) {
            currentContactIndex = favContactsIndex
        }
        if (contactTabIndex == 1) {
            currentContactIndex = recentContactsIndex
        }
        else if (contactTabIndex == 2) {
            currentContactIndex = allContactsIndex
        }
    }

    function nextTab() {
        contactTabIndex = (contactTabIndex + 1) % phoneTabCount
    }

    function previousTab() {
        contactTabIndex = (contactTabIndex + phoneTabCount - 1) % phoneTabCount
    }

    function previousContact() {
        if (contactTabIndex == 0) {
            favContactsIndex = (favContactsIndex + favContactsCount - 1) % favContactsCount
        }
        if (contactTabIndex == 1) {
            recentContactsIndex = (recentContactsIndex + recentContactsCount - 1) % recentContactsCount
        }
        else if (contactTabIndex == 2) {
            allContactsIndex = (allContactsIndex + allContactsCount - 1) % allContactsCount
        }
        adjustCurrentContactIndex()
    }

    function nextContact() {
        if (contactTabIndex == 0) {
            favContactsIndex = (favContactsIndex + 1) % favContactsCount
        }
        if (contactTabIndex == 1) {
            recentContactsIndex = (recentContactsIndex + 1) % recentContactsCount
        }
        else if (contactTabIndex == 2) {
            allContactsIndex = (allContactsIndex + 1) % allContactsCount
        }
        adjustCurrentContactIndex()
    }
}
