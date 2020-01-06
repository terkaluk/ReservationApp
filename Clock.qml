import QtQuick 2.0

Rectangle {

    Text {
        id:t1

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height/2
        fontSizeMode: Text.Fit
        minimumPixelSize: 1
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter
        function set() {
            t1.text =new  Date().toLocaleDateString()
        }
    }


    Text{
        id:t2
        function set() {
            t2.text =new  Date().toLocaleString(Qt.locale("de_DE"), "hh:mm:ss")
        }
        horizontalAlignment: Text.AlignHCenter
        anchors.top:t1.bottom
        fontSizeMode: Text.Fit
        width: parent.width
        height: parent.height/2
    }

    Timer {
        id: textTimer
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: t2.set(), t1.set()
    }

}

