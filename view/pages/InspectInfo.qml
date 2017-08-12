import QtQuick 2.7
import QtQuick.Layouts 1.3

import '../styles'

AtSettingTemplate {

    $titleName : "自我检测"

    $titleImagePath : "../images/inspect.ico"

    Timer {
           id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    function checkUart() {

        if ( qmlSettings.uartEnable0 ) {
            var result = qmlSettings.inspectTestUart
            delay(1000, function() {
                var result = qmlSettings.inspectTestUartResult
                inspectDialog.$text = "测试结果 : " + ((result)?"成功":"失败")
                inspectDialog.open()
            })
        } else {
            inspectDialog.$text = "请先启动Uart";
            inspectDialog.open()
        }
    }

    AtMessageDialog {
        id : inspectDialog
        $text: ""
    }

    // Content :
    AtSettingContent {


        ColumnLayout {
            AtButton {
                $name : "串口测试 : "
                $contentName : "开始"
                $cbOnClicked : checkUart

            }
            // TODO
            AtButton {
                visible: false
                $name : "相机测试 : "
                $contentName : "开始"
                $cbOnClicked : function() {
                    console.log("Camera")
                }
            }

            // TODO
            AtButton {
                visible: false
                $name : "DI测试 : "
                $contentName : "开始"
                $cbOnClicked : function() {
                }
            }

            // TODO
            AtButton {
                visible: false
                $name : "DO测试 : "
                $contentName : "开始"
                $cbOnClicked : function() {
                }
            }

            // TODO
            RowLayout {
                visible: false
                AtNetTextInput {
                    id : address
                    $name : '网络地址'
                    $address : qmlSettings.nicAddress
                    $readOnly: _isDhcp
                    $cbOnTextChanged : function(val) {
                    }
                }

                AtButton {
                    visible: false
                    //$name : "测试 : "
                    $contentName : "开始"
                    $cbOnClicked : function() {
                    }
                }
            }

        }


    }
}
