import QtQuick 2.0

Rectangle {
    signal clicked
    property string text: "text"
    id: rectangle
    color: "#a3e782"

    Text {
        id: text1
        text: qsTr(rectangle.text)
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.italic: true
        font.bold: true
        font.pixelSize: 18
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: rectangle.clicked()
    }
}

