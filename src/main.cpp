// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

#include "app_environment.h"
#include "import_qml_plugins.h"
#include "imports/ZoobrCluster/src/telemetrycontroller.h"

int main(int argc, char *argv[]) {
    set_qt_environment();
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");
    engine.addImportPath("qrc/qt/qml/ZoobrCluster");
    engine.load(url);

    // qmlRegisterSingletonType<TelemetryController>("TelemetryController", 1, 0, "TelemetryController", [](QQmlEngine *engine, QJSEngine *) -> QObject * {
    //     Q_UNUSED(engine)

    //     return TelemetryController::getInstance();
    // });

    // qmlRegisterSingletonType<TelemetryController>("TelemetryController", 1, 0, "telemetryController", &Tele);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
