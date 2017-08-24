import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.5
import '../styles'


AtSettingTemplate {
    $titleName : "Profile设定"
    $titleImagePath : "../images/profile.ico"

    property bool _init : false
    property int _heartbeatTimeMin : 0
    property int _heartbeatTimeMax : 86400
    //property var _configs : JSON.parse(qmlSettings.profileConfigs);
    property bool _isChanged : false
    property var _configs : JSON.parse(qmlSettings.profileConfigs);
    property var _model : []
    signal visibleChanged()

    $cbSaveButton : function() {
        if ( _isChanged ) {
            //nicDialog.$text = "系统必须重新启动才会生效,是否立即重启!?"
            profileDialog.open();
        } else {
            settingViews.pop();
        }
    }

    AtMessageDialog2 {
        id : profileDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function () {
            var exec = qmlSettings.systemReboot;
        }
        $cbOnNo : function () {
            settingViews.pop();
        }
    }

    AtSettingContent {
        id: profileSetting
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.leftMargin : 8
//        anchors.rightMargin: 8
//        anchors.bottomMargin: 16
//        anchors.topMargin: 24

        ColumnLayout {
            RowLayout {
                Text {
                    text : "选择设备 : "
                }

                AtComboBox {
                     id : profiles
                     $model: {
                         for ( var i=1; i<=_configs.length; i++ ) {
                            _model[i-1] = "" + i ;
                         }
                         return _model;
                     }
                     $currentIndex : 0
                }

                AtCheckBox {
                    checked: _configs[profiles.currentIndex].visible
                    text : "显示"
                    onClicked: {
                        _configs[profiles.currentIndex].visible = checked;
                        qmlSettings.profileConfigs = JSON.stringify(_configs);
                        _isChanged = true;
                    }
                }
            }
            RowLayout {
                Text {
                    text: "机型 : "
                }
                AtTextInput {
                    $width : 200
                    $text : _configs[profiles.currentIndex].modelName
                    $cbOnDisplayTextChanged : function(val) {
                        _configs[profiles.currentIndex].modelName = val
                        qmlSettings.profileConfigs = JSON.stringify(_configs);
                        _isChanged = true;
                    }

                }

                Text {
                    text: "说明 : "
                }
                AtTextInput {
                    $width : 200
                    $text : _configs[profiles.currentIndex].comment
                    $cbOnDisplayTextChanged : function(val) {
                        _configs[profiles.currentIndex].comment = val
                        qmlSettings.profileConfigs = JSON.stringify(_configs);
                        _isChanged = true;
                    }
                }

            }

            RowLayout {
                AtNetTextInput {
                    $name : "ServiceIP位置"
                    $address : _configs[profiles.currentIndex].serviceIp
                    $cbOnDisplayTextChanged : function(val) {
                        _configs[profiles.currentIndex].serviceIp = val
                        qmlSettings.profileConfigs = JSON.stringify(_configs);
                        _isChanged = true;
                    }
                }
            }

            RowLayout {
                AtNetTextInput {

                    $name : "ScannerIP位置"
                    $address : _configs[profiles.currentIndex].deviceIp
                    $cbOnDisplayTextChanged : function(val) {
                        _configs[profiles.currentIndex].deviceIp = val
                        qmlSettings.profileConfigs = JSON.stringify(_configs);
                        _isChanged = true;
                    }
                }
                Text {
                    text : " Port : "
                }

                AtTextInput {
                    $width : 55
                    $text :  _configs[profiles.currentIndex].devicePort
                    $cbOnDisplayTextChanged : function(val) {
                        _configs[profiles.currentIndex].devicePort = parseInt(val);
                        qmlSettings.profileConfigs = JSON.stringify(_configs);
                        _isChanged = true;
                    }
                }
            }
        }
    }
}

//        TextArea {
//            //clip : true
//            verticalScrollBarPolicy :Qt.ScrollBarAlwaysOn
//            anchors.fill: parent
//            wrapMode : TextEdit.Wrap
//            verticalAlignment : Text.AlignTop
//            textFormat : TextEdit.PlainText
//            text : qmlSettings.profileConfigs

//            onTextChanged: {
//                if ( qmlSettings.profileConfigs !== text) {
//                    qmlSettings.profileConfigs = text;
//                    _isChanged = true;
//                }
//            }
