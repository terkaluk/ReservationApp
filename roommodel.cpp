#include "roommodel.h"

RoomModel::RoomModel(QObject* parent): QObject (parent)
{
    for(int floor=0;floor<3;floor++){
        for(int nr=1;nr<12;nr++){
            auto r = QSharedPointer<Room>(new Room);
            r->id=(floor+1)*100+nr;
            r->name=QString::number(r->id);
            r->empty=true;
            rooms.insert(r->id, r);
        }
    }
}

QList<int> RoomModel::get_room_id() const{

}

QString RoomModel::get_name(int id) const{
    if(rooms.contains(id)){
        return rooms[id]->name;
    }
    else{
        return "error";
    }
}

//bool RoomModel::isEmpty(int id) const{
//    if(rooms.contains(id)){
//        return rooms[id]->empty;
//    }
//    else{
//        return false;
//    }
//}
