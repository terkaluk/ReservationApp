import QtQuick 2.0

Rectangle {

    id: floor_id
    color: "#a3e782"
    border.color: "#00000000"
    property int level: 1
    signal clicked(var room_id)

    function set_name(){

    }

    Rectangle {
        id: title

        width: parent.width
        height: parent.height*0.1
        color: "#a3e782"
        anchors.top: parent.top

        Text {
            id: text
            text: qsTr("Piętro "+level)
            font.pixelSize: 24
            anchors.fill: parent
        }
    }
    Rectangle{
        id: rooms

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: title.bottom
        anchors.bottom: parent.bottom
        color: "#a3e782"
        Room {
            id: room1

            number: floor_id.level*100+1
            name: RoomModel.get_name(number)

            width: parent.width * 0.167
            height: parent.height * 0.3
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            onClicked: {
                floor_id.clicked(number)
            }
        }
        Room {
            id: room3

            number: floor_id.level*100+3
            name: RoomModel.get_name(number)

            width: room1.width
            height: parent.height*0.4
            anchors.bottom: room2.top
            anchors.left: room1.left

            onClicked: {
                floor_id.clicked(number)
            }
        }
        Room {
            id: room2

            number: floor_id.level*100+2
            name: RoomModel.get_name(number)

            width: room1.width
            height: room1.height
            anchors.bottom: room1.top
            anchors.left: room1.left

            onClicked: {
                floor_id.clicked(number)
            }
        }

        Room {
            id: room4

            number: floor_id.level*100+4
            name: RoomModel.get_name(number)

            width: room1.width
            height: room1.height
            anchors.top: room3.top
            anchors.left: room1.right

            onClicked: {
                floor_id.clicked(number)
            }

        }
        Room {
            id: room5

            number: floor_id.level*100+5
            name: RoomModel.get_name(number)
            width: room1.width
            height: room1.height
            anchors.top: room4.top
            anchors.left: room4.right

            onClicked: {
                floor_id.clicked(number)
            }

        }
        Room {
            id: room6

            number: floor_id.level*100+6
            name: RoomModel.get_name(number)

            width: room1.width
            height: room1.height
            anchors.top: room4.top
            anchors.left: room5.right

            onClicked: {
                floor_id.clicked(number)
            }

        }
        Room {
            id: room7

            number: floor_id.level*100+7
            name: RoomModel.get_name(number)

            width: room1.width
            height: room1.height
            anchors.top: room4.top
            anchors.left: room6.right

            onClicked: {
                floor_id.clicked(number)
            }

        }
        Room {
            id: room8

            number: floor_id.level*100+8
            name: RoomModel.get_name(number)

            width: room1.width
            height: parent.height*0.4
            anchors.top: room4.top
            anchors.left: room7.right

            onClicked: {
                floor_id.clicked(number)
            }

        }
        Room {
            id: room9

            number: floor_id.level*100+9
            name: RoomModel.get_name(number)

            width: room1.width
            height: room1.height
            anchors.top: room8.bottom
            anchors.left: room8.left

            onClicked: {
                floor_id.clicked(number)
            }

        }
        Room {
            id: room11

            number: floor_id.level*100+11
            name: RoomModel.get_name(number)

            width: room1.width*2
            height: room1.height
            anchors.bottom: room1.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                floor_id.clicked(number)
            }

        }

        Room {
            id: room10

            number: floor_id.level*100+10
            name: RoomModel.get_name(number)

            width: room1.width
            height: room1.height
            anchors.top: room9.bottom
            anchors.left: room8.left

            onClicked: {
                floor_id.clicked(number)
            }

        }
    }


}
