import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {

    $titleName : "DI设定"
    $titleImagePath : "../images/di.ico"

    property bool d1Visible : false
    property bool d2Visible : false
    property var active : ["LO", "HI"] //需要與C++ Match
    property var edge : ["FALLING", "RISING"] // 需要與C++ Match
    property var init: [false, false, false, false]
    // Content :
    AtSettingContent {
        ColumnLayout {
            spacing: 4
            RowLayout {
                spacing: 6

                AtCheckBox {
                    id: di0
                    text: "启动DI-1"
                    checked : qmlSettings.diEnable0
                    onCheckedChanged: {
                        if ( checked ) {
                            qmlSettings.diEnable0 = true
                        } else {
                            qmlSettings.diEnable0 = false
                        }
                    }
                }

                Text {
                    text : "Active : "
                    visible: di0.checked
                }

                ComboBox {
                    id : di0Active
                    width: 200
                    height: 20
                    currentIndex : qmlSettings.diActive0
                    model: active
                    font.pixelSize: 14
                    visible: di0.checked
                    onCurrentIndexChanged : {
                        qmlSettings.diActive0 = currentIndex
                    }
                }

                Text {
                    text : "Edge : "
                    visible: di0.checked
                }

                ComboBox {
                    id : di0Edge
                    width: 200
                    height: 20
                    model: edge
                    currentIndex : qmlSettings.diEdge0
                    font.pixelSize: 14
                    visible: di0.checked
                    onCurrentIndexChanged : {
                        qmlSettings.diEdge0 = currentIndex
                    }

                }

                Text {
                    text: '过滤抖动 : '
                    font.pixelSize: 16
                    visible: di0.checked && (di0Edge.currentIndex == 0)
                }

                AtSpinBox {
                    id : fallingDebounceTime0
                    value: qmlSettings.diFallingDebounceTime0
                    visible: di0.checked && (di0Edge.currentIndex == 0)
                    onValueChanged: {
                        qmlSettings.diFallingDebounceTime0 = fallingDebounceTime0.value
                    }
                }
            }

            RowLayout {
                spacing: 8

                Text {
                    text: '延迟触发 : '
                    font.pixelSize: 16
                    visible: di0.checked
                }

                AtSpinBox {
                    id : delayTriggerTime0
                    value: qmlSettings.diDelayTriggerTime0
                    visible: di0.checked
                    onValueChanged: {
                        qmlSettings.diDelayTriggerTime0 = delayTriggerTime0.value
                    }
                }

                Text {
                    text: '过滤触发 : '
                    font.pixelSize: 16
                    visible: di0.checked
                }

                AtSpinBox {
                    id : filterTriggerTime0
                    value: qmlSettings.diFilterTriggerTime0
                    visible: di0.checked
                    onValueChanged: {
                        qmlSettings.diFilterTriggerTime0 = filterTriggerTime0.value
                    }
                }
            }

            RowLayout {
                spacing: 6

                AtCheckBox {
                    id: di1
                    text: "启动DI-2"
                    checked : qmlSettings.diEnable1
                    onCheckedChanged: {
                        if ( checked ) {
                            qmlSettings.diEnable1 = true
                        } else {
                            qmlSettings.diEnable1 = false
                        }
                    }

                }

                Text {
                    text : "Active : "
                    visible: di1.checked
                }

                ComboBox {
                    id : di1Active
                    width: 200
                    height: 20
                    model: active
                    currentIndex : qmlSettings.diActive1
                    font.pixelSize: 14
                    visible: di1.checked
                    onCurrentIndexChanged : {
                       qmlSettings.diActive1 = currentIndex
                    }
                }

                Text {
                    text : "Edge : "
                    visible: di1.checked
                }

                ComboBox {
                    id : di1Edge
                    width: 200
                    height: 20
                    model: edge
                    font.pixelSize: 14
                    currentIndex : qmlSettings.diEdge1
                    visible: di1.checked
                    onCurrentIndexChanged : {
                        qmlSettings.diEdge1 = currentIndex
                    }
                }

                Text {
                    text: '过滤抖动 : '
                    font.pixelSize: 16
                    visible: di1.checked && (di1Edge.currentIndex == 0)
                }

                AtSpinBox {
                    id : fallingDebounceTime1
                    value: qmlSettings.diFallingDebounceTime1
                    visible: di1.checked && (di1Edge.currentIndex == 0)
                    onValueChanged: {
                        qmlSettings.diFallingDebounceTime1 = fallingDebounceTime1.value
                    }
                }
            }

            RowLayout {
                spacing: 8

                Text {
                    text: '延迟触发 : '
                    font.pixelSize: 16
                    visible: di1.checked
                }

                AtSpinBox {
                    id : delayTriggerTime1
                    value: qmlSettings.diDelayTriggerTime1
                    visible: di1.checked
                    onValueChanged: {
                        qmlSettings.diDelayTriggerTime1 = delayTriggerTime1.value
                    }
                }

                Text {
                    text: '过滤触发 : '
                    font.pixelSize: 16
                    visible: di1.checked
                }

                AtSpinBox {
                    id : filterTriggerTime1
                    value: qmlSettings.diFilterTriggerTime1
                    visible: di1.checked
                    onValueChanged: {
                        qmlSettings.diFilterTriggerTime1 = filterTriggerTime1.value
                    }
                }

            }
        }
    }
}
