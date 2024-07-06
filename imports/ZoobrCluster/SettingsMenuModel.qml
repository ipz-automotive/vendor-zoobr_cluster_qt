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
    id: drivemodemenumodel

    enum DriveModeOption { NormalDrive, SportDrive, ModeOptionsCount }
    enum Tabs { DriveModeTab, CarStatusTab, LastTripTab, TabsCount }
    property int currentDriveModeSelected: SettingsMenuModel.NormalDrive
    property int currentTab: SettingsMenuModel.DriveModeTab

    // onCurrentTabChanged: notifyConnectivityService()

    // onCurrentDriveModeSelectedChanged: notifyConnectivityService()
    // function previousTab() {
    //     currentTab = (currentTab + SettingsMenuModel.TabsCount - 1) % SettingsMenuModel.TabsCount
    // }

    // function nextTab() {
    //     currentTab = (currentTab + 1) % SettingsMenuModel.TabsCount
    // }

    // function switchOption() {
    //     currentDriveModeSelected = (currentDriveModeSelected + 1) % SettingsMenuModel.ModeOptionsCount
    // }

    // function notifyConnectivityService() {
    //     if (NormalModeModel.menu == NormalModeModel.CarStatusMenu && MainModel.clusterMode == MainModel.ModeNormal) {
    //         if (currentTab == SettingsMenuModel.DriveModeTab) {
    //             ConnectivityService.currentMenu = ConnectivityService.Mode
    //         }
    //         else if (currentTab == SettingsMenuModel.CarStatusTab) {
    //             ConnectivityService.currentMenu = ConnectivityService.CarStatus
    //         }
    //         else {
    //             ConnectivityService.currentMenu = ConnectivityService.LastTrip
    //         }
    //     }
    //     ConnectivityService.enableDriveModeChange = (currentDriveModeSelected == SettingsMenuModel.NormalDrive && MainModel.clusterMode == MainModel.ModeSport) ||
    //                                                         (currentDriveModeSelected == SettingsMenuModel.SportDrive && MainModel.clusterMode == MainModel.ModeNormal)
    // }
}
