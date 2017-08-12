import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'


AtSettingTemplate {
    $titleName : "时间设定"
    $titleImagePath : "../images/camera.ico"

    property var _dateTime : getSystemDateTime()

    function getSystemDateTime() {
        var dateTime = Qt.formatDateTime(new Date(), "yyyy MM dd HH mm ss");
        return dateTime.split(" ");
    }


    Timer {
        id: timer
        repeat : true
        interval: 1000
        running: true;
        onTriggered: {
            _dateTime = getSystemDateTime();
        }
    }

    AtDateDialog {
        id : dateDialog
        $title : "Date"
    }
    AtTimeDialog {
        id : timeDialog
    }



    AtSettingContent {
        id: timeSetting

        ColumnLayout {
            RowLayout {
                AtCheckBox {
                    id: ntpEnable
                    checked: qmlSettings.systemEnableNtp
                    text: "启动时间自动校正"
                    onPressedChanged: {
                        if ( !pressed ) {
                            qmlSettings.systemEnableNtp = checked;
                        }
                    }
                }

                RowLayout {
                    visible: ntpEnable.checked

                    Label {
                        text : "时间伺服器 : "
                        font.pixelSize: 16
                    }


                    AtTextInput {
                        $text : qmlSettings.systemNtpServer
                        $width : 200
                        $cbOnTextChanged : function(val) {
                            qmlSettings.systemNtpServer = val;
                        }
                    }
                }
            }


            RowLayout {
                Text {
                    text : "日期 : "
                    font.pixelSize: 16
                }


                AtTimeLabel {

                    $name : "年"
                    $num : _dateTime[0]
                }

                AtTimeLabel {
                    $name : "月"
                    $num : _dateTime[1]
                }

                AtTimeLabel {
                    $name : "日"
                    $num : _dateTime[2]
                }

                AtButton {
                    visible: !ntpEnable.checked

                    $contentName : "修改日期"
                    $cbOnClicked : function() {
                        dateDialog.$cbLastChosen = function (val) {
                            qmlSettings.systemDate = Qt.formatDate(val, "yyyyMMdd");
                        }
                        dateDialog.open();
                    }
                }
            }

            RowLayout {

                Text {
                    text : "时间 : "
                    font.pixelSize: 16
                }

                AtTimeLabel {
                    $name : "时"
                    $num : _dateTime[3]
                }

                AtTimeLabel {
                    $name : "分"
                    $num : _dateTime[4]
                }

                AtTimeLabel {
                    $name : "秒"
                    $num : _dateTime[5]
                }

                AtButton {
                    visible: !ntpEnable.checked

                    $contentName : "修正时间"
                    $cbOnClicked : function() {
                        timeDialog.$cbChosenTime = function(val) {
                            qmlSettings.systemTime = val;
                        }
                        timeDialog.open();
                    }
                }

            }
        }
    }
}

