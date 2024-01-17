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
#include "DatabaseWrapper.h"

int main(int argc, char *argv[])
{
    set_qt_environment();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
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

    /**/
    // initialise the inventory database
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("inventory.sqlite");
    if (!db.open()) {
        qWarning() << "Failed to open the database!";
    }
    else{
        qWarning() << "Suceeded to open the database!";
    }
    // Table to store delivery data
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS DeliveryData ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT,"
               "brand TEXT,"
               "amountDelivered INTEGER,"
               "deliveryDate TEXT,"
               "itemCount INTEGER)");



    // Expose the database object to QML
    DatabaseWrapper databaseWrapper;
    engine.rootContext()->setContextProperty("inventoryDatabase", &databaseWrapper);
   //engine.rootContext()->setContextProperty("inventoryDatabase", QVariant::fromValue(&db));

    // Get the root objects
    QList<QObject*> rootObjects = engine.rootObjects();
    if (!rootObjects.isEmpty()) {
        // Emit a signal to notify QML that the database is loaded
        qWarning() << "database looded";
        QMetaObject::invokeMethod(rootObjects.first(), "databaseLoaded");

    } else {
        qWarning() << "No root objects found.";
    }

    // Emit a signal to notify QML that the database is loaded
    //QMetaObject::invokeMethod(engine.rootObjects().first(), "databaseLoaded");


    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    return app.exec();
}
