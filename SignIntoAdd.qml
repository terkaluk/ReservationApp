import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle{
    color: "#a3e782"
    visible: true
    property int roomId: 0
    signal failed_addedSign()
    signal toMain()


    Text {
        id: text1
        width: parent.width*0.8
        height: parent.height*0.1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 30
        text: qsTr("Login:")
        font.italic: true
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
        fontSizeMode: Text.Fit
    }

    Rectangle {
        id: rectangle
        width: text1.width
        height: parent.height*0.1
        anchors.left: text1.left
        anchors.top: text1.bottom
        color: "#ffffff"

        TextInput {
            id: textInput
            text: qsTr("")
            anchors.fill: parent
            font.pixelSize: 12
        }
    }

    Text {
        id: text2
        width: parent.width*0.8
        height: parent.height*0.1
        anchors.left: parent.left
        anchors.top: rectangle.bottom
        anchors.leftMargin: 30
        text: qsTr("Hasło:")
        font.bold: true
        font.italic: true
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: rectangle1
        width: text1.width
        height: parent.height*0.1
        anchors.left: text1.left
        anchors.top: text2.bottom
        color: "#ffffff"

        TextInput {
            id: textInput1
            text: qsTr("")
            anchors.fill: parent
            font.pixelSize: 12
        }
    }

    Text {
        id: text3
        width: parent.width*0.8
        height: parent.height*0.1
        anchors.left: parent.left
        anchors.top: rectangle1.bottom
        anchors.leftMargin: 30
        text: qsTr("Data rezerwacji od: (rok, miesiąc, dzień, godzina, minuty)")
        font.bold: true
        font.italic: true
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: rectangle2
        width: text1.width
        height: parent.height*0.1
        anchors.left: text1.left
        anchors.top: text3.bottom
        color: "#ffffff"
        data: list1.get_data()

        Drop_down_list{
            id: list1
            anchors.fill: parent
        }
    }

    Text {
        id: text4
        width: parent.width*0.8
        height: parent.height*0.1
        anchors.left: parent.left
        anchors.top: rectangle2.bottom
        anchors.leftMargin: 30
        text: qsTr("Data rezerwacji do:  (rok, miesiąc, dzień, godzina, minuty)")
        font.bold: true
        font.italic: true
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: rectangle3
        width: text1.width
        height: parent.height*0.1
        anchors.left: text1.left
        anchors.top: text4.bottom
        color: "#ffffff"

       Drop_down_list{
           id: list2
           anchors.fill: parent
       }

    }

    MyButton{
        text: "ZAREZERWUJ"
        color: "green"
        width: parent.width*0.5
        height: parent.height*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 30
        onClicked: {
            var diff = Math.abs(list1.get_data().getTime() - list2.get_data().getTime()) / 3600000;
            var act_date=new Date()
            if (list1.get_data()>list2.get_data()||//wczesniej oddaje niz wypozyczam
                 list1.get_data()<act_date || //wypozyczam w przeszlosci
                 diff>2||//wypozyczam na dluzej niz 2 godziny
                  textInput.text==""||//nie podano loginu lub hasla
                  textInput1.text==""  ){
                parent.failed_addedSign()

            }
            var result=UsersModel.checkData(textInput.text, textInput1.text)
            if(!result){
                parent.failed_addedSign()
            }
            else{


                Reservation_roommodel.addReservation(roomId,
                                                 list1.get_data(),
                                                 list2.get_data(),
                                                 textInput.displayText)
             }

            textInput.text=""
            textInput1.text=""
            parent.visible=false
        }
    }

    MyButton{
        text: "WRÓĆ"
        color: "green"
        width: parent.width*0.4
        height: parent.height*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 30
        onClicked: {
            textInput.text=""
            textInput1.text=""
            parent.visible=false
        }
    }

    function make_new(){
        list2.reset()
        list1.reset()
    }
}
