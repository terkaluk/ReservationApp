import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle{
    color: "#a3e782"
    visible: true
    property int  reservId: -1
    signal deleted(var  i)
    signal no_deleted()


    Text {
        id: text0
        width: parent.width*0.8
        height: parent.height*0.1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 30
        text: qsTr("Usunięcie rezerwacji wymaga autoryzacji")
        font.italic: true
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 20
        fontSizeMode: Text.Fit
    }

    Text {
        id: text1
        width: parent.width*0.8
        height: parent.height*0.1
        anchors.left: parent.left
        anchors.top: text0.bottom
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


    MyButton{
        text: "USUŃ"
        color: "green"
        width: parent.width*0.5
        height: parent.height*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 30
        onClicked: {
            print(textInput.displayText," ", textInput1.displayText, " ")
            var result=UsersModel.checkData(textInput.text, textInput1.text)
            if(textInput.text==""||textInput1.text==""||//brak loginu lub hasla
                   textInput.text!==Reservation_roommodel.get_person(parent.reservId)//usuwa nie ten co dodal
                    ){
                parent.no_deleted(parent.reservId);
            }
            else if(!result){//niepoprawny login-haslo
                parent.no_deleted(parent.reservId);
            }
            else{
            Reservation_roommodel.delReservation(parent.reservId)
            }
            textInput.text=""
            textInput1.text=""
            parent.visible=false;
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
            parent.visible=false
            textInput.text=""
            textInput1.text=""
        }
    }
}

