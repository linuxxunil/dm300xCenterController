import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {

    $titleName : "多主机设定";
    $titleImagePath : "../images/multidev.ico";

    property var _isChanged : false;
    property var _roleModel : ["Master", "Slave"];
    property var _communicationModel: ["Ethernet"];
    property var _syncModel: ["SYNC", "ASYNC"];
    property int _perCountMin : 1
    property int _perCountMax : 1000
    property int _perCountIntervalMin : 0
    property int _perCountIntervalMax : 30000
    property int _syncTimeoutMin : 1000
    property int _syncTimeoutMax : 30000

    $cbSaveButton : function() {
        if ( _isChanged ) {
            multiDeviceDialog.$text = "系统必须重新启动才会生效,是否立即重启!?";
            multiDeviceDialog.$cbOnYes = function() {
                var result = qmlSettings.systemReboot;
            }
            multiDeviceDialog.$cbOnNo = function() {
                settingViews.pop();
            }
            multiDeviceDialog.open();
        } else {
            settingViews.pop()
        }
    }

    AtMessageDialog2 {
        id : multiDeviceDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function(){}
        $cbOnNo : function(){}
    }


    // Content :
    AtSettingContent {
        id : multiDevice

        ColumnLayout {
            spacing: 6

            AtCheckBox {
                id: enable
                text: "启动多主机"
                checked : qmlSettings.muldevEnable
                onPressedChanged: {
                     _isChanged = true
                }

                onCheckedChanged: {
                    qmlSettings.muldevEnable = checked
                }
            }

            RowLayout {
                visible: enable.checked
                Text {
                    text: '通讯界面 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    id : commuication
                    width: 200
                    height: 20
                    currentIndex : 0
                    model: _communicationModel
                    font.pixelSize: 16
                    onPressedChanged: {
                        _isChanged = true
                    }

                    onCurrentIndexChanged : {
                        qmlSettings.muldevRole = currentIndex
                    }
                }

                Text {
                    text: '选择角色 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    id : role
                    width: 200
                    height: 20
                    currentIndex : qmlSettings.muldevRole
                    model: _roleModel
                    font.pixelSize: 16
                    onPressedChanged: {
                        _isChanged = true
                    }

                    onCurrentIndexChanged : {
                        qmlSettings.muldevRole = currentIndex
                    }
                }

                Text {
                    visible: (role.currentIndex == 0)?true:false
                    text: '选择模式 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    visible: (role.currentIndex == 0)?true:false
                    id : mode
                    width: 200
                    height: 20
                    currentIndex : qmlSettings.muldevMode
                    model: _syncModel
                    font.pixelSize: 16
                    onPressedChanged: {
                        _isChanged = true
                    }

                    onCurrentIndexChanged : {
                        qmlSettings.muldevMode = currentIndex
                    }
                }
            }


            RowLayout {
                visible: enable.checked

                AtNetTextInput {
                    visible: (role.currentIndex == 1)?true:false;
                    id : masterIp
                    $name : 'Master 网络地址'
                    $address : qmlSettings.muldevMasterIp

                    $cbOnTextChanged : function(val) {
                        _isChanged = true
                        masterIp.$address = val
                        qmlSettings.muldevMasterIp = val
                    }
                }
            }

            RowLayout {
                visible: (enable.checked &&
                          role.currentIndex == 0 &&
                          mode.currentIndex == 0)?true:false;
                Text {
                    text: '同步超时 : '
                    font.pixelSize: 16
                }

                AtSpinBox {

                    id : timeout
                    $from : _syncTimeoutMin
                    $to : _syncTimeoutMax
                    value: qmlSettings.muldevSyncTimeout
                    onValueChanged: {
                        qmlSettings.muldevSyncTimeout = timeout.value
                    }
                }
            }

//            RowLayout {
//                spacing: 8
//                visible: false//(role.currentIndex == 0)?true:false;

//                Text {
//                    text: '每次拍照几次 : '
//                    font.pixelSize: 16
//                }

//                AtSpinBox {
//                    id : perCount
//                    $from : _perCountMin
//                    $to : _perCountMax
//                    value: qmlSettings.muldevCmdTriggerPerCount
//                    onValueChanged: {
//                        qmlSettings.muldevCmdTriggerPerCount = perCount.value
//                    }
//                }

//                Text {
//                    text: '拍照间隔毫秒 : '
//                    font.pixelSize: 16
//                }

//                AtSpinBox {
//                    id : perCountInterval
//                    $from : _perCountIntervalMin
//                    $to : _perCountIntervalMax
//                    value: qmlSettings.muldevCmdTriggerPerCountInterval
//                    onValueChanged: {
//                        qmlSettings.muldevCmdTriggerPerCountInterval = perCountInterval.value
//                    }
//                }
//            }
        }
    }

}
