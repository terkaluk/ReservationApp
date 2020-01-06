#include "reservation_roommodel.h"
#include "database.h"


Reservation_roommodel::Reservation_roommodel(QObject* parent, DataBase* db): QObject (parent)
{
    counter=0;
    this->db=db;
    db->query.prepare("select id from RESERVATIONS order by ID desc limit 1;");
    db->query.exec();
    if (db->query.next()){
        counter = db->query.value(0).toInt()+1;
    }
    updateFromDB();
    emit update_reservations();
}


void Reservation_roommodel::addReservation(int id_room, QDateTime date1, QDateTime date2, QString person){

    auto r=QSharedPointer<Reservation>(new Reservation);
    r->id_room=id_room;
    r->date1=date1;
    r->date2=date2;
    r->person=person;
    r->id=this->counter;
    for (auto key: reservations.keys()){
        if(reservations[key]->id_room==id_room||reservations[key]->person==person){
            if(reservations[key]->date1<=r->date1&&r->date1<reservations[key]->date2){
                //nowa rezerwacja zaczyna sie w trakcie trwania starej
                emit failed_added();
                return;
            }
            if(reservations[key]->date1>=r->date1&&r->date2>reservations[key]->date1){
                //nowa rezerwacja zaczyna sie przed stara i konczy po rozpoczeciu starej
                emit failed_added();
                return;
            }
        }
    }
    reservations.insert(r->id, r);


    QString my_query="INSERT INTO Reservations VALUES ('";
    QString ss=r->date1.toString("yyyy-MM-dd hh:mm");
    my_query=my_query+QString::number(counter)+"','"+QString::number(r->id_room)+"','"+ss.toUtf8().constData()+"','";
    ss=r->date2.toString("yyyy-MM-dd hh:mm");
    my_query=my_query+ss.toUtf8().constData()+"','"+r->person.toUtf8().constData()+"');";
    db->query.prepare(my_query);
    db->query.exec();

    counter++;
    qDebug()<<counter;
    emit succesfully_added();
    emit update_reservations();


}

void Reservation_roommodel::delReservation(int id){
    if(reservations.contains(id)){
        reservations.remove(id);
        QString tmp=QString::number(id);
        qDebug()<<"DELETE FROM Reservation WHERE id="<<tmp<<+");";
       db->query.prepare("DELETE FROM Reservations WHERE id="+tmp+");");
        emit update_reservations();
        emit deleted();
        return;
    }
    emit no_deleted();
}

int Reservation_roommodel::get_id_room(int id) const{
    if(reservations.contains(id)){
        return reservations[id]->id_room;
    }
    else{
        return -1;
    }
}

QDateTime Reservation_roommodel::get_date1(int id) const{
    if(reservations.contains(id)){
        return reservations[id]->date1;
    }
    else{
        return QDateTime();
    }
}
QDateTime Reservation_roommodel::get_date2(int id) const{
    if(reservations.contains(id)){
        return reservations[id]->date2;
    }
    else{
        return QDateTime();
    }
}
QString Reservation_roommodel::get_person(int id) const{
    if(reservations.contains(id)){
        return reservations[id]->person;
    }
    else{
        return "error";
    }
}

void Reservation_roommodel::updateFromDB(){
    db->query.prepare("select * from reservations order by dateFrom desc;");
    db->query.exec();
    while(db->query.next()){
        auto r=QSharedPointer<Reservation>(new Reservation);
        r->id=db->query.value(0).toInt();
        r->id_room=db->query.value(1).toInt();
        QString tmp=db->query.value(2).toString();
        r->date1 = QDateTime::fromString(tmp,"yyyy-MM-dd hh:mm");
        tmp=db->query.value(3).toString();
        r->date2 = QDateTime::fromString(tmp,"yyyy-MM-dd hh:mm");
        r->person=db->query.value(4).toString();
        reservations.insert(r->id, r);

    }
    emit update_reservations();
}

void Reservation_roommodel::updateColor(){
    QDateTime actTime=QDateTime::currentDateTime();
    for (auto key: reservations.keys()){
        if(reservations[key]->date1<actTime&&reservations[key]->date2>actTime){
            //daj sygnal do zmiany koloru
            emit toRed(reservations[key]->id_room);
        }
        else{
            emit toGreen(reservations[key]->id_room);
        }
    }
    return;

}

QList<int> Reservation_roommodel::get_room_history(int id_room) const{
    QList<int> myList=QList<int>();
    for (auto key: reservations.keys()){
        qDebug()<<"Reservation_roommodel::get_room_history "<<key;
        qDebug()<<reservations[key]->id_room<<" "<<id_room;
        if(reservations[key]->id_room==id_room){
            myList.append(key);
        }
    }
    return myList;

}
