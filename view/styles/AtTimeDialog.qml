import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4


Dialog {
    id: timePicker
    property int hours
    property int minutes
    property var _time : getSystemTime()
    property var $cbChosenTime : null

    signal finished
    signal canceled
    onFinished: timePicker.state = ""
    onCanceled: timePicker.state = ""
    width: 320;
    standardButtons : StandardButton.Yes | StandardButton.No

    onYes : {
        if ( $cbChosenTime != null ) {
            timePicker.$cbChosenTime(hourList.currentIndex + ":" + minuteList.currentIndex);
        }
    }



    function getSystemTime() {
        var time = Qt.formatDateTime(new Date(), "HH mm");
        return time.split(" ");
    }

    Column {
        id: contentColumn
        width: parent.width

        Rectangle {
            color: Qt.rgba(0.9, 0.9, 0.9)
            height: 80;
            width: parent.width
            Row {
                clip: true
                spacing: 1
                anchors.fill: parent
                ListView {
                    id: hourList
                    width: parent.width/2;
                    height: 80
                    model: ListModel {
                        id: hourModel
                        Component.onCompleted: {
                            for (var index = 0; index < 24; index++) {
                                hourModel.append({"hours": index});
                            }
                            hourList.currentIndex = _time[0];
                        }
                    }
                    delegate: AtTimePickerItem {
                        number: hours
                        onIsCurrentItemChanged: {
                            if (isCurrentItem) {
                                timePicker.hours = hours;
                            }
                        }
                    }
                    snapMode: ListView.SnapToItem
                    flickDeceleration: 1000
                    preferredHighlightBegin: 0; preferredHighlightEnd: 23
                    highlightRangeMode: ListView.StrictlyEnforceRange
                }

                Text {
                    text : ":"
                    height: parent.height
                    font.pixelSize: 36
                }

                ListView {
                    id: minuteList
                    width: parent.width/2; height: 300
                    model: ListModel {
                        id: minuteModel
                        Component.onCompleted: {

                            for (var index = 0; index < 60; index++) {
                                minuteModel.append({"minutes": index});
                            }
                            minuteList.currentIndex = _time[1];
                        }
                    }
                    delegate: AtTimePickerItem {
                        number: minutes
                        onIsCurrentItemChanged: {
                            if (isCurrentItem) {
                                timePicker.minutes = minutes;
                            }
                        }
                    }

                    snapMode: ListView.SnapToItem
                    flickDeceleration: 1000
                    preferredHighlightBegin: 0; preferredHighlightEnd: 59
                    highlightRangeMode: ListView.StrictlyEnforceRange
                }
            }

            Rectangle {
                height: 80; width: parent.width
                gradient: Gradient {
                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0) }
                    GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.6) }
                }
                anchors.top: parent.top
            }
            Rectangle {
                height: 80; width: parent.width
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0) }
                    GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.6) }
                }
                anchors.bottom: parent.bottom
            }
        }
        Item { width: 1; height: 10 }
    }

}
