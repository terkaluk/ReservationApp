#ifndef RESERVATION_ROOMMODEL_H
#define RESERVATION_ROOMMODEL_H
#include <QtCore>
#include <QObject>
#include <QtQml>
#include "database.h"

class Reservation {
public:
    int id;
    int id_room;
    QDateTime date1;
    QDateTime date2;
    QString person;
};



class Reservation_roommodel: public QObject
{
    Q_OBJECT
public:
    int counter;
    Reservation_roommodel(QObject* parent, DataBase* db);
    Q_INVOKABLE int get_id_room(int id) const;
    Q_INVOKABLE QList<int> get_room_history(int id_room) const;
    Q_INVOKABLE QDateTime get_date1(int id) const;
    Q_INVOKABLE QDateTime get_date2(int id) const;
    Q_INVOKABLE QString get_person(int id) const;
    Q_INVOKABLE void addReservation(int id_room, QDateTime date1, QDateTime date2, QString person);
    Q_INVOKABLE void delReservation(int id);
    Q_INVOKABLE void updateColor();
    void updateFromDB();
    signals:
    void update_reservations(); void no_deleted(); void deleted(); void succesfully_added(); void failed_added();
    void toRed(int id_room); void toGreen(int id_room);

private:
    QMap<int, QSharedPointer<Reservation>> reservations;
    DataBase* db;
};

#endif // RESERVATION_ROOMMODEL_H
