import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import '../styles'

AtSettingTemplate {
    $titleName : "系統设定"
    $titleImagePath : "../images/system.ico"

    property int _init : 0

    function execSysReboot() {
        sysDialog.$text = "系统立即重新开机?";
        sysDialog.$cbOnYes = function () {
            var exec = qmlSettings.systemReboot
        }
        sysDialog.$cbOnNo = function() {

        }

        sysDialog.open();
    }

    function execSysShutdown() {
        sysDialog.$text = "系统立即关机?";
        sysDialog.$cbOnYes = function () {
            var exec = qmlSettings.systemShutdown
        }
        sysDialog.open();
    }

    function execSysUpgrade() {

        console.log("upgradeImages");
        var upgradeImages = qmlSettings.systemListUpgradeImages

        sysDialog.$icon = "Warning";
        if ( upgradeImages !== null && upgradeImages.length > 0 ) {
            sysDialog.$text = "侦测到更新档，执行更新?";
            sysDialog.$cbOnYes = function () {
                upgradeProgressDialog.open()
                qmlSettings.systemSysUpgrade = upgradeImages[0];
            }
        } else {
            sysDialog.$text = "未找到更新档,重新侦测?";

            // note : Recursive!?
            sysDialog.$cbOnYes = function () {
                execSysUpgrade();
            }
        }
        sysDialog.open()
    }

    function execResetDefault() {

        //sysDialog.$icon = "Warning";
        sysDialog.$text = "确认回复出厂值?";
        sysDialog.$cbOnYes = function () {
            var result = qmlSettings.systemResetDefault;
            qmlSettings.systemReboot

        }
        sysDialog.$cbOnNo = function () {}
        sysDialog.open()
    }


    MessageDialog {
        id: upgradeProgressDialog
        title: "Upgrade..."
        text: "更新中..."

        standardButtons : StandardButton.NoButton
    }

    AtMessageDialog2 {
        id : sysDialog
        $text : "确认系统立即重新开机!?"
        $cbOnYes : function(){}
        $cbOnNo : function(){}
    }


    AtSettingContent {
        id: systemSetting

        ColumnLayout {
            spacing: 6

            AtButton {
                $name : "重新开机 : "
                $contentName : "执行"
                $cbOnClicked : execSysReboot
            }

            AtButton {
                $name : "系统关机 : "
                $contentName : "执行"
                $cbOnClicked : execSysShutdown

            }

            AtButton {
                $name : "系统更新 : "
                $contentName : "执行"
                $cbOnClicked : execSysUpgrade
            }

            AtButton {
                $name : "恢复出厂值 : "
                $contentName : "执行"
                $cbOnClicked : execResetDefault
            }
        }
    }
}
