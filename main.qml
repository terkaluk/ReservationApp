import QtQuick 2.9
import QtQuick.Controls 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    color: "#d7fba9"
    title: qsTr("ReservationApp")

    Rectangle{
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height*0.1
        color: "transparent"

        Clock{
            id: clock
            width: parent.width*0.2
            anchors.left: parent.left
            height: parent.height*0.7
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: parent.width*0.01
        }

        Rectangle{
            id:legend
            height: parent.height*0.7
            anchors.left: clock.right
            anchors.right: button_toAdd.left
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            Rectangle{
                id: empty_room
                width: parent.width*0.2
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.02
                height: parent.height
                color: "green"
            }

            Text{
                id: legend1
                width: parent.width*0.3
                height: parent.height
                anchors.left: empty_room.right
                text: qsTr(" - sala wolna")
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                font.pixelSize: height/2.3
                verticalAlignment: Text.AlignVCenter
            }

            Rectangle{
                id: busy_room
                width: parent.width*0.2
                anchors.left: legend1.right
                height: parent.height
                color: "red"
            }

            Text{
                id: legend2
                width: parent.width*0.3
                height: parent.height
                anchors.left: busy_room.right
                anchors.right: parent.right
                text: qsTr(" - sala zajęta")
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                font.pixelSize: height/2.3
                verticalAlignment: Text.AlignVCenter
            }

        }

        MyButton{
            id: button_toAdd
            width: parent.width*0.3
            height: parent.height*0.6
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: parent.width*0.01
            text: "DODAJ REZERWACJĘ"
            color: "#a3e782"
            visible: roomInfo1.visible
            onClicked: {
                signIn.roomId=roomInfo1.number
                signIn.visible=true
                roomInfo1.visible=false
                signIn.make_new()
            }
        }
    }


    ListView{
        id: listview

        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        flickableDirection: Flickable.HorizontalFlick
        delegate: Floor{
            level: name_role
            width:  listview.width
            height: listview.height
            onClicked: {
                roomInfo1.number = room_id
                roomInfo1.make_update()
                roomInfo1.visible=true
                signIn.visible=false
                signIn1.visible=false

            }
        }
        model: ListModel{
            ListElement{
                name_role: 1
            }
            ListElement{
                name_role: 2
            }
            ListElement{
                name_role: 3
            }
        }
    }



    SignIntoAdd{
        id: signIn

        width: parent.width
        height: listview.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        visible: false
    }

    SignIntoDel{
        id: signIn1

        width: parent.width
        height: listview.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        visible: false

    }

    RoomInfo{
        id: roomInfo1

        width: parent.width
        height: listview.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        visible: false
        onClicked: {
            print("mam")
            signIn1.visible=true
            signIn.visible=false
            roomInfo1.visible=false
            messageDelNo.visible=false
            messageDelOk.visible=false
            signIn1.reservId=i
        }
    }

    MyMessage{
        id: messageDelOk
        info: "Rezerwacja została usunięta"

        width: parent.width
        height: listview.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        visible: false

        Connections{
            target: Reservation_roommodel
            onDeleted: {
                messageDelOk.visible=true
                messageDelOk.timer.start()
            }
        }

        onToMain: {
            signIn1.visible=false
            signIn.visible=false
            roomInfo1.visible=false
            messageDelNo.visible=false
            messageDelOk.visible=false
            listview.visible=true
        }



    }

    MyMessage{
        id: messageDelNo
        info: "Błąd! Rezerwacji nie można usunąć"

        width: parent.width
        height: listview.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left


        visible: false
        Connections{
            target: Reservation_roommodel
            onNo_deleted:{
                messageDelNo.visible=true
                messageDelNo.timer.start()
            }
        }

        Connections{
            target: signIn1
            onNo_deleted:{
                messageDelNo.visible=true
                messageDelNo.timer.start()
            }
        }

        onToMain: {
            signIn1.visible=false
            signIn.visible=false
            roomInfo1.visible=false
            messageDelNo.visible=false
            messageDelOk.visible=false
            listview.visible=true
        }

    }

    MyMessage{
        id: messageAddOk
        info: "Rezerwacja została dodana"

        width: parent.width
        height: listview.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left


        visible: false
        Connections{
            target: Reservation_roommodel
            onSuccesfully_added:{
                messageAddOk.visible=true
                messageAddOk.timer.start()
            }
        }
        onToMain: {
            signIn1.visible=false
            signIn.visible=false
            roomInfo1.visible=false
            messageDelNo.visible=false
            messageDelOk.visible=false
            listview.visible=true
        }


    }

    MyMessage{
        id: messageAddNo
        info: "Błąd! Rezerwacja nie została dodana"

        width: parent.width
        height: listview.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left


        visible: false
        Connections{
            target: Reservation_roommodel
            onFailed_added:{
                messageAddNo.visible=true
                messageAddNo.timer.start()
            }
        }
        Connections{
            target: signIn
            onFailed_addedSign:{
                messageAddNo.visible=true
                messageAddNo.timer.start()
            }
        }

        onToMain: {
            signIn1.visible=false
            signIn.visible=false
            roomInfo1.visible=false
            messageDelNo.visible=false
            messageDelOk.visible=false
            listview.visible=true
        }

    }

   function checkColors(){
        Reservation_roommodel.updateColor()
    }

   Timer {
       id: textTimer
       interval: 1000
       repeat: true
       running: true
       triggeredOnStart: true
       onTriggered: checkColors()
   }
}




