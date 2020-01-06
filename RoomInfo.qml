import QtQuick 2.0

Rectangle {
    color: "#a3e782"
    property int number: 0
    signal clicked(var i)
    id: window1

    Text{
        id: room_name

        anchors.left: parent.left
        anchors.top: parent.top
        height: parent.height/8
        fontSizeMode: Text.Fit
        minimumPixelSize: 1
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter
        width: parent.width*0.2
        text:qsTr("Sala "+number)
    }

    ListView{
        id: listview1

        width: parent.width
        height: parent.height*0.8
        anchors.top: room_name.bottom
        anchors.left: parent.left

        snapMode: ListView.SnapOneItem
        orientation: ListView.Vertical
        flickableDirection: Flickable.VerticalFlick
        delegate: Rectangle {
            id: rectangle
            width: listview1.width
            height: 67
            color: "#ffffff"
            border.color: "#0a822c"
            border.width: 6

            Rectangle{
                id:el1
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width/3
                border.color: "#0a822c"
                border.width: 6
                Text {
                    id: dateFromText
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    font.pixelSize: parent.height/4
                    text: dateFrom
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle{
                id:el2
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.left: el1.right
                width: parent.width/3
                border.color: "#0a822c"
                border.width: 6
                Text {
                    id: dateToText
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    font.pixelSize: parent.height/4
                    text: dateTo
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id:el3
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.right: toDelete.left
                anchors.left: el2.right
                border.color: "#0a822c"
                border.width: 6

                Text {
                    id: userText
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    font.pixelSize: parent.height/4
                    text: userId
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle{
                id:toDelete
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.right: parent.right
                width: parent.height
                color: "red"
                property int reservId: model.reservId

                Text {
                    id: deleteText
                    anchors.fill: parent
                    minimumPixelSize: 1
                    font.pixelSize: parent.height/2
                    text: "-"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: window1.clicked(parent.reservId)
                }
            }
        }

        model: ListModel{
            function get_history_room(){
                clear()
                var list=Reservation_roommodel.get_room_history(number)
                for (var i=0; i<list.length;i++){
                    var v = {
                        "dateFrom" : Reservation_roommodel.get_date1(list[i]).toLocaleString(Qt.locale("de_DE"), "yyyy-MM-dd hh:mm"),
                        "dateTo": Reservation_roommodel.get_date2(list[i]).toLocaleString(Qt.locale("de_DE"), "yyyy-MM-dd hh:mm"),
                        "userId":Reservation_roommodel.get_person(list[i]),
                        "reservId": list[i]

                    }
                    append(v)
                }

            }

            Component.onCompleted: {
                get_history_room()
            }


        }
        Connections{
            target: Reservation_roommodel
            onUpdate_reservations: {
                listview1.model.get_history_room()
            }
        }
    }

    function make_update(){
        listview1.model.get_history_room();
    }


}
