#include "backend.h"
#include "roommodel.h"
#include "reservation_roommodel.h"
#include "usersmodel.h"

BackEnd::BackEnd(QQmlApplicationEngine* engine)
{
    roomModel=new RoomModel(this);
     db=new DataBase(this);
    reservation_roommodel=new Reservation_roommodel(this, db);
    usersmodel=new UsersModel(this, db);
    context = engine->rootContext();
    context->setContextProperty("RoomModel",roomModel);
    context->setContextProperty("Reservation_roommodel",reservation_roommodel);
    context->setContextProperty("UsersModel", usersmodel);



}


