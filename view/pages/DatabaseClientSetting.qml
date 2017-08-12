import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {
    $titleName : "DB Client"
    $titleImagePath : "../images/dbclient.ico"
    $headerWidth : 250
    property var dbtype : ["MSSQL"]
    property bool isChanged : false
    property int init : 0

    $cbSaveButton : function() {
        if ( isChanged ) {
            dbClientDialog2.open()
        } else {
            settingViews.pop()
        }
    }


    AtMessageDialog2 {
        id : dbClientDialog2
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function () {
            var exec = qmlSettings.systemReboot
        }
        $cbOnNo : function () {
            settingViews.pop()
        }
    }

    AtMessageDialog2 {
        id : dbClientDialog
        $text : "[unixODBC][Driver Manager]Can't open lib '/usr/lib/arm-linux-gnueabihf/odbc/libtdsodbc.so' : file not found QODBC3: Unable to connects"
        $onOk : true
    }


    AtSettingContent {
        id: databaseClientSetting

        ColumnLayout {
            spacing: 6

            RowLayout {
                AtCheckBox {
                    id : enable
                    text : "启动Database Client"
                    checked: qmlSettings.dbClientEnable
                    onPressedChanged : {
                        isChanged = true

                    }
                    onCheckedChanged: {
                        qmlSettings.dbClientEnable = checked
                    }
                }

                Text {
                    text : "数据库类型 : "
                    font.pixelSize: 16
                    visible: enable.checked
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : 0//qmlSettings.uartBaudRate
                    model: dbtype
                    font.pixelSize: 16
                    visible: enable.checked
                    onCurrentIndexChanged : {

                    }
                }
            }
            RowLayout {
                spacing: 6
                AtNetTextInput {
                    id : dbClientAddress
                    $name : '数据库地址'
                    $address : qmlSettings.dbClientServer
                    visible: enable.checked
                    $cbOnTextChanged : function(val) {
                        isChanged = true
                        dbClientAddress.$address = val
                        qmlSettings.dbClientServer = val
                    }
                }

                AtGenernalTextInput {
                    id : dbClientPort
                    $name : '数据库端口'
                    $text : qmlSettings.dbClientPort
                    $width : 100
                    visible: enable.checked
                    $cbOnTextChanged : function(val) {
                        isChanged = true
                        qmlSettings.dbClientPort = val
                    }
                }
            }


            RowLayout {
                AtGenernalTextInput {
                    id : dbClientName
                    $name : '数据库名称'
                    $width : 100
                    $text : qmlSettings.dbClientDatabase
                    visible: enable.checked
                    $cbOnTextChanged : function(val) {
                        isChanged = true
                        qmlSettings.dbClientDatabase = val
                    }
                }

                AtGenernalTextInput {
                    id : dbClientFunction
                    $name : '函数名称'
                    $width : 100
                    $text : qmlSettings.dbClientFunction
                    visible: enable.checked
                    $cbOnTextChanged : function(val) {
                        isChanged = true
                        qmlSettings.dbClientFunction = val
                    }
                }
            }

            RowLayout {
                AtGenernalTextInput {
                    id : dbClientUsername
                    $name : '数据库帐号'
                    $width : 100
                    $text : qmlSettings.dbClientUsername
                    visible: enable.checked
                    $cbOnTextChanged : function(val) {
                        isChanged = true
                        qmlSettings.dbClientUsername = val

                    }
                }
                AtGenernalTextInput {
                    id : dbClientPassword
                    $name : '数据库密码'
                    $width : 100
                    $text : qmlSettings.dbClientPassword
                    visible: enable.checked
                    $cbOnTextChanged : function(val) {
                        isChanged = true
                        qmlSettings.dbClientPassword = val
                    }
                }
            }
            RowLayout {
                visible: enable.checked
                Text {
                    text: '连接状态 : ' + qmlSettings.dbClientIsConnected
                    font.pixelSize: 16
                }

                AtButton {
                    visible : !qmlSettings.dbClientIsConnected
                    $contentName : '错误讯息'
                    $cbOnClicked : function() {
                        dbClientDialog.$text = qmlSettings.dbClientConnectErrorMsg
                        dbClientDialog.open()
                    }
                }
            }
        }
    }
}
