import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {

    $titleName : "音效设定"
    $titleImagePath : "../images/audio.ico"
    property bool _isChanged : false



    $cbSaveButton : function() {
        if ( _isChanged ) {
            audioDialog.open()
        } else {
            settingViews.pop()
        }
    }


    AtMessageDialog2 {
        id : audioDialog
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
        id : audioSetting

        ColumnLayout {
            AtCheckBox {
                id : enable
                text : "启动音效"
                checked: qmlSettings.audioEnable
                onPressed: {
                    _isChanged = true
                }

                onCheckedChanged: {
                    qmlSettings.audioEnable = checked
                }
            }
        }
    }
}
