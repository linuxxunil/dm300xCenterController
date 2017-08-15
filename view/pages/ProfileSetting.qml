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

    $cbSaveButton : function() {
        if ( _isChanged ) {
            //nicDialog.$text = "系统必须重新启动才会生效,是否立即重启!?"
            profileDialog.open()
        } else {
            settingViews.pop()
        }
    }

    AtMessageDialog2 {
        id : profileDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function () {
            var exec = qmlSettings.systemReboot
        }
        $cbOnNo : function () {
            settingViews.pop()
        }
    }

    AtSettingContent {
        id: generalSetting
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin : 8
        anchors.rightMargin: 8
        anchors.bottomMargin: 16
        anchors.topMargin: 24

        TextArea {
            //clip : true
            verticalScrollBarPolicy :Qt.ScrollBarAlwaysOn
            anchors.fill: parent
            wrapMode : TextEdit.Wrap
            verticalAlignment : Text.AlignTop
            textFormat : TextEdit.PlainText
            text : qmlSettings.profileConfigs

            onTextChanged: {
                if ( qmlSettings.profileConfigs !== text) {
                    qmlSettings.profileConfigs = text;
                    _isChanged = true;
                }
            }
        }
    }

}
