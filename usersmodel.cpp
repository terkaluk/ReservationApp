#include "usersmodel.h"
#include "database.h"

UsersModel::UsersModel(QObject* parent, DataBase* db): QObject (parent)
{
    this->db=db;
    db->query.prepare("select * from users;");
    db->query.exec();
    while (db->query.next()){
        auto u=QSharedPointer<User>(new User);
        u->id=db->query.value(0).toInt();
        u->login=db->query.value(1).toString();
        u->password=db->query.value(2).toString();
        users.insert(u->id, u);
    }
}

QString UsersModel::get_login(int id) const {
    if(users.contains(id)){
        return users[id]->login;
    }
    else{
        return "error";
    }
}

QString UsersModel::get_password(QString login) {
    for(auto key: users.keys()){
        if (users[key]->login==login){
            return users[key]->password;
        }
    }
    return "error";
}

bool UsersModel::checkData(QString login, QString password){
    QString str=get_password(login);
    if(str==password){
        return true;
    }
    else{
        return false;
    }
}

