import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'


AtSettingTemplate {
    $titleName : "设定档设定"
    $titleImagePath : "../images/configs.ico"

    property var _configsModel: initConfigsModel()
    property bool _isChanged : false


    function initConfigsModel() {
        var arrayObj = new Array();
        for ( var i=1; i<=qmlSettings.configsSize; i++ ) {
            arrayObj.push(i);
        }
        return arrayObj;
    }

    $cbSaveButton : function() {
        if ( _isChanged ) {
            configsDialog.$text = "系统必须重新启动才会生效,是否立即重启!?";
            configsDialog.$cbOnYes = function() {
                var result = qmlSettings.systemReboot;
            }
            configsDialog.$cbOnNo = function() {
                settingViews.pop();
            }
            configsDialog.open();

        } else {
            settingViews.pop()
        }
    }


    function execConfigsExport() {
        console.log("execConfigsExport")
        if ( qmlSettings.configsExistsExportDisk ) {
            configsDialog.$text = (qmlSettings.configsExecExport===true)?
                        "汇出成功，档案名称为["+qmlSettings.configsConfigsName+"]":"汇出失败,请检查存储装置";

            configsDialog.$cbOnNo = null;
            configsDialog.$cbOnYes = function () {}
        } else {
            configsDialog.$text = "未找存储装置";

            configsDialog.$cbOnNo = null;
            configsDialog.$cbOnYes = function () {}
        }
        configsDialog.open();

    }

    function execConfigsImport() {

        if ( qmlSettings.configsExistsExportDisk ) {
            configsDialog.$text = (qmlSettings.configsExecImport===true)?
                        "汇入成功,功能生效需重新启动":"汇出失败,请检查存储装置";
            configsDialog.$cbOnNo = function() {}
            configsDialog.$cbOnYes = function () {
                var result = qmlSettings.systemReboot
            }
        } else {
            configsDialog.$text = "未找存储装置或设定档["+qmlSettings.configsConfigsName+"];";
            configsDialog.$cbOnNo = null;
            configsDialog.$cbOnYes = function () {}
        }
        configsDialog.open()
    }

    AtMessageDialog2 {
        id : configsDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function(){}
        $cbOnNo : function(){}
    }

    AtSettingContent {
        id: configsSetting

        ColumnLayout {
            RowLayout {
                Text {
                    text: '选择设定档 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    id : configsIndex
                    width: 200
                    height: 20
                    currentIndex : qmlSettings.configsIndex
                    model: _configsModel
                    font.pixelSize: 16
                    onPressedChanged: {
                        _isChanged = true
                    }
                    onCurrentIndexChanged : {
                        qmlSettings.configsIndex = currentIndex
                    }
                }
            }

            AtButton {
                $name : "汇入设定档 : "
                $contentName : "执行"
                $cbOnClicked : execConfigsImport

            }

            AtButton {
                $name : "汇出设定档 : "
                $contentName : "执行"
                $cbOnClicked : execConfigsExport

            }
        }
    }
}
