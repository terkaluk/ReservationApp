#ifndef ROOMMODEL_H
#define ROOMMODEL_H
#include <QtCore>
#include <QObject>
#include <QtQml>


class Room {
public:
    int id;
    QString name;
    int floor;
    int piano_number;
    int board_number;
    bool empty;
};

class RoomModel: public QObject
{
    Q_OBJECT
public:
    RoomModel(QObject* parent);
    Q_INVOKABLE QList<int> get_room_id() const;
    Q_INVOKABLE QString get_name(int id) const;
private:
    QMap<int, QSharedPointer<Room>> rooms;
};

#endif // ROOMMODEL_H
