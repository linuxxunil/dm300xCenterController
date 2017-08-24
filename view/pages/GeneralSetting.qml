import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'


AtSettingTemplate {
    $titleName : "一般设定"
    $titleImagePath : "../images/general.ico"

    property bool _init : false
    property int _heartbeatTimeMin : 0
    property int _heartbeatTimeMax : 86400
    property bool _isChanged : false

    $cbSaveButton : function() {
        if ( _isChanged ) {
            //nicDialog.$text = "系统必须重新启动才会生效,是否立即重启!?";
            generalDialog.open();
        } else {
            settingViews.pop();
        }
    }

    AtMessageDialog2 {
        id : generalDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function () {
            var exec = qmlSettings.systemReboot;
        }
        $cbOnNo : function () {
            settingViews.pop();
        }
    }

    AtSettingContent {
        id: generalSetting

        ColumnLayout {
            RowLayout {
                Text {
                    text : "Cognex-No Read : "
                }

                AtTextInput {
                    $width: 80
                    $text : {
                        var val = qmlSettings.generalDeviceNoRead
                        val = val.replace('\r',"\\r").replace('\n',"\\n");
                        return val;
                    }
                    $cbOnTextChanged : function(val) {
                        qmlSettings.generalDeviceNoRead = val;
                        _isChanged = true;
                    }
                }
            }

            RowLayout {
                Text {
                    text : "Cognex-Response Suffix : "
                }

                AtTextInput {
                    $width: 80
                    $text : {
                        var val = qmlSettings.generalDeviceEndingSymbol
                        val = val.replace('\r',"\\r").replace('\n',"\\n");
                        return val;
                    }
                    $cbOnTextChanged : function(val) {
                        qmlSettings.generalDeviceEndingSymbol = val;
                        _isChanged = true;
                    }
                }
            }

            RowLayout {
                Text {
                    text : "Service-Ruquest : "
                }

                AtTextInput {
                    $width: 80
                    $text : {
                        var val = qmlSettings.generalUserRequest;
                        val = val.replace('\r',"\\r").replace('\n',"\\n");
                        return val;
                    }
                    $cbOnTextChanged : function(val) {
                        qmlSettings.generalUserRequest = val
                        _isChanged = true;
                    }
                }
            }

            RowLayout {
                Text {
                    text : "ServiceRequest-Suffix : "
                }

                AtTextInput {
                    $width: 80
                    $text : {
                        var val = qmlSettings.generalUserRequestEndingSymbol;
                        val = val.replace('\r',"\\r").replace('\n',"\\n");
                        return val;
                    }
                    $cbOnTextChanged : function(val) {
                        qmlSettings.generalUserRequestEndingSymbol = val;
                        _isChanged = true;
                    }
                }
                Text {
                    text : "ServiceResponse-Suffix : "
                }

                AtTextInput {
                    $width: 80
                    $text : {
                        var val = qmlSettings.generalUserResponseEndingSymbol;
                        val = val.replace('\r',"\\r").replace('\n',"\\n");
                        return val;
                    }
                    $cbOnTextChanged : function(val) {
                        qmlSettings.generalUserResponseEndingSymbol = val;
                        _isChanged = true;
                    }
                }
            }

            RowLayout {
                Text {
                    text : "Service-Port : "
                }

                AtTextInput {
                    $width: 80
                    $text : qmlSettings.tcpServerPort
                    $cbOnTextChanged : function(val) {
                        qmlSettings.tcpServerPort = val;
                        _isChanged = true;
                    }
                }
            }

            RowLayout {
                Text {
                    text : "Service-MaxClients : "
                }

                AtTextInput {
                    $width: 80
                    $text : qmlSettings.tcpServerMaxClients
                    $cbOnTextChanged : function(val) {
                        qmlSettings.tcpServerMaxClients = val;
                        _isChanged = true;
                    }
                }
            }
        }
    }
}
