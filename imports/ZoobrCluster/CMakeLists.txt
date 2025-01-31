### This file is automatically generated by Qt Design Studio.
### Do not change

set_source_files_properties(Constants.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(MainModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(MathAPI.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(MediaPlayerModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(NaviModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(NormalModeModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(PhoneModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(SettingsMenuModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(SportModeModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(Style.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(TellTalesModel.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(Units.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

qt_add_library(ZoobrCluster STATIC)

include_directories(src/)

qt6_add_qml_module(ZoobrCluster
    URI "ZoobrCluster"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Constants.qml
        EventListModel.qml
        EventListSimulator.qml
        MathAPI.qml
        MainModel.qml
        MediaPlayerModel.qml
        NaviModel.qml
        NormalModeModel.qml
        PhoneModel.qml
        SettingsMenuModel.qml
        SpeedLimitImage.qml
        SpeedLimitValues.qml
        SportModeModel.qml
        Style.qml
        TellTalesModel.qml
        Units.qml
    SOURCES
        src/telemetrycontroller.h src/telemetrycontroller.cpp
        src/vehicleclient.h src/vehicleclient.cpp
)

target_link_libraries(ZoobrCluster PRIVATE Qt::QmlPrivate Qt::QuickPrivate)
