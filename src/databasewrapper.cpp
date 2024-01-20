
#include "DatabaseWrapper.h"

DatabaseWrapper::DatabaseWrapper(QObject *parent) : QObject(parent)
{
    // Initialize your QSqlDatabase here if needed
    m_database = QSqlDatabase::addDatabase("QSQLITE");
    // Assume the database is not initially loaded
    emit databaseChanged();

    // Call a function to emit the signal
    emitDatabaseLoadedSignal();



}
void DatabaseWrapper::emitDatabaseLoadedSignal() {
    emit databaseLoaded();
}
QSqlDatabase DatabaseWrapper::database() const
{
    return m_database;
}




