#ifndef BACKEND_H
#define BACKEND_H
#include <QQmlApplicationEngine>
#include <QObject>
#include <QQmlContext>
#include "roommodel.h"
#include "reservation_roommodel.h"
#include "database.h"
#include "usersmodel.h"

#include <QtSql>
#include <QtDebug>

class BackEnd: public QObject
{
    Q_OBJECT
public:
    BackEnd(QQmlApplicationEngine* engine);

private:
    QQmlApplicationEngine* engine;
    RoomModel* roomModel;
    Reservation_roommodel* reservation_roommodel;
    QQmlContext* context;
    DataBase* db;
    UsersModel* usersmodel;
};

#endif // BACKEND_H
