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
import Qt5Compat.GraphicalEffects

Item {
    id: root

    property alias selected: proxy.selected;

    NormalModeContentItem  {
        // FIXME: This strange construct is a workaround for missing Item Layers.
        // We must prevent phone list mask opacity changes propagated from root item.
        // (mask becomes translucent during transitions and reveals items below)
        id: proxy
    }

    Item  {
        id: phone
        visible: proxy.visible;
        height: middle.height
        anchors.fill: parent;
        property int currentTab: PhoneModel.contactTabIndex;
        property bool calling: PhoneModel.inCall;
        property bool connected: false
        property int callDuration: 0
        property int targetContactIndex: PhoneModel.currentContactIndex

        property int fav_contacts_size: 3
        property int recent_contacts_size: 2
        property int all_contacts_size: 5

        onCallingChanged: {
            if (calling) {
                connectingTimer.interval = 3000 + Math.round(Math.random() * 1000 )
                phone.connected = false
                phone.callDuration = 0
                connectingTimer.start()
            }
        }

        // FIXME: models are not reusable
        // FIXME: indexes are workaround accessing models elements
        ListModel {
            id: fav_contacts
            ListElement { photo: "images/photos/caspar.png";  name: "Caspar Sawrey";  number: "+1 121 743 789"; index: 0 }
            ListElement { photo: "images/photos/beatriz.png"; name: "Beatriz Brito";  number: "+1 121 521 711"; index: 1 }
            ListElement { photo: "images/photos/hirini.png";  name: "Hirini Hakopa";  number: "+1 121 488 300"; index: 2 }
        }
        ListModel {
            id: recent_contacts
            ListElement { photo: "images/photos/caspar.png";  name: "Caspar Sawrey";  number: "+1 121 743 789"; last_call: "Yesterday at 17:06"; index: 0 }
            ListElement { photo: "images/photos/beatriz.png"; name: "Beatriz Brito";  number: "+1 121 521 711"; last_call: "Yesterday at 07:59"; index: 1 }
        }
        ListModel {
            id: all_contacts
            ListElement { photo: "images/photos/aryn.png";    name: "Aryn Jacobssen"; number: "+1 121 743 852"; index: 0; fav_index: -1; rec_index: -1 }
            ListElement { photo: "images/photos/caspar.png";  name: "Caspar Sawrey";  number: "+1 121 743 789"; index: 1; fav_index:  0; rec_index:  0 }
            ListElement { photo: "images/photos/beatriz.png"; name: "Beatriz Brito";  number: "+1 121 521 711"; index: 2; fav_index:  1; rec_index:  1 }
            ListElement { photo: "images/photos/joslin.png";  name: "Joslin Rodgers"; number: "+1 121 581 321"; index: 3; fav_index: -1; rec_index: -1 }
            ListElement { photo: "images/photos/hirini.png";  name: "Hirini Hakopa";  number: "+1 121 488 300"; index: 4; fav_index:  2; rec_index: -1 }
        }
        ListModel {
            id: duplicated_all_contacts
            ListElement { photo: "images/photos/aryn.png";    name: "Aryn Jacobssen"; number: "+1 121 743 852"; index: 0; fav_index: -1; rec_index: -1 }
            ListElement { photo: "images/photos/caspar.png";  name: "Caspar Sawrey";  number: "+1 121 743 789"; index: 1; fav_index:  0; rec_index:  0 }
            ListElement { photo: "images/photos/beatriz.png"; name: "Beatriz Brito";  number: "+1 121 521 711"; index: 2; fav_index:  1; rec_index:  1 }
            ListElement { photo: "images/photos/joslin.png";  name: "Joslin Rodgers"; number: "+1 121 581 321"; index: 3; fav_index: -1; rec_index: -1 }
            ListElement { photo: "images/photos/hirini.png";  name: "Hirini Hakopa";  number: "+1 121 488 300"; index: 4; fav_index:  2; rec_index: -1 }
        }

        Item {
            id: middle
            anchors { horizontalCenter: parent.horizontalCenter; top: tabs.bottom }
            width: 264
            height: 210 - 13
            clip: true

            Item {
                opacity: proxy.opacity * (phone.calling ? 0 : 1);
                id: middleSliding;
                height: parent.height;
                width: parent.width * 3;
                x: - parent.width * phone.currentTab;
                y: 75
                Behavior on x { NumberAnimation { duration: PhoneModel.contactTabSwitchDuration } }
                Behavior on opacity { NumberAnimation { } }

                Column {
                    id: favourites
                    width: middle.width
                    spacing: -8
                    y: - 75 * PhoneModel.favContactsIndex
                    Behavior on y { NumberAnimation { duration: PhoneModel.contactScrollDuration } }
                    Repeater {
                        model: fav_contacts
                        delegate: Row {
                            width: middle.width;
                            Item { width: 20; height: 1 }
                            Image {
                                width: 75; height: 75
                                source: model.photo
                            }
                            Item { width: 22; height: 1 }
                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                Text {
                                    text: model.name;
                                    font.pixelSize: 14;
                                    color: Style.lightPeriwinkle;
                                    font.family: "Sarabun";
                                    font.bold: true;
                                }
                                Text {
                                    text: model.number;
                                    font.pixelSize: 14;
                                    color: Style.lightPeriwinkle;
                                    font.family: "Sarabun";
                                }
                            }
                        }
                    }
                }

                Column {
                    id: recent
                    x: favourites.x + width;
                    width: middle.width;
                    spacing: -8
                    y: - 75 * PhoneModel.recentContactsIndex
                    Behavior on y { NumberAnimation { duration: PhoneModel.contactScrollDuration } }
                    Repeater {
                        model: recent_contacts
                        delegate: Row {
                            width: middle.width;
                            Item { width: 20; height: 1 }
                            Image {
                                width: 75; height: 75
                                source: model.photo;
                            }
                            Item { width: 22; height: 1 }
                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: -1
                                Text {
                                    text: model.name;
                                    font.pixelSize: 14;
                                    color: Style.lightPeriwinkle;
                                    font.family: "Sarabun";
                                    font.bold: true;
                                }
                                Text {
                                    text: model.number;
                                    font.pixelSize: 14;
                                    color: Style.lightPeriwinkle;
                                    font.family: "Sarabun";
                                }
                                Text {
                                    text: model.last_call;
                                    font.pixelSize: 12;
                                    color: Style.lightPeriwinkle;
                                    font.family: "Sarabun";
                                    font.bold: true;
                                }
                            }
                        }
                    }
                }

                Column {
                    id: contacts
                    x: favourites.x + width * 2;
                    width: middle.width;
                    spacing: -8
                    y: - 75 * PhoneModel.allContactsIndex
                    Behavior on y { NumberAnimation { duration: PhoneModel.contactScrollDuration } }
                    Repeater {
                        model: all_contacts
                        delegate: Row {
                            width: middle.width;
                            Item { width: 20; height: 1 }
                            Image {
                                width: 75; height: 75
                                source: model.photo
                            }
                            Item { width: 22; height: 1 }
                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                Text {
                                    text: model.name;
                                    font.pixelSize: 14;
                                    color: Style.lightPeriwinkle;
                                    font.family: "Sarabun";
                                    font.bold: true;
                                }
                                Text {
                                    text: model.number;
                                    font.pixelSize: 14;
                                    color: Style.lightPeriwinkle;
                                    font.family: "Sarabun";
                                }
                            }
                        }
                    }
                }
            }

            Image {
                opacity: 1 // Keep opacity constant, so nothing is revealed
                source: "images/assets-phone-list-pseudo-mask.png"
            }

            Image {
                opacity: 1 // Keep opacity constant, so nothing is revealed
                source: "images/pseudo-mask-vertical.png"
            }
        }

        Row {
            id: tabs
            opacity: proxy.opacity * (phone.calling ? 0 : 1);
            spacing: 23
            y: 74

            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ["Favourites", "Recent", "Contacts"];

                delegate: Text {
                    text: modelData;
                    color: Style.lightPeriwinkle;
                    font.pixelSize: 12;
                    font.family: "Sarabun";
                    opacity: phone.currentTab == index ? 1 : 0.2;
                    Behavior on opacity { NumberAnimation { } }
                }
            }
        }

        Item {
            anchors.fill: middle
            opacity: proxy.opacity * (phone.calling ? 1 : 0);
            Behavior on opacity { NumberAnimation { } }

            // FIXME: ListModels elements are not accessible from outside of delegate
            Repeater {
                model: duplicated_all_contacts
                delegate: Column {
                    id: phoneTextCol
                    anchors.horizontalCenter: parent.horizontalCenter;
                    visible: {
                        if (phone.currentTab == 0) {
                            phone.targetContactIndex == model.fav_index
                        } else if (phone.currentTab == 1) {
                            phone.targetContactIndex == model.rec_index
                        } else if (phone.currentTab == 2) {
                            phone.targetContactIndex == model.index
                        }
                    }
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 5
                        Image {
                            id: img
                            anchors.verticalCenter: parent.verticalCenter
                            width: 24; height: width
                            source: "images/phone.png"
                            ColorOverlay {
                                    anchors.fill: img
                                    source: img
                                color: "green"
                            }
                        }
                        Column {
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: model.name
                                font.bold: true
                                font.pixelSize: 14
                                font.family: "Sarabun"
                                color: Style.lightPeriwinkle
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: model.number
                                font.bold: false;
                                font.pixelSize: 12
                                font.family: "Sarabun"
                                color: Style.lightPeriwinkle
                            }
                        }
                    }
                    Image {
                        source: model.photo
                        width: 154
                        height: width
                    }
                }
            }

            Text {
                anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom  }
                id: callingLabel
                visible: !phone.connected && phone.calling
                text: "Calling..."
                font.pixelSize: 14
                font.family: "Sarabun"
                color: Style.lightPeriwinkle

                SequentialAnimation {
                    id: callingLabelAnimation
                    loops: Animation.Infinite
                    alwaysRunToEnd: true
                    running: callingLabel.visible
                    PropertyAnimation {
                        target: callingLabel
                        property: "opacity"
                        duration: 400
                        from: 1.0
                        to: 0.0
                    }

                    PauseAnimation {
                        duration: 100
                    }

                    PropertyAnimation {
                        target: callingLabel
                        property: "opacity"
                        duration: 400
                        from: 0.0
                        to: 1.0
                    }
                }
            }

            Row {
                anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom }

                visible: phone.connected && phone.calling
                Text {
                    text: Math.floor(phone.callDuration / 60)
                    font.pixelSize: 14
                    font.family: "Sarabun"
                    color: Style.lightPeriwinkle
                }

                Text {
                    text: (phone.callDuration % 60) < 10 ? ":0" : ":"
                    font.pixelSize: 14
                    font.family: "Sarabun"
                    color: Style.lightPeriwinkle
                }
                Text {
                    text: Math.floor(phone.callDuration % 60)
                    font.pixelSize: 14
                    font.family: "Sarabun"
                    color: Style.lightPeriwinkle
                }
            }
        }

        Timer {
            id: connectingTimer
            repeat: false
            onTriggered: { phone.connected = true }
        }

        Timer {
            id: callProgressTimer
            running: phone.connected
            repeat: true
            interval: 1000
            onTriggered: { phone.callDuration += 1 }
        }
    }
}
