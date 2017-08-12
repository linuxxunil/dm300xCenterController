import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {

    $titleName : "串口设定"
    $titleImagePath : "../images/uart.ico"

    property bool init : false
    property var _baudrate : ["9600", "19200", "38400", "57600", "115200"]
    property bool _isChanged : false

    $cbSaveButton : function() {
        if ( _isChanged ) {
            uartDialog.open()
        } else {
            settingViews.pop()
        }
    }

    AtMessageDialog2 {
        id : uartDialog
        $text: "系统必须重新启动才会生效,是否立即重启!?"

        $cbOnYes: function() {
            qmlSettings.systemReboot
        }

        $cbOnNo: function() {
            settingViews.pop()
        }
    }

    // Content :
    AtSettingContent {
        id : uartSetting

        ColumnLayout {
            AtCheckBox {
                id : enable
                text : "启动 UART"
                checked: qmlSettings.uartEnable0
                onPressed: {
                    _isChanged = true
                }

                onCheckedChanged: {
                    //console.log(init);
                    qmlSettings.uartEnable0 = checked
                }
            }


            RowLayout {
                visible: enable.checked
                Text {
                    text: '波特率 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : qmlSettings.uartBaudrate0
                    model: _baudrate
                    font.pixelSize: 16
                    onPressedChanged: {

                        _isChanged = true
                    }

                    onCurrentIndexChanged : {
                        qmlSettings.uartBaudrate0 = _baudrate[currentIndex]
                    }
                }
            }
            RowLayout {
                visible: enable.checked
                Text {
                    text: '校验位 : '
                    font.pixelSize: 16
                }
                Text {
                    text: 'None'
                    font.pixelSize: 16
                }
            }

            RowLayout {
                visible: enable.checked
                Text {
                    text: '数据位 : '
                    font.pixelSize: 16
                }

                Text {
                    text: '8'
                    font.pixelSize: 16
                }
            }

            RowLayout {
                visible: enable.checked
                Text {
                    text: '停止位 : '
                    font.pixelSize: 16
                }

                Text {
                    text: '1'
                    font.pixelSize: 16
                }
            }
        }
    }
}
