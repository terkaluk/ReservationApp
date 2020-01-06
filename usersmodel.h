#ifndef USERSMODEL_H
#define USERSMODEL_H
#include <QObject>
#include <QtQml>
#include "database.h"
class User {
public:
    int id;
    QString login;
    QString password;
};



class UsersModel: public QObject
{
    Q_OBJECT
public:
    UsersModel(QObject* parent, DataBase* db);
    Q_INVOKABLE QString get_login(int id) const;
    Q_INVOKABLE QString get_password(QString login);
    Q_INVOKABLE bool checkData(QString login, QString password);
private:
    QMap<int, QSharedPointer<User>> users;
    DataBase* db;
};

#endif // USERSMODEL_H
