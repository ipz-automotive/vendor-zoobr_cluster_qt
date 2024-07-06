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
    id: normalmodemodel

    enum Menu { MediaPlayerMenu, NavigationMenu, PhoneMenu, CarStatusMenu, MenuCount }
    property int menu: NormalModeModel.MediaPlayerMenu
    property real scale: 1

    Behavior on scale { NumberAnimation {  duration: 500; } }

    function nextMenu() {
        if (menu == NormalModeModel.MediaPlayerMenu) {
            menu = NormalModeModel.NavigationMenu
        }
        else if (menu == NormalModeModel.NavigationMenu ) {
            menu = NormalModeModel.PhoneMenu
        }
        else if (menu == NormalModeModel.PhoneMenu ) {
            menu = NormalModeModel.CarStatusMenu
        }
        else if (menu == NormalModeModel.CarStatusMenu ) {
            menu = NormalModeModel.MediaPlayerMenu
        }
    }

    function previousMenu() {
        if (menu == NormalModeModel.MediaPlayerMenu) {
            menu = NormalModeModel.CarStatusMenu
        }
        else if (menu == NormalModeModel.NavigationMenu ) {
            menu = NormalModeModel.MediaPlayerMenu
        }
        else if (menu == NormalModeModel.PhoneMenu ) {
            menu = NormalModeModel.NavigationMenu
        }
        else if (menu == NormalModeModel.CarStatusMenu ) {
            menu = NormalModeModel.PhoneMenu
        }
    }

    onMenuChanged: {
        if (MainModel.introSequenceCompleted) {
            if (menu == NormalModeModel.MediaPlayerMenu) {
                ConnectivityService.currentMenu = ConnectivityService.Media
            }
            if (menu == NormalModeModel.NavigationMenu) {
                ConnectivityService.currentMenu = ConnectivityService.Navigation
            }
            if (menu == NormalModeModel.PhoneMenu) {
                ConnectivityService.currentMenu = ConnectivityService.Phone
            }
            if (menu == NormalModeModel.CarStatusMenu) {
                SettingsMenuModel.notifyConnectivityService()
            }
        }
    }
}
