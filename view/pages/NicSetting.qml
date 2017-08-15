import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {
    $titleName : "网卡设定"
    $titleImagePath : "../images/nic.ico"
    property bool _isChanged : false
    property int _init : 0
    property bool _isDhcp : (qmlSettings.nicType === "dhcp")? true : false

    $cbSaveButton : function() {
        if ( _isChanged ) {
            //nicDialog.$text = "系统必须重新启动才会生效,是否立即重启!?"
            nicDialog.open()
        } else {
            settingViews.pop()
        }
    }

    AtMessageDialog2 {
        id : nicDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function () {
            var exec = qmlSettings.systemReboot
        }
        $cbOnNo : function () {
            settingViews.pop()
        }
    }

    AtSettingContent {
        id: nicSetting

        ColumnLayout {
            spacing: 6
            RowLayout {
                AtCheckBox {
                    visible: false
                    text : "启动DHCP"
                    checked: _isDhcp
                    onPressed: {
                        _isChanged = true
                    }

                    onCheckedChanged: {
                        //console.log(init);
                        if(checked) {
                            qmlSettings.nicType = "dhcp"
                            _isDhcp = true
                        } else {
                            qmlSettings.nicType = "static"
                            _isDhcp = false
                        }
                    }
                }
            }

            AtNetTextInput {
                id : address
                $name : '网络地址'
                $address : qmlSettings.nicAddress
                $readOnly: _isDhcp
                $cbOnTextChanged : function(val) {
                    _isChanged = true
                    address.$address = val
                    qmlSettings.nicAddress = val
                }
            }

            AtNetTextInput {
                id : netmask
                $name : '网络掩码'
                $address : qmlSettings.nicNetmask
                $readOnly: _isDhcp
                $cbOnTextChanged : function(val) {
                    _isChanged = true
                    netmask.$address = val
                    qmlSettings.nicNetmask = val
                }
            }

            AtNetTextInput {
                id : gateway
                $name : '默认网关'
                $address : qmlSettings.nicGateway
                $readOnly: _isDhcp
                $cbOnTextChanged : function(val) {
                    _isChanged = true
                    gateway.$address = val
                    qmlSettings.nicGateway = val
                }
            }

            AtNetTextInput {
                id : dns1
                $name : '域名解析'
                $address : qmlSettings.nicDNS1
                $readOnly: _isDhcp
                $cbOnTextChanged : function(val) {
                    _isChanged = true
                    dns1.$address = val
                    qmlSettings.nicDNS1 = val
                }
            }
        }
    }
}
