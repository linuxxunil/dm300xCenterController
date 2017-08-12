import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {
    $titleName : "影像设定"
    $titleImagePath : "../images/display.ico"

    property bool _init : false
    property var _displayModel : ["1", "2"]
    property var _guiModel : ["Standard", "Customer"]
    property var _isChanged : false



    $cbSaveButton : function() {
        if ( _isChanged ) {
            displayDialog.open()
        } else {
            settingViews.pop()
        }
    }

    AtMessageDialog2 {
        id : displayDialog
        $text: " 关闭该功能，只能使用Uart启动，确定开启!?"

        $cbOnYes: function() {
            qmlSettings.comGeneralGuiIndex = 1
            qmlSettings.systemReboot
        }

        $cbOnNo: function() {
            settingViews.pop()
        }
    }


    AtSettingContent {
        id: displaySetting

        ColumnLayout {
            AtCheckBox {
                id : enable

                text : "启动影像"
                checked : qmlSettings.displayEnableCameraImage
                onCheckedChanged: {
                    qmlSettings.displayEnableCameraImage = checked


                }
            }

            RowLayout {
                visible : enable.checked

                Text {
                    text: '选择影像显示 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : qmlSettings.displayCameraIndex
                    model: _displayModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                        if ( _init ) {
                            qmlSettings.displayCameraIndex = currentIndex
                        } else {
                            _init = true
                        }
                    }
                }
            }

            // For Customer
            RowLayout {
                visible: false
                Text {
                    text: '选用GuiApp : '
                    font.pixelSize: 16
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : qmlSettings.comGeneralGuiIndex
                    model: _guiModel
                    font.pixelSize: 16

                    onPressedChanged: {

                        _isChanged = true
                    }

                    onCurrentIndexChanged : {
                        qmlSettings.comGeneralGuiIndex = currentIndex
                    }
                }
            }
        }
    }
}


