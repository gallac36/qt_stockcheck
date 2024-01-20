#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>

class DatabaseHandler : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseHandler(QObject *parent = nullptr);

    Q_INVOKABLE bool openDatabase(const QString &dbName);
    Q_INVOKABLE void closeDatabase();

    Q_INVOKABLE bool createDeliveryTable();
    Q_INVOKABLE bool insertData(const QString &brand, int amount, const QString &date, int itemCount);

    Q_INVOKABLE bool open();
    void emitDatabaseLoadedSignal();

    Q_INVOKABLE QVariant execQuery(const QString &query);

signals:
    // Signal to notify QML that the database is loaded
    void databaseLoaded();


private:
    QSqlDatabase m_database;
};

#endif // DATABASEHANDLER_H


