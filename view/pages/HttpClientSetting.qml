import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {
    $titleName : "HttpClient"
    $titleImagePath : "../images/httpclient.ico"
    property bool isChanged : false
    property var type : ["SOAP"]
    property int init : 0


    $cbSaveButton : function() {
        if ( isChanged ) {
            httpClientDialog.$text = "系统必须重新启动才会生效,是否立即重启!?";

            httpClientDialog.$cbOnYes = function () {
                var exec = qmlSettings.systemReboot
            }
            httpClientDialog.$cbOnNo = function () {
                settingViews.pop()
            }
            httpClientDialog.open();
        } else {
            settingViews.pop()
        }
    }

    AtMessageDialog2 {
        id : httpClientDialog
    }

    AtSettingContent {
        id : httpClientSetting

        ColumnLayout {
            spacing: 6

            AtCheckBox {
                id : enable
                text : "启动Http Client"
                checked: qmlSettings.httpClientEnable
                onCheckedChanged: {
                    if ( ++init > 0) {
                        isChanged = true
                        qmlSettings.httpClientEnable = checked
                    }
                }
            }

            RowLayout {
                Text {
                    text: '协议类型   : '
                    font.pixelSize: 16
                    visible: enable.checked
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : 0
                    model: type
                    font.pixelSize: 16
                    visible: enable.checked
                    onCurrentIndexChanged : {
                    }
                }
            }

            RowLayout {
                AtGenernalTextInput {
                    id : address
                    $name : '客护网址'
                    $text : qmlSettings.httpClientUrl
                    visible: enable.checked
                    $width : 250
                    $cbOnTextChanged : function(val) {
                        isChanged = true
                        qmlSettings.httpClientUrl = val
                    }
                }
            }
        }
    }
}
