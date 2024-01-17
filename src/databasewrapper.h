
#ifndef DATABASEWRAPPER_H
#define DATABASEWRAPPER_H

#include <QObject>
#include <QSqlDatabase>

class DatabaseWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QSqlDatabase database READ database NOTIFY databaseChanged)

public:
    explicit DatabaseWrapper(QObject *parent = nullptr);

    QSqlDatabase database() const;

    void emitDatabaseLoadedSignal();

signals:
    void databaseChanged();
    void databaseLoaded();

private:
    QSqlDatabase m_database;
};

#endif // DATABASEWRAPPER_H
