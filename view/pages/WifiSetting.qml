import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {
    $titleName : "Wifi设定"
    $titleImagePath : "../images/camera.ico"

    AtSettingContent {
        id: networkSetting

        ColumnLayout {
            spacing: 6
            RowLayout {
                AtCheckBox {
                    text : "SSID"
                    onCheckedChanged {

                    }
                }
            }

            AtNetTextInput {
                $name : 'SSID'
                $filed1 : "192"
                $filed2 : "168"
                $filed3 : "1"
                $filed4 : "1"
            }

            AtNetTextInput {
                $name : '网络掩码'
                $filed1 : "255"
                $filed2 : "255"
                $filed3 : "255"
                $filed4 : "0"
            }

            AtNetTextInput {
                $name : '默认网关'
                $filed1 : "255"
                $filed2 : "255"
                $filed3 : "255"
                $filed4 : "0"
            }

            AtNetTextInput {
                $name : '域名解析'
                $filed1 : "192"
                $filed2 : "168"
                $filed3 : "1"
                $filed4 : "1"
            }
        }
    }
}
