import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {


    $titleName : "缓存输出"
    $titleImagePath : "../images/bufferOutput.ico"
    property var _bufferConditionModel: ["不处理","过滤重复条码", ];
    property var _outputConditionModel: ["SENSOR1_RISING","SENSOR1_FALLING",
                                         "SENSOR2_RISING","SENSOR2_FALLING",
                                         "条码数量"];
    property var _configs : JSON.parse(qmlSettings.bufferOutputConfigs);
    property var _bufferSizeMin : 4096;
    property var _bufferSizeMax : _bufferSizeMin * 8;
    property var _outputConditionAmountMin : 1;
    property var _outputConditionAmountMax : 99;

    function getOutputConditionEnable() {
        var shift =  1 << (outputCondition.currentIndex);
        return parseInt(_configs.outputCondition) & shift;
    }

    function setOutputConditionEnable(value) {
        var setVal = value << outputCondition.currentIndex;
        _configs.outputCondition &= (~(1<<outputCondition.currentIndex));
        _configs.outputCondition |= setVal;
        qmlSettings.bufferOutputConfigs = JSON.stringify(_configs);
    }

    AtMessageDialog2 {
        id : commentDialog
        $text: "仅提供[解码内容s]过滤,[输出格式设定]仅可点选[输出未解码讯息]、[输出双相机资料合并]、[输出解码内容]"
        $onOk : true
    }

    // Content :
    AtSettingContent {
        id : bufferOutputSetting

        ColumnLayout {
            spacing: 6
            RowLayout {
                AtCheckBox {
                    id: enable
                    text: "启用"
                    checked : _configs.enable
                    onCheckedChanged: {
                        _configs.enable = checked;
                        qmlSettings.bufferOutputConfigs = JSON.stringify(_configs);
                    }
                }
            }

            RowLayout {
                visible : enable.checked
                Text {
                    text: '输出条件 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    id : outputCondition
                    width: 200
                    height: 20
                    currentIndex : 0
                    model: _outputConditionModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                        outputConditionEnable.checked = getOutputConditionEnable();
                        console.log(outputCondition.currentIndex);
                    }
                }

                AtCheckBox {
                    id: outputConditionEnable
                    text: "启用"
                    checked : getOutputConditionEnable();
                    onCheckedChanged : {
                        setOutputConditionEnable(checked);
                    }
                }

                Label {
                    visible :(outputCondition.currentIndex == 4) && outputConditionEnable.checked
                    text : "条码数量"
                }

                AtTextInput {
                    visible : (outputCondition.currentIndex == 4) && outputConditionEnable.checked
                    $text : parseInt(_configs.outputConditionAmount)
                    $validator :  IntValidator{bottom:_outputConditionAmountMin;top: _outputConditionAmountMax}
                    $cbOnTextChanged : function(val) {
                        _configs.outputConditionAmount = parseInt(val);
                        qmlSettings.bufferOutputConfigs = JSON.stringify(_configs);
                    }
                }
            }

            RowLayout {
                visible : enable.checked
                Text {
                    text: '缓存条件 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    id : bufferCondition
                    width: 200
                    height: 20
                    currentIndex : parseInt(_configs.bufferCondition)
                    model: _bufferConditionModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                        _configs.bufferCondition = currentIndex;
                        qmlSettings.bufferOutputConfigs = JSON.stringify(_configs);
                    }
                }

                AtButton {
                    id : comment
                    visible : (bufferCondition.currentIndex == 1)
                    $contentName : "使用说明"
                    $cbOnClicked : function() {
                        commentDialog.open();
                    }
                }
            }

            RowLayout {
                visible : enable.checked
                Text {
                    text: '缓存大小(字串长度) : '
                    font.pixelSize: 16
                }

                AtTextInput {
                    $text : _configs.bufferSize
                    $width : 80
                    $validator :  IntValidator{bottom:_bufferSizeMin ; top: _bufferSizeMax;}
                    $cbOnTextChanged : function(val) {
                        _configs.bufferSize = parseInt(val);
                        qmlSettings.bufferOutputConfigs = JSON.stringify(_configs);
                    }
                }
            }
        }
    }

}
