import QtQuick 2.0

Rectangle {
    id: root
    property string name
    property bool isFree: true
    property int number
    signal clicked

    color: isFree? "green" : "red"
    enabled: true

    Text {
        text: name
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: false
        onClicked: {
//            isFree? isFree=false : isFree=true;
            root.clicked()
        }
    }

    Connections{
        target: Reservation_roommodel
        onToRed: {
            console.log("tored"+id_room)
            if(id_room!=root.number){
                return
            }

            isFree=false
            root.color="red"
        }

    }
    Connections{
        target: Reservation_roommodel
        onToGreen: {
            console.log("togreen"+id_room)
            if(id_room!=root.number){
                return
            }
            isFree=true
            root.color="green"
        }

    }

}
