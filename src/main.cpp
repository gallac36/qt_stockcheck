// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"

#include <QtSql>
#include <QSqlError>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QQmlContext>
#include "DatabaseHandler.h"

int main(int argc, char *argv[])
{
    set_qt_environment();

    QGuiApplication app(argc, argv);


    // Create an instance of DatabaseHandler
    DatabaseHandler databaseHandler;

    // Expose the databaseHandler instance to the QML context
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("databaseHandler", &databaseHandler);


    const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);


    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    return app.exec();
}
