import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    property date act_data: new Date()

    ComboBox {
        id: year
        anchors.left: parent.left
        width: parent.width*0.2
        height: parent.height


        model: ListModel{
            function make_year(){
                clear()
                for(var i=act_data.getFullYear();i<2035;i++){
                    var v = {
                        "year" : i
                    }
                    append(v)
                }
                year.currentIndex=0
            }

            Component.onCompleted: {
                make_year()
            }
        }
        onCurrentIndexChanged: {
            day.model.update()
        }

    }

    ComboBox {
        id: month
        anchors.left: year.right
        width: parent.width*0.2
        height: parent.height
        currentIndex: act_data.getMonth()

        model: [ "styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec", "lipiec", "sierpień",
            "wrzesień", "październik", "listopad", "grudzień"]
        onCurrentIndexChanged: {
            if (day!=null){
                day.model.update()
            }

        }
    }

    ComboBox {
        id: day

        anchors.left: month.right
        width: parent.width*0.2
        height: parent.height
        anchors.top: parent.top

        model: ListModel {
            function update() {
                clear()
                var day_count = 0
                if (month.currentIndex==0||month.currentIndex==2||month.currentIndex==4||
                        month.currentIndex==6||month.currentIndex==7||month.currentIndex==9||month.currentIndex==11){
                    day_count = 31
                }
                else if(month.currentIndex==3||month.currentIndex==5||month.currentIndex==8||
                        month.currentIndex==10){
                    day_count=30
                }
                else if(month.currentIndex==1){
                    if ((year.model.get(year.currentIndex).year)%4==0){
                        day_count=29
                    }
                    else{
                        day_count=28
                    }

                }


                for (var i=1;i<=day_count;i++) {
                    var v = {
                        "day" : i+""
                    }
                    append(v)

                }
                day.currentIndex=act_data.getDate()-1
            }
            Component.onCompleted: {
                update()
            }
        }


    }
    ComboBox {
        id: hour
        anchors.left: day.right
        width: parent.width*0.2
        height: parent.height
        currentIndex: 0
        model: [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]
    }

    ComboBox {
        id: minutes
        anchors.left: hour.right
        width: parent.width*0.2
        height: parent.height
        currentIndex: 0
        model: ListModel{
            function make_minutes(){
                for (var i=0;i<60;i++) {
                    var v = {
                        "minutes" : i+""
                    }
                    append(v)

                }
            }
            Component.onCompleted: {
                make_minutes()
            }

        }

    }

    function get_data(){
        var v=new Date(year.model.get(year.currentIndex).year,month.currentIndex, day.currentIndex+1,
                       hour.currentIndex+7, minutes.currentIndex)
        return v
    }

    function reset(){
            year.currentIndex=0
            month.currentIndex=0
            day.currentIndex=0
            hour.currentIndex=0
            minutes.currentIndex=0


    }

}
