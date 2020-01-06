import QtQuick 2.0

Rectangle{
    id:messageDelWindow
    color: "transparent"
    signal toMain
    property string info: ""
    property alias timer: windowTimer1

    Rectangle{
        width: parent.width*0.4
        height: parent.height*0.4
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#0a822c"
        border.width: 6

        Text {
            height: parent.height/2
            fontSizeMode: Text.Fit
            minimumPixelSize: 1
            font.pixelSize: height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            anchors.leftMargin: parent.border.width
            anchors.rightMargin: anchors.leftMargin
            width: parent.width*0.8
            text:qsTr(info)
        }


        Timer {
            id: windowTimer1
            interval: 2000
            repeat: false
            running: false
            onTriggered: {
                toMain()
                messageDelWindow.visible=false
            }
        }
    }
}
