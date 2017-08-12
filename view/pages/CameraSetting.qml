import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {
    $titleName : "相机设定"
    $titleImagePath : "../images/camera.ico"

    property var _cameraModel : ["1", "2"]
    property int _index : 0
    property int _perCycleMsMin0 : 0
    property int _perCycleMsMax0 : 60000
    property int _perCountIntervalMin0 : 0
    property int _perCountIntervalMax0 : 30000
    property int _perCountMin0 : 1
    property int _perCountMax0 : 1000
    property int _perSleepMsMin0 : 0
    property int _perSleepMsMax0 : 60000
    property int _smartTriggerTimeMsMin0 : 0
    property int _smartTriggerTimeMsMax0 : 60000
    // sensor
    property int _sPerCountMin0 : 1
    property int _sPerCountMax0 : 1000
    property int _sPerCountIntervalMin0 : 0
    property int _sPerCountIntervalMax0 : 30000



    AtSettingContent {
        id: cameraSetting

        ColumnLayout {

            RowLayout {
                Text {
                    text: '选择相机 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    id : cameraIndex
                    width: 200
                    height: 20
                    currentIndex : 0
                    model: _cameraModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                    }
                }
            }

            RowLayout {
                spacing: 6
                visible: (cameraIndex.currentIndex == 0)?true:false

                AtCheckBox {
                    text : "启用相机"
                    checked: qmlSettings.cameraEnable0
                    onCheckedChanged: {
                        qmlSettings.cameraEnable0 = checked
                    }
                }

                Text {
                    text: " | "
                    font.pixelSize: 14
                }

                AtCheckBox {
                    id: continueMode0
                    text: "连续模式"
                    checked: qmlSettings.cameraTriggerMode0

                    onCheckedChanged: {
                        qmlSettings.cameraTriggerMode0 = checked
                        continueMode1.checked = checked
                    }
                }

                AtCheckBox {
                    id: smartTrigger0
                    text: "智能触发"
                    checked: qmlSettings.cameraSamrtTriggerEnable0
                    visible: continueMode0.checked
                    onCheckedChanged: {
                       qmlSettings.cameraSamrtTriggerEnable0 = checked
                       smartTrigger1.checked = checked
                    }
                }


            }

            RowLayout {
                spacing: 6
                visible: (cameraIndex.currentIndex == 1)?true:false

                AtCheckBox {
                    text : "启用相机"
                    checked: qmlSettings.cameraEnable1
                    onCheckedChanged: {
                        //console.log(init);
                        qmlSettings.cameraEnable1 = checked
                    }
                }
                Text {
                    text: " | "
                    font.pixelSize: 14
                }

                AtCheckBox {
                    id: continueMode1
                    text: "连续模式"
                    checked: qmlSettings.cameraTriggerMode1
                    onCheckedChanged: {
                        qmlSettings.cameraTriggerMode1 = checked
                        continueMode0.checked = checked
                    }
                }

                AtCheckBox {
                    id: smartTrigger1
                    text: "智能触发"
                    checked: qmlSettings.cameraSamrtTriggerEnable1
                    visible: continueMode1.checked
                    onCheckedChanged: {
                       qmlSettings.cameraSamrtTriggerEnable1 = checked
                       smartTrigger0.checked = checked
                    }
                }
            }

            // Sensor Trigger
            RowLayout {
                spacing: 8
                visible: !continueMode0.checked

                Text {
                    text: '每次拍照几次 : '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    id : sPerCount0
                    $from : _sPerCountMin0
                    $to : _sPerCountMax0
                    value: qmlSettings.cameraSTriggerPerCount0
                    onValueChanged: {
                        qmlSettings.cameraSTriggerPerCount0 = sPerCount0.value
                    }
                }

                Text {
                    text: '拍照间隔毫秒 : '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    id : sPerCountInterval0
                    $from : _sPerCountIntervalMin0
                    $to : _sPerCountIntervalMax0
                    value: qmlSettings.cameraSTriggerPerCountInterval1
                    onValueChanged: {
                        qmlSettings.cameraSTriggerPerCountInterval1 = sPerCountInterval0.value
                    }
                }
            }

            // Continues
            RowLayout {
                spacing: 8
                visible: (continueMode0.checked && !smartTrigger0.checked)

                Text {
                    text: '每次周期毫秒 : '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    id : perCycleMs0
                    $from : _perCycleMsMin0
                    $to : _perCycleMsMax0
                    value: qmlSettings.cameraContinuesPerCycleMs0
                    onValueChanged: {
                        qmlSettings.cameraContinuesPerCycleMs0 = perCycleMs0.value
                    }
                }

                Text {
                    text: '每次周期几次 : '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    id : perCount0
                    $from : _perCountMin0
                    $to : _perCountMax0
                    value: qmlSettings.cameraContinuesPerCount0
                    onValueChanged: {
                        qmlSettings.cameraContinuesPerCount0 = perCount0.value
                    }
                }
            }

            RowLayout {
                spacing: 8
                visible: (continueMode0.checked && !smartTrigger0.checked)
                Text {
                    text: '周期间隔毫秒 : '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    id : perCountInterval0
                    $from : _perCountIntervalMin0
                    $to : _perCountIntervalMax0
                    value: qmlSettings.cameraContinuesPerCountInterval0
                    onValueChanged: {
                        qmlSettings.cameraContinuesPerCountInterval0 = perCountInterval0.value
                    }
                }

                Text {
                    text: '周期后停毫秒 : '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    id : perSleepMs0
                    $from : _perSleepMsMin0
                    $to : _perSleepMsMax0
                    value: qmlSettings.cameraContinuesSleepMs0
                    onValueChanged: {
                        qmlSettings.cameraContinuesSleepMs0 = perSleepMs0.value
                    }
                }
            }

            // Smart Trigger
            RowLayout {
                spacing: 8
                visible: (continueMode0.checked && smartTrigger0.checked)
                Text {
                    text: '未读到秒数: '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    id : smartTriggerTime
                    $from : _smartTriggerTimeMsMin0
                    $to : _smartTriggerTimeMsMax0
                    value: qmlSettings.cameraSmartTriggerTime0
                    onValueChanged: {
                        qmlSettings.cameraSmartTriggerTime0 = smartTriggerTime.value
                    }
                }
            }
        }
    }
}
