import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'


AtSettingTemplate {
    $titleName : "网络邻居"
    $titleImagePath : "../images/cifs.ico"

    property bool _init : false
    property int _heartbeatTimeMin : 0
    property int _heartbeatTimeMax : 86400
    property bool _isChanged : false
    property var _modeModel : ["无需认证","需认证"]

    $cbSaveButton : function() {
        if ( _isChanged ) {
            //nicDialog.$text = "系统必须重新启动才会生效,是否立即重启!?";
            cifsDialog.open();
        } else {
            settingViews.pop();
        }
    }

    AtMessageDialog2 {
        id : cifsDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function () {
            var exec = qmlSettings.systemReboot;
        }
        $cbOnNo : function () {
            settingViews.pop();
        }
    }

    AtMessageDialog2 {
        id : alarmDialog
        $text : "挂载成功"
        $onOk : true
    }

    AtSettingContent {
        id: cifsSetting

        ColumnLayout {
            RowLayout {
                AtCheckBox {
                    id : enable
                    text : "启用"
                    checked: qmlSettings.cifsEnable
                    onCheckedChanged: {
                        qmlSettings.cifsEnable = checked;
                        _isChanged = true;
                    }
                }

                AtButton {
                    visible : enable.checked
                    $contentName : "测试挂载"
                    $cbOnClicked: function() {
                        var exec = qmlSettings.systemMountCifs;
                        if ( exec ) {
                            alarmDialog.$text = "挂载成功";
                        } else {
                            alarmDialog.$text = "挂载失败";
                        }
                        alarmDialog.open();
                    }
                }
            }

            RowLayout {
                visible: enable.checked
                Text {
                    text : "服务端路径 : "
                }

                AtTextInput {
                    $width: 200
                    $text : qmlSettings.cifsAddress
                    $cbOnTextChanged : function(val) {
                        qmlSettings.cifsAddress = val;
                        _isChanged = true;
                    }
                }

                Text {
                    text : "(ex:192.168.20.2/share) : "
                }
            }


            RowLayout {
                visible: enable.checked
                AtComboBox {
                    visible : false
                    id : mode
                    $model : _modeModel
                    $currentIndex: qmlSettings.cifsMode
                    $cbOnCurrentIndexChanged : function (val){
                        //qmlSettings.cifsMode = parseInt(val);
                    }
                }


                Text {
                    visible : (mode.$currentIndex == 1)
                    text : "账号 : "
                }

                AtTextInput {
                    visible : (mode.$currentIndex == 1)
                    $width: 120
                    $text : qmlSettings.cifsUsername
                    $cbOnTextChanged : function(val) {
                        qmlSettings.cifsUsername = val;
                        _isChanged = true;
                    }
                }

                Text {
                    visible : (mode.$currentIndex == 1)
                    text : "密码 : "
                }

                AtTextInput {
                    visible : (mode.$currentIndex == 1)
                    $width: 120
                    $text : qmlSettings.cifsPassword
                    $cbOnTextChanged : function(val) {
                        qmlSettings.cifsPassword = val;
                        _isChanged = true;
                    }
                }
            }
            RowLayout {
                visible: enable.checked
                Text {
                    visible : (mode.$currentIndex == 1)
                    text : "Log格式 : "
                }

                AtTextInput {
                    visible : (mode.$currentIndex == 1)
                    $width: 160
                    $text : qmlSettings.cifsLogFormat
                    $cbOnTextChanged : function(val) {
                        qmlSettings.cifsLogFormat = val;
                        _isChanged = true;
                    }
                }

                Text {
                    visible : (mode.$currentIndex == 1)
                    text : "(modelName=%1,dateTime=%2,data=%3) "
                }
            }
        }
    }
}
