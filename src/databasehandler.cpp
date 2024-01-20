#include "databasehandler.h"

#include <QSqlError>
#include <QDebug>

DatabaseHandler::DatabaseHandler(QObject *parent) : QObject(parent)
{
    if (!openDatabase("inventory.sqlite")) {
        qDebug() << "Failed to open the database.";
        // Handle the failure, maybe emit a signal or log an error.
        return;
    }

    if (!createDeliveryTable()) {
        qDebug() << "Failed to create the DeliveryData table.";
        // Handle the failure, maybe emit a signal or log an error.
    } else {
        // Emit the signal when the database is loaded successfully
        emit databaseLoaded();
    }

}

bool DatabaseHandler::openDatabase(const QString &dbName)
{

    // initialise the inventory database
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("inventory.sqlite");
    if (!db.open()) {
        qWarning() << "Failed to open the database!";
    }
    else{
        qWarning() << "Suceeded to open the database!";
    }



    m_database = QSqlDatabase::addDatabase("QSQLITE");
    m_database.setDatabaseName(dbName);

    if (!m_database.open()) {
        qDebug() << "Failed to open the database:" << m_database.lastError().text();
        return false;
    }

    return true;


}

void DatabaseHandler::closeDatabase()
{
    m_database.close();
}

bool DatabaseHandler::createDeliveryTable()
{
    QSqlQuery query;
    query.prepare("CREATE TABLE IF NOT EXISTS DeliveryData ("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "brand TEXT,"
                  "amountDelivered INTEGER,"
                  "deliveryDate TEXT,"
                  "itemCount INTEGER)");

    if (!query.exec()) {
        qDebug() << "Failed to create DeliveryData table:" << query.lastError().text();
        return false;
    }

    return true;
}

bool DatabaseHandler::insertData(const QString &brand, int amount, const QString &date, int itemCount)
{

    QSqlQuery query;
    query.prepare("INSERT INTO DeliveryData (brand, amountDelivered, deliveryDate, itemCount) VALUES (:brand, :amount, :date, :itemCount)");
    query.bindValue(":brand", brand);
    query.bindValue(":amount", amount);
    query.bindValue(":date", date);
    query.bindValue(":itemCount", itemCount);

    if (query.exec()) {
        qDebug() << "Data inserted successfully.";
        return true;
    } else {
        qDebug() << "Failed to insert data:" << query.lastError().text();
        return false;
    }
}

bool DatabaseHandler::open() {
    return m_database.open();
}

void DatabaseHandler::emitDatabaseLoadedSignal() {
    emit databaseLoaded();
}

// wrapper function to call .exec() from qml
QVariant DatabaseHandler::execQuery(const QString &query)
{
    QSqlQuery sqlQuery;
    if (!m_database.isOpen()) {
        qWarning() << "Database is not open.";
        return QVariantMap(); // Return an empty QVariantMap
    }

    if (!sqlQuery.exec(query)) {
        qWarning() << "Failed to execute query:" << query << "Error:" << sqlQuery.lastError().text();
        return QVariantMap(); // Return an empty QVariantMap
    }

    QVariantList result;

    while (sqlQuery.next()) {
        QVariantMap row;
        row["brand"] = sqlQuery.value("brand").toString();
        row["amountDelivered"] = sqlQuery.value("amountDelivered").toInt();
        row["deliveryDate"] = sqlQuery.value("deliveryDate").toString();
        row["itemCount"] = sqlQuery.value("itemCount").toInt();

        result.append(row);
    }

    qDebug() << "Result from execQuery:" << result;

    return result;
}
