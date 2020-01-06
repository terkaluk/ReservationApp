#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>


class DataBase
{

public:
    DataBase(QObject* parent);
    QSqlQuery query;

private:
    QSqlDatabase    db;

};

#endif // DATABASE_H
