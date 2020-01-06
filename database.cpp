#include "database.h"
#include "sqlite3.h"
#include <QSqlQuery>
#include <QSqlError>


DataBase::DataBase(QObject* parent)
{
    QSqlDatabase db=QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("../ReservationApp/MyDatabase.db");
    db.open();
    query=QSqlQuery(db);

}
